import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ng_motorista/authentication/signup_screen.dart';
import '/authentication/signup_screen_driver.dart';
import '../global/global_var.dart';
import '../widgets/loading_dialog.dart';

class LoginScreenDriver extends StatefulWidget {
  const LoginScreenDriver({super.key});

  @override
  State<LoginScreenDriver> createState() => _LoginScreenDriverState();
}

class _LoginScreenDriverState extends State<LoginScreenDriver> {
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  CommonMethods cMethods = CommonMethods();

  bool _isVerifying = false;
  bool _showCodeInput = false;
  String _verificationId = '';
  String? _phoneNumber;

  @override
  void dispose() {
    phoneTextEditingController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);
    loginFormValidation();
  }

  loginFormValidation() {
    if (phoneTextEditingController.text.trim().length < 10) {
      cMethods.displaySnackBar(
        "Por favor, insira um telefone válido com DDD.",
        context,
      );
    } else {
      if (!_showCodeInput) {
        // Inicia verificação por SMS
        sendVerificationCode();
      } else {
        // Verifica o código
        verifySMSCode();
      }
    }
  }

  sendVerificationCode() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Enviando código SMS..."),
    );

    try {
      _phoneNumber = phoneTextEditingController.text.trim();

      // Configuração do Firebase Auth para verificação por SMS
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+55$_phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verificação (se o dispositivo conseguir)
          await FirebaseAuth.instance.signInWithCredential(credential);
          if (!context.mounted) return;
          Navigator.pop(context);
          verifyDriverInDatabase();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!context.mounted) return;
          Navigator.pop(context);
          cMethods.displaySnackBar(
            "Falha na verificação: ${e.message}",
            context,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!context.mounted) return;
          Navigator.pop(context);
          setState(() {
            _verificationId = verificationId;
            _showCodeInput = true;
          });
          cMethods.displaySnackBar(
            "Código enviado para $_phoneNumber",
            context,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout - pode pedir para reenviar
          setState(() {
            _verificationId = verificationId;
          });
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (errorMsg) {
      if (!context.mounted) return;
      Navigator.pop(context);
      cMethods.displaySnackBar(
        errorMsg.toString().replaceAll("Exception: ", ""),
        context,
      );
    }
  }

  verifySMSCode() async {
    if (verificationCodeController.text.trim().length != 6) {
      cMethods.displaySnackBar(
        "Por favor, insira o código de 6 dígitos.",
        context,
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Verificando código..."),
    );

    try {
      // Cria credencial com código SMS
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: verificationCodeController.text.trim(),
      );

      // Faz login com a credencial
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!context.mounted) return;
      Navigator.pop(context);
      verifyDriverInDatabase();
    } catch (errorMsg) {
      if (!context.mounted) return;
      Navigator.pop(context);
      cMethods.displaySnackBar(
        "Código inválido. Tente novamente.",
        context,
      );
    }
  }

  verifyDriverInDatabase() async {
    final User? userFirebase = FirebaseAuth.instance.currentUser;

    if (userFirebase != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            LoadingDialog(messageText: "Verificando cadastro..."),
      );

      try {
        // Verifica no Realtime Database se o motorista existe
        DatabaseReference driversRef = FirebaseDatabase.instance
            .ref()
            .child("drivers")
            .child(userFirebase.uid);

        await driversRef.once().then((snap) {
          if (snap.snapshot.value != null) {
            final driverData = snap.snapshot.value as Map;

            // Verifica status de bloqueio
            if (driverData["blockStatus"] == "no") {
              // Verifica se os documentos foram aprovados
              if (driverData["documentsApproved"] == true) {
                // Motorista aprovado - carrega dados globais
                userName = driverData["name"];
                userPhone = driverData["phone"];
                userID = userFirebase.uid;

                // Carrega dados específicos do motorista
                driverVehicleType = driverData["vehicleType"] ?? "Carro";
                driverVehiclePlate = driverData["vehiclePlate"] ?? "";
                driverVehicleModel = driverData["vehicleModel"] ?? "";
                driverVehicleColor = driverData["vehicleColor"] ?? "";
                driverRating = driverData["rating"] ?? 4.97;
                driverTotalDeliveries = driverData["totalDeliveries"] ?? 0;
                driverYears = driverData["years"] ?? 0;
                driverAcceptanceRate = driverData["acceptanceRate"] ?? 51;
                driverCompletionRate = driverData["completionRate"] ?? 96;
                driverWalletBalance = driverData["walletBalance"] ?? 0.0;

                if (!context.mounted) return;
                Navigator.pop(context);

                // Navega para tela de verificação facial (como no main.dart)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => FacialVerificationScreen()),
                );
              } else {
                // Documentos não aprovados
                FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.pop(context);
                cMethods.displaySnackBar(
                  "Seus documentos estão em análise. Aguarde a aprovação.",
                  context,
                );
              }
            } else {
              // Motorista bloqueado
              FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pop(context);
              cMethods.displaySnackBar(
                "Você está bloqueado. Contate o administrador: suporte@ngmotorista.com",
                context,
              );
            }
          } else {
            // Motorista não cadastrado
            FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
            Navigator.pop(context);
            cMethods.displaySnackBar(
              "Cadastro não encontrado. Faça o cadastro primeiro.",
              context,
            );
          }
        });
      } catch (errorMsg) {
        if (!context.mounted) return;
        Navigator.pop(context);
        cMethods.displaySnackBar(
          "Erro ao verificar cadastro: ${errorMsg.toString()}",
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 40),

            // Logo do app motorista
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.local_shipping,
                  size: 60,
                  color: Colors.orange[400],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'MOTORISTA NG',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange[400],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Faça entregas e ganhe dinheiro',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),

            // Botões de alternância
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => SignUpScreenDriver()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            if (!_showCodeInput)
              // Campo de telefone
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
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
                          Text(
                            '🇧🇷',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '+55',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '(00) 00000-0000',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            else
              // Campo do código de verificação
              Column(
                children: [
                  Text(
                    'Digite o código enviado para',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+55 $_phoneNumber',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 45,
                        height: 60,
                        child: TextField(
                          controller: index <
                                  verificationCodeController.text.length
                              ? TextEditingController(
                                  text: verificationCodeController.text[index])
                              : TextEditingController(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.orange[400]!),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              String newCode = verificationCodeController.text;
                              if (newCode.length < 6) {
                                verificationCodeController.text =
                                    newCode + value;
                                if (verificationCodeController.text.length ==
                                    6) {
                                  // Foca no próximo campo ou valida automaticamente
                                  FocusScope.of(context).unfocus();
                                  verifySMSCode();
                                }
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não recebeu o código?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: sendVerificationCode,
                        child: Text(
                          'Reenviar',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            SizedBox(height: 24),

            // Botão de continuar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: checkIfNetworkIsAvailable,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18),
                ),
                child: Text(
                  _showCodeInput ? 'Verificar Código' : 'Continuar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Divisor
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300])),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('ou', style: TextStyle(color: Colors.grey[500])),
                ),
                Expanded(child: Divider(color: Colors.grey[300])),
              ],
            ),
            SizedBox(height: 24),

            // Link para cadastro se estiver na tela de código
            if (_showCodeInput)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showCodeInput = false;
                    verificationCodeController.clear();
                  });
                },
                child: Text(
                  'Voltar para alterar número',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )
            else
              // Link para cadastro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => SignUpScreenDriver()),
                  );
                },
                child: Text(
                  'Primeiro acesso? Cadastre-se aqui',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

            SizedBox(height: 40),

            // Termos de uso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Ao fazer login, você concorda com nossos Termos de Uso e Política de Privacidade',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
