import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:ng_motorista/authentication/login_screen.dart';
import '../global/global_var.dart';
import '/widgets/loading_dialog.dart';

class SignUpScreenDriver extends StatefulWidget {
  const SignUpScreenDriver({super.key});

  @override
  State<SignUpScreenDriver> createState() => _SignUpScreenDriverState();
}

class _SignUpScreenDriverState extends State<SignUpScreenDriver> {
  // Controllers para informações pessoais
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  // Controllers para informações do veículo
  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController vehicleYearController = TextEditingController();

  // Controllers para documentos
  TextEditingController cnhNumberController = TextEditingController();
  TextEditingController cnhExpiryController = TextEditingController();

  // Imagens dos documentos
  File? _crlvImage;
  File? _cnhFrontImage;
  File? _cnhBackImage;
  File? _selfieImage;

  CommonMethods cMethods = CommonMethods();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Etapas do cadastro
  int _currentStep = 0;
  List<String> _stepTitles = [
    'Informações Pessoais',
    'Documentos',
    'Veículo',
    'Finalizar'
  ];

  // Tipo de veículo selecionado
  String _selectedVehicleType = 'carro';

  // Status de upload dos documentos
  bool _crlvUploaded = false;
  bool _cnhUploaded = false;
  bool _selfieUploaded = false;

  @override
  void dispose() {
    nameTextEditingController.dispose();
    phoneTextEditingController.dispose();
    emailTextEditingController.dispose();
    birthDateController.dispose();
    vehiclePlateController.dispose();
    vehicleModelController.dispose();
    vehicleColorController.dispose();
    vehicleYearController.dispose();
    cnhNumberController.dispose();
    cnhExpiryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, String documentType) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        File imageFile = File(pickedFile.path);

        switch (documentType) {
          case 'crlv':
            _crlvImage = imageFile;
            _crlvUploaded = true;
            break;
          case 'cnh_front':
            _cnhFrontImage = imageFile;
            break;
          case 'cnh_back':
            _cnhBackImage = imageFile;
            if (_cnhFrontImage != null && _cnhBackImage != null) {
              _cnhUploaded = true;
            }
            break;
          case 'selfie':
            _selfieImage = imageFile;
            _selfieUploaded = true;
            break;
        }
      });
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0: // Informações pessoais
        if (nameTextEditingController.text.trim().isEmpty ||
            phoneTextEditingController.text.trim().isEmpty ||
            emailTextEditingController.text.trim().isEmpty ||
            birthDateController.text.trim().isEmpty) {
          cMethods.displaySnackBar(
              "Preencha todas as informações pessoais.", context);
          return false;
        }
        if (phoneTextEditingController.text.trim().length < 10) {
          cMethods.displaySnackBar("Telefone inválido. Inclua o DDD.", context);
          return false;
        }
        if (!emailTextEditingController.text.contains("@")) {
          cMethods.displaySnackBar("E-mail inválido.", context);
          return false;
        }
        return true;

      case 1: // Documentos
        if (!_crlvUploaded || !_cnhUploaded || !_selfieUploaded) {
          cMethods.displaySnackBar(
              "Faça upload de todos os documentos obrigatórios.", context);
          return false;
        }
        return true;

      case 2: // Veículo
        if (vehiclePlateController.text.trim().isEmpty ||
            vehicleModelController.text.trim().isEmpty ||
            vehicleColorController.text.trim().isEmpty ||
            vehicleYearController.text.trim().isEmpty) {
          cMethods.displaySnackBar(
              "Preencha todas as informações do veículo.", context);
          return false;
        }
        return true;

      case 3: // Finalizar
        return true;

      default:
        return false;
    }
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      if (_currentStep < _stepTitles.length - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        _registerDriver();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _registerDriver() async {
    if (!_validateCurrentStep()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Cadastrando motorista..."),
    );

    try {
      // 1. Primeiro verifica o telefone por SMS
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+55${phoneTextEditingController.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _completeRegistration(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!context.mounted) return;
          Navigator.pop(context);
          cMethods.displaySnackBar(
              "Falha na verificação: ${e.message}", context);
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!context.mounted) return;
          Navigator.pop(context);
          _showVerificationCodeDialog(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 60),
      );
    } catch (errorMsg) {
      if (!context.mounted) return;
      Navigator.pop(context);
      cMethods.displaySnackBar(
        "Erro no cadastro: ${errorMsg.toString()}",
        context,
      );
    }
  }

  void _showVerificationCodeDialog(String verificationId) {
    TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Verificação por SMS"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Digite o código de 6 dígitos enviado para:"),
            SizedBox(height: 8),
            Text(
              "+55 ${phoneTextEditingController.text.trim()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange[600],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: InputDecoration(
                hintText: "000000",
                counterText: "",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (codeController.text.length == 6) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text,
                );
                await _completeRegistration(credential);
                if (context.mounted) Navigator.pop(context);
              } else {
                cMethods.displaySnackBar("Código inválido", context);
              }
            },
            child: Text("Verificar"),
          ),
        ],
      ),
    );
  }

  Future<void> _completeRegistration(PhoneAuthCredential credential) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Finalizando cadastro..."),
    );

    try {
      // Cria usuário com autenticação por telefone
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Salva dados do motorista no Realtime Database
      DatabaseReference driversRef = FirebaseDatabase.instance
          .ref()
          .child("drivers")
          .child(userCredential.user!.uid);

      Map<String, dynamic> driverData = {
        "name": nameTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "birthDate": birthDateController.text.trim(),
        "vehicleType": _selectedVehicleType,
        "vehiclePlate": vehiclePlateController.text.trim().toUpperCase(),
        "vehicleModel": vehicleModelController.text.trim(),
        "vehicleColor": vehicleColorController.text.trim(),
        "vehicleYear": vehicleYearController.text.trim(),
        "cnhNumber": cnhNumberController.text.trim(),
        "cnhExpiry": cnhExpiryController.text.trim(),
        "id": userCredential.user!.uid,
        "blockStatus": "no",
        "documentsApproved": false, // Inicialmente false, admin aprova
        "documentsUnderReview": true,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "walletBalance": 0.0,
        "profileImage": "", // URL da selfie será atualizada depois
        "rating": 0.0,
        "totalDeliveries": 0,
        "years": 0,
        "acceptanceRate": 0,
        "completionRate": 0,
        "userType": "driver",
        "isOnline": false,
        "currentLocation": null,
        "activeVehicle": _selectedVehicleType,
      };

      await driversRef.set(driverData);

      // Salva nas variáveis globais
      userName = nameTextEditingController.text.trim();
      userPhone = phoneTextEditingController.text.trim();
      userID = userCredential.user!.uid;
      driverVehicleType = _selectedVehicleType;
      driverVehiclePlate = vehiclePlateController.text.trim().toUpperCase();
      driverVehicleModel = vehicleModelController.text.trim();
      driverVehicleColor = vehicleColorController.text.trim();

      if (!context.mounted) return;
      Navigator.pop(context);

      // Mostra mensagem de sucesso
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Cadastro realizado!"),
          content: Text(
            "Seu cadastro foi enviado para análise. "
            "Aguarde a aprovação dos documentos para começar a trabalhar. "
            "Você receberá uma notificação por e-mail quando for aprovado.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (c) => LoginScreenDriver()),
                  (route) => false,
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (errorMsg) {
      if (!context.mounted) return;
      Navigator.pop(context);
      cMethods.displaySnackBar(
        "Erro ao finalizar cadastro: ${errorMsg.toString()}",
        context,
      );
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _stepTitles.asMap().entries.map((entry) {
          int index = entry.key;
          String title = entry.value;

          bool isActive = index == _currentStep;
          bool isCompleted = index < _currentStep;

          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.orange[400]
                        : isCompleted
                            ? Colors.green[400]
                            : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, size: 16, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive ? Colors.orange[600] : Colors.grey[500],
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameTextEditingController,
            decoration: InputDecoration(
              labelText: 'Nome Completo',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite seu nome completo';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Text('🇧🇷', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 4),
                      Text('+55',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '(00) 00000-0000',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Digite seu telefone';
                      }
                      if (value.trim().length < 10) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: emailTextEditingController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite seu e-mail';
              }
              if (!value.contains('@')) {
                return 'E-mail inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: birthDateController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: 'Data de Nascimento',
              prefixIcon: Icon(Icons.calendar_today),
              hintText: 'DD/MM/AAAA',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite sua data de nascimento';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsStep() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Selfie para verificação facial
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selfieUploaded ? Colors.green[300]! : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.face,
                      color: _selfieUploaded
                          ? Colors.green[600]
                          : Colors.orange[600],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selfie para Verificação Facial',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selfieUploaded
                                  ? Colors.green[600]
                                  : Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Tire uma selfie clara e com boa iluminação',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_selfieUploaded)
                      Icon(Icons.check_circle, color: Colors.green[600]),
                  ],
                ),
                SizedBox(height: 16),
                if (_selfieImage != null)
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(_selfieImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt,
                            size: 40, color: Colors.grey[400]),
                        SizedBox(height: 8),
                        Text(
                          'Clique para tirar uma selfie',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _pickImage(ImageSource.camera, 'selfie'),
                        icon: Icon(Icons.camera_alt),
                        label: Text('Tirar Selfie'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    if (_selfieImage != null)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              _pickImage(ImageSource.gallery, 'selfie'),
                          icon: Icon(Icons.photo_library),
                          label: Text('Alterar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // CRLV
          _buildDocumentUploadCard(
            title: 'CRLV-e (Documento do Veículo)',
            description: 'Foto do documento do veículo atualizado',
            icon: Icons.description,
            isUploaded: _crlvUploaded,
            onUpload: () => _pickImage(ImageSource.camera, 'crlv'),
            image: _crlvImage,
          ),

          // CNH frente e verso
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _cnhUploaded ? Colors.green[300]! : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      color:
                          _cnhUploaded ? Colors.green[600] : Colors.orange[600],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CNH com EAR (Carteira Nacional de Habilitação)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _cnhUploaded
                                  ? Colors.green[600]
                                  : Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Frente e verso da CNH',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_cnhUploaded)
                      Icon(Icons.check_circle, color: Colors.green[600]),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: cnhNumberController,
                  decoration: InputDecoration(
                    labelText: 'Número da CNH',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: cnhExpiryController,
                  decoration: InputDecoration(
                    labelText: 'Validade da CNH',
                    hintText: 'MM/AAAA',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Frente', style: TextStyle(fontSize: 12)),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () =>
                                _pickImage(ImageSource.camera, 'cnh_front'),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                                image: _cnhFrontImage != null
                                    ? DecorationImage(
                                        image: FileImage(_cnhFrontImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _cnhFrontImage == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.photo_camera,
                                            color: Colors.grey[400]),
                                        Text('Frente',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Verso', style: TextStyle(fontSize: 12)),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () =>
                                _pickImage(ImageSource.camera, 'cnh_back'),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                                image: _cnhBackImage != null
                                    ? DecorationImage(
                                        image: FileImage(_cnhBackImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _cnhBackImage == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.photo_camera,
                                            color: Colors.grey[400]),
                                        Text('Verso',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _pickImage(ImageSource.camera, 'cnh_front');
                          _pickImage(ImageSource.camera, 'cnh_back');
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Tirar Fotos'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _pickImage(ImageSource.gallery, 'cnh_front');
                          _pickImage(ImageSource.gallery, 'cnh_back');
                        },
                        icon: Icon(Icons.photo_library),
                        label: Text('Galeria'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isUploaded,
    required VoidCallback onUpload,
    required File? image,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUploaded ? Colors.green[300]! : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isUploaded ? Colors.green[600] : Colors.orange[600],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            isUploaded ? Colors.green[600] : Colors.grey[700],
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              if (isUploaded)
                Icon(Icons.check_circle, color: Colors.green[600]),
            ],
          ),
          SizedBox(height: 16),
          if (image != null)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: FileImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 40, color: Colors.grey[400]),
                  SizedBox(height: 8),
                  Text(
                    'Clique para fazer upload',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(
                      ImageSource.camera, title.contains('CRLV') ? 'crlv' : ''),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Tirar Foto'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onUpload,
                  icon: Icon(Icons.photo_library),
                  label: Text('Galeria'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleStep() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Tipo de veículo
          Text(
            'Tipo de Veículo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: Text('Carro'),
                  selected: _selectedVehicleType == 'carro',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedVehicleType = 'carro';
                      });
                    }
                  },
                  selectedColor: Colors.orange[400],
                  labelStyle: TextStyle(
                    color: _selectedVehicleType == 'carro'
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ChoiceChip(
                  label: Text('Moto'),
                  selected: _selectedVehicleType == 'moto',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedVehicleType = 'moto';
                      });
                    }
                  },
                  selectedColor: Colors.orange[400],
                  labelStyle: TextStyle(
                    color: _selectedVehicleType == 'moto'
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Placa do veículo
          TextFormField(
            controller: vehiclePlateController,
            decoration: InputDecoration(
              labelText: 'Placa do Veículo',
              hintText: 'ABC-1234',
              prefixIcon: Icon(Icons.confirmation_number),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            textCapitalization: TextCapitalization.characters,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite a placa do veículo';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Modelo do veículo
          TextFormField(
            controller: vehicleModelController,
            decoration: InputDecoration(
              labelText: 'Modelo do Veículo',
              hintText: 'Ex: Toyota Corolla, Honda CG 160',
              prefixIcon: Icon(Icons.directions_car),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite o modelo do veículo';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Cor do veículo
          TextFormField(
            controller: vehicleColorController,
            decoration: InputDecoration(
              labelText: 'Cor do Veículo',
              hintText: 'Ex: Prata, Preto, Branco',
              prefixIcon: Icon(Icons.color_lens),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite a cor do veículo';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Ano do veículo
          TextFormField(
            controller: vehicleYearController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Ano do Veículo',
              hintText: 'Ex: 2022',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Digite o ano do veículo';
              }
              return null;
            },
          ),

          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange[600]),
                    SizedBox(width: 8),
                    Text(
                      'Importante',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Certifique-se de que todos os dados do veículo estão corretos '
                  'e correspondem ao CRLV-e enviado anteriormente. '
                  'Divergências podem causar reprovação do cadastro.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.green[600],
                ),
                SizedBox(height: 16),
                Text(
                  'Pronto para finalizar!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Revise os dados abaixo antes de finalizar o cadastro:',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Resumo das informações
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumo do Cadastro',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                _buildSummaryItem('Nome:', nameTextEditingController.text),
                _buildSummaryItem(
                    'Telefone:', '+55 ${phoneTextEditingController.text}'),
                _buildSummaryItem('E-mail:', emailTextEditingController.text),
                _buildSummaryItem('Data Nasc:', birthDateController.text),
                Divider(height: 24),
                _buildSummaryItem('Tipo Veículo:',
                    _selectedVehicleType == 'carro' ? 'Carro' : 'Moto'),
                _buildSummaryItem(
                    'Placa:', vehiclePlateController.text.toUpperCase()),
                _buildSummaryItem('Modelo:', vehicleModelController.text),
                _buildSummaryItem('Cor:', vehicleColorController.text),
                _buildSummaryItem('Ano:', vehicleYearController.text),
                Divider(height: 24),
                _buildSummaryItem(
                    'Documentos:',
                    '${_crlvUploaded ? '✓' : '✗'} CRLV | '
                        '${_cnhUploaded ? '✓' : '✗'} CNH | '
                        '${_selfieUploaded ? '✓' : '✗'} Selfie'),
              ],
            ),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange[600]),
                    SizedBox(width: 8),
                    Text(
                      'Atenção',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Após o cadastro, seus documentos serão analisados pela nossa equipe. '
                  'Este processo pode levar até 48 horas. '
                  'Você receberá uma notificação por e-mail quando seu cadastro for aprovado.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Checkbox de termos
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: false, // Será controlado em produção
                onChanged: (value) {},
                activeColor: Colors.orange[400],
              ),
              Expanded(
                child: Text(
                  'Declaro que todas as informações fornecidas são verdadeiras '
                  'e concordo com os Termos de Uso e Política de Privacidade da NG Motorista.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: _previousStep,
        ),
        title: Text('Cadastro Motorista'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildStepIndicator(),
              SizedBox(height: 24),

              // Conteúdo da etapa atual
              if (_currentStep == 0) _buildPersonalInfoStep(),
              if (_currentStep == 1) _buildDocumentsStep(),
              if (_currentStep == 2) _buildVehicleStep(),
              if (_currentStep == 3) _buildFinalStep(),

              SizedBox(height: 32),

              // Botões de navegação
              Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousStep,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text('Voltar'),
                      ),
                    ),
                  if (_currentStep > 0) SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _currentStep == _stepTitles.length - 1
                            ? 'Finalizar Cadastro'
                            : 'Próximo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Indicador de progresso
              Text(
                'Etapa ${_currentStep + 1} de ${_stepTitles.length}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
