import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NG Motorista',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange[600]!,
              Colors.orange[500]!,
              Colors.deepOrange[400]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/logo.jpeg',
                    width: 125,
                    height: 125,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        'NG',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Motorista NG',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 180),
              Text(
                'Motorista NG',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Bem-vindo(a) à',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Motorista NG!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Faça entregas e ganhe dinheiro de forma simples e segura.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 60),
                // Logo centralizada
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/logo.jpeg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 210),

                // Botões lado a lado
                Row(
                  children: [
                    // Botão Entrar
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhoneLoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          minimumSize: Size(double.infinity, 0),
                        ),
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Botão Cadastrar
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhoneRegistrationScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Colors.orange[400]!, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          minimumSize: Size(double.infinity, 0),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.orange[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Ao se cadastrar ou acessar sua conta, você concorda com nossos\nTermos de Uso e Política de Privacidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TELA DE LOGIN APENAS COM TELEFONE
class PhoneLoginScreen extends StatefulWidget {
  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Entrar'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Digite seu telefone',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Faça login com seu número de telefone cadastrado',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                          controller: _phoneController,
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
                ),
                SizedBox(height: 20),
                Text(
                  'Exemplo: (11) 98765-4321',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_phoneController.text.isNotEmpty) {
                            setState(() {
                              _isLoading = true;
                            });
                            // Simular verificação e ir para verificação facial
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FacialVerificationScreen(),
                                ),
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Digite seu número de telefone'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Próximo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                SizedBox(height: 20),
                // Link para cadastro
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneRegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Primeiro acesso? Cadastre-se aqui',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TELA DE VERIFICAÇÃO FACIAL
class FacialVerificationScreen extends StatefulWidget {
  @override
  _FacialVerificationScreenState createState() =>
      _FacialVerificationScreenState();
}

class _FacialVerificationScreenState extends State<FacialVerificationScreen> {
  bool _isVerifying = false;
  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Verificação Facial'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verificação de Segurança',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Para sua segurança, precisamos confirmar que é realmente você',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60),

              // Ícone/Imagem da verificação facial
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _isVerified
                      ? Colors.green[50]
                      : _isVerifying
                          ? Colors.orange[50]
                          : Colors.grey[50],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isVerified
                        ? Colors.green[200]!
                        : _isVerifying
                            ? Colors.orange[200]!
                            : Colors.grey[200]!,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Icon(
                    _isVerified
                        ? Icons.verified
                        : _isVerifying
                            ? Icons.face_retouching_natural
                            : Icons.face,
                    size: 80,
                    color: _isVerified
                        ? Colors.green[600]
                        : _isVerifying
                            ? Colors.orange[600]
                            : Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(height: 40),

              if (_isVerified)
                Column(
                  children: [
                    Text(
                      '✅ Verificado com sucesso!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Após verificação facial, ir para tela de conexão
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConnectScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18),
                        minimumSize: Size(double.infinity, 0),
                      ),
                      child: Text(
                        'Ir para o Mapa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              else if (_isVerifying)
                Column(
                  children: [
                    Text(
                      '🔍 Analisando seu rosto...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[600],
                      ),
                    ),
                    SizedBox(height: 20),
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.orange[400]!),
                    ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVerifying = true;
                    });
                    // Simular processo de verificação facial
                    Future.delayed(Duration(seconds: 3), () {
                      setState(() {
                        _isVerifying = false;
                        _isVerified = true;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                  ),
                  child: Text(
                    'Iniciar Verificação Facial',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              SizedBox(height: 30),
              if (!_isVerified && !_isVerifying)
                Text(
                  'Posicione seu rosto dentro do círculo na câmera',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// TELA DE CONEXÃO (com permissões após cadastro)
class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  bool _isOnline = false;
  bool _showPermissions = false;

  @override
  Widget build(BuildContext context) {
    if (_showPermissions) {
      return PermissionsScreen(
        onComplete: () {
          setState(() {
            _showPermissions = false;
          });
          // Após permissões, ir para a tela principal do app
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MapScreen()),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Cabeçalho
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Text(
                        'N',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Natanael',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                '4.97 ★',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),

              // Áreas de entrega
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    // Seção de ganhos
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'R\$0,00',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Ganhos de hoje',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Áreas de entrega
                    Text(
                      'Áreas com alta demanda',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildAreaItem('Shopping', '1.1~1.3x', 'Alta'),
                    _buildAreaItem('TABOLEI', '1.2~2.0x', 'Média'),
                    _buildAreaItem('JARDIM I', '1.2~1.6x', 'Alta'),
                    _buildAreaItem(
                        'Uniavan Av. Marginal Oeste', '1.5~2.2x', 'Média'),
                    _buildAreaItem('Rio Pecan', '1.1~1.8x', 'Baixa'),
                  ],
                ),
              ),

              // Botão conectar
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isOnline = true;
                          // Mostrar permissões apenas se for a primeira vez
                          _showPermissions = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18),
                        minimumSize: Size(double.infinity, 0),
                      ),
                      child: Text(
                        'Conectar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Status centralizado
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAreaItem(String name, String multiplier, String demand) {
    Color demandColor;
    switch (demand) {
      case 'Alta':
        demandColor = Colors.red[400]!;
        break;
      case 'Média':
        demandColor = Colors.orange[400]!;
        break;
      default:
        demandColor = Colors.green[400]!;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: demandColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Demanda: $demand',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Text(
              multiplier,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TELA DE PERMISSÕES
class PermissionsScreen extends StatefulWidget {
  final VoidCallback onComplete;

  PermissionsScreen({required this.onComplete});

  @override
  _PermissionsScreenState createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  int _currentPermission = 0;
  List<Map<String, dynamic>> _permissions = [
    {
      'title': 'Permitir a localização deste dispositivo?',
      'options': ['Durante o uso do app', 'Apenas esta vez', 'Não permitir'],
      'type': 'location',
    },
    {
      'title': 'Configure as permissões de localização como "Sempre permitir"',
      'description':
          'Isso ajudará a evitar cálculo incorreto de tarifas, local de embarque impreciso e solicitações de entregas muito distantes.',
      'options': ['Permitir', 'Cancelar'],
      'type': 'always_location',
    },
    {
      'title': 'Política de Privacidade e Uso NG Motorista',
      'description':
          'Antes de usar os produtos ou serviços NG Motorista, leia atentamente os Termos de Uso, as regras da plataforma e a Política de Privacidade. Ao tocar em "Concordo" e usar nossos produtos e serviços, você confirma que leu, entendeu e concorda em agir de acordo com os termos.',
      'options': ['Concordo', 'Sair'],
      'type': 'privacy',
    },
    {
      'title': 'Lembrete: solicitações de entregas',
      'description':
          'Detectamos que suas configurações atuais de bateria podem impedir você de receber solicitações de entregas. Para que as solicitações de entregas sejam recebidas adequadamente, você deve permitir a execução deste aplicativo em segundo plano.',
      'options': ['Permitir', 'Não permitir'],
      'type': 'background',
    },
  ];

  void _handlePermissionSelection(int optionIndex) {
    if (_currentPermission < _permissions.length - 1) {
      setState(() {
        _currentPermission++;
      });
    } else {
      // Todas as permissões concedidas
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    var permission = _permissions[_currentPermission];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_currentPermission > 0)
                IconButton(
                  onPressed: () {
                    if (_currentPermission > 0) {
                      setState(() {
                        _currentPermission--;
                      });
                    }
                  },
                  icon: Icon(Icons.chevron_left),
                ),
              SizedBox(height: 20),

              // Logo
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/logo.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Título
              Text(
                permission['title'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),

              // Descrição (se existir)
              if (permission['description'] != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    permission['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

              // Opções específicas para localização
              if (permission['type'] == 'location')
                Column(
                  children: [
                    _buildLocationOption('Exata', true),
                    SizedBox(height: 16),
                    _buildLocationOption('Aproximada', false),
                    SizedBox(height: 30),
                  ],
                ),

              // Botões de opções
              ...permission['options'].asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;

                bool isPrimary = (permission['type'] == 'location' &&
                        index == 0) ||
                    (permission['type'] == 'always_location' && index == 0) ||
                    (permission['type'] == 'privacy' && index == 0) ||
                    (permission['type'] == 'background' && index == 0);

                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () => _handlePermissionSelection(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isPrimary ? Colors.orange[400] : Colors.white,
                      foregroundColor: isPrimary ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: isPrimary
                            ? BorderSide.none
                            : BorderSide(color: Colors.grey[300]!),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18),
                      minimumSize: Size(double.infinity, 0),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Contador de progresso
              SizedBox(height: 30),
              Center(
                child: Text(
                  '${_currentPermission + 1}/${_permissions.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationOption(String type, bool isExact) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(
            isExact ? Icons.location_pin : Icons.location_searching,
            color: Colors.orange[600],
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                if (isExact)
                  Text(
                    'Permite localização precisa',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          Radio(
            value: isExact,
            groupValue: true,
            onChanged: (value) {},
            activeColor: Colors.orange[400],
          ),
        ],
      ),
    );
  }
}

class CustomDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Se o texto está vazio, retorna vazio
    if (newText.isEmpty) {
      return newValue;
    }

    // Remove tudo que não é dígito
    String digitsOnly = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita a 8 dígitos
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    // Formata o texto
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += digitsOnly[i];
    }

    // Calcula a posição do cursor
    int cursorPosition = formatted.length;

    // Se o usuário apagou um caractere, ajusta a posição do cursor
    if (newText.length < oldValue.text.length) {
      cursorPosition = newValue.selection.baseOffset;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

// TELA DO MAPA (Primeira tela após login)
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabeçalho simplificado
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.orange[400],
            child: SafeArea(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryDriverApp(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            'N',
                            style: TextStyle(
                              color: Colors.orange[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Natanael',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  '4.97 ★',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  // Status online no cabeçalho
                ],
              ),
            ),
          ),

          // Mapa principal
          Expanded(
            child: Stack(
              children: [
                // Simulação do mapa
                Container(
                  color: Colors.grey[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 100, color: Colors.grey[300]),
                        SizedBox(height: 16),
                        Text(
                          _isOnline
                              ? 'Aguardando entregas...'
                              : 'Conecte-se para receber entregas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 8),
                        if (!_isOnline)
                          Text(
                            'Toque no botão "Conectar" abaixo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Áreas de entrega (quando online)
                if (_isOnline)
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 180,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_shipping,
                                  size: 16, color: Colors.orange[600]),
                              SizedBox(width: 8),
                              Text(
                                'Áreas em Alta',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          _buildAreaItem('Shopping', '1.1~1.3x', 'Alta'),
                          _buildAreaItem('TABOLEI', '1.2~2.0x', 'Média'),
                          _buildAreaItem('JARDIM I', '1.2~1.6x', 'Alta'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Botão Conectar/Desconectar
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isOnline = !_isOnline;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isOnline ? Colors.red[400] : Colors.orange[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Text(
                _isOnline ? 'Desconectar' : 'Conectar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              icon: Icons.attach_money,
              label: 'Ganhos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeliveryDriverApp(initialTab: 'earnings'),
                  ),
                );
              },
            ),
            _buildBottomNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeliveryDriverApp(initialTab: 'rewards'),
                  ),
                );
              },
            ),
            _buildBottomNavItem(
              icon: Icons.account_balance_wallet,
              label: 'Saque',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeliveryDriverApp(initialTab: 'withdrawal'),
                  ),
                );
              },
            ),
            _buildBottomNavItem(
              icon: Icons.help,
              label: 'Ajuda',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryDriverApp(initialTab: 'help'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaItem(String name, String multiplier, String demand) {
    Color demandColor;
    switch (demand) {
      case 'Alta':
        demandColor = Colors.red[400]!;
        break;
      case 'Média':
        demandColor = Colors.orange[400]!;
        break;
      default:
        demandColor = Colors.green[400]!;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: demandColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Demanda: $demand',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Text(
              multiplier,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.grey[400],
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

// NOVA CLASSE: Seleção de Veículos cadastrados (dos CRLVs)
class VehicleSelectionScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onVehicleSelected;
  final List<Map<String, dynamic>> registeredVehicles;

  VehicleSelectionScreen({
    required this.onVehicleSelected,
    required this.registeredVehicles,
  });

  @override
  _VehicleSelectionScreenState createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  int? _selectedVehicleIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Selecionar Veículo'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Selecione seu veículo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Escolha entre os veículos cadastrados com CRLV-e',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),
              if (widget.registeredVehicles.isEmpty)
                Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions_car,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nenhum veículo cadastrado',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Cadastre um veículo com CRLV-e primeiro',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...widget.registeredVehicles.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> vehicle = entry.value;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedVehicleIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedVehicleIndex == index
                            ? Colors.orange[50]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedVehicleIndex == index
                              ? Colors.orange[400]!
                              : Colors.grey[200]!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            vehicle['type'] == 'carro'
                                ? Icons.directions_car
                                : Icons.two_wheeler,
                            size: 40,
                            color: _selectedVehicleIndex == index
                                ? Colors.orange[600]
                                : Colors.grey[600],
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehicle['model'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${vehicle['color']} • ${vehicle['plate']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  vehicle['type'] == 'carro' ? 'Carro' : 'Moto',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                if (vehicle.containsKey('crlvStatus'))
                                  SizedBox(height: 4),
                                if (vehicle.containsKey('crlvStatus'))
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: vehicle['crlvStatus'] == 'aprovado'
                                          ? Colors.green[50]
                                          : Colors.orange[50],
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color:
                                            vehicle['crlvStatus'] == 'aprovado'
                                                ? Colors.green[200]!
                                                : Colors.orange[200]!,
                                      ),
                                    ),
                                    child: Text(
                                      vehicle['crlvStatus'] == 'aprovado'
                                          ? 'CRLV Aprovado'
                                          : 'CRLV Pendente',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            vehicle['crlvStatus'] == 'aprovado'
                                                ? Colors.green[700]
                                                : Colors.orange[700],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Radio(
                            value: index,
                            groupValue: _selectedVehicleIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedVehicleIndex = value as int?;
                              });
                            },
                            activeColor: Colors.orange[400],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              SizedBox(height: 205),
              if (_selectedVehicleIndex != null)
                ElevatedButton(
                  onPressed: () {
                    final selectedVehicle =
                        widget.registeredVehicles[_selectedVehicleIndex!];
                    widget.onVehicleSelected(selectedVehicle);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text(
                    'Selecionar Veículo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryDriverApp extends StatefulWidget {
  final String? initialTab;

  DeliveryDriverApp({this.initialTab});

  @override
  _DeliveryDriverAppState createState() => _DeliveryDriverAppState();
}

class _DeliveryDriverAppState extends State<DeliveryDriverApp> {
  String _currentScreen = 'main';
  String _activeTab = 'dashboard';
  bool _showVehicleSelection = false;
  String _selectedVehicle = 'carro'; // 'carro' ou 'moto'

  // Veículos cadastrados com CRLV-e
  List<Map<String, dynamic>> _registeredVehicles = [
    {
      'type': 'carro',
      'plate': 'ABC-1234',
      'color': 'Prata',
      'model': 'Toyota Corolla',
      'crlvStatus': 'aprovado',
    },
    {
      'type': 'moto',
      'plate': 'MOT-5678',
      'color': 'Preto',
      'model': 'Honda CG 160',
      'crlvStatus': 'aprovado',
    },
  ];

  // Dados do motorista (com informações do código antigo)
  Map<String, dynamic> _driverData = {
    'name': 'Natanael',
    'rating': 4.97,
    'totalDeliveries': 2000,
    'years': 6,
    'acceptanceRate': 51,
    'completionRate': 96,
    'vehicleType': 'Carro',
    'vehiclePlate': 'ABC-1234',
    'vehicleColor': 'Prata',
    'vehicleModel': 'Toyota Corolla',
    'earnings': {
      'today': 0.00,
      'week': 125.35,
      'lastDelivery': 15.40,
      'perRequest': 25.07,
      'balance': 125.35,
      'debt': 0.00,
    },
    'notifications': 16,
  };

  // Tipos de itens mais transportados
  List<Map<String, dynamic>> _itemTypes = [
    {'name': 'Documentos', 'percentage': 35, 'icon': Icons.description},
    {'name': 'Eletrônicos', 'percentage': 25, 'icon': Icons.devices},
    {'name': 'Alimentos', 'percentage': 20, 'icon': Icons.fastfood},
    {'name': 'Roupas', 'percentage': 15, 'icon': Icons.checkroom},
    {'name': 'Outros', 'percentage': 5, 'icon': Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialTab != null) {
      _activeTab = widget.initialTab!;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (_showVehicleSelection) {
      return VehicleSelectionScreen(
        registeredVehicles: _registeredVehicles,
        onVehicleSelected: (vehicleInfo) {
          setState(() {
            _selectedVehicle = vehicleInfo['type'];
            _driverData['vehicleType'] =
                vehicleInfo['type'] == 'carro' ? 'Carro' : 'Moto';
            _driverData['vehiclePlate'] = vehicleInfo['plate'];
            _driverData['vehicleColor'] = vehicleInfo['color'];
            _driverData['vehicleModel'] = vehicleInfo['model'];
            _showVehicleSelection = false;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: _activeTab == 'dashboard'
            ? Text('Painel')
            : _activeTab == 'earnings'
                ? Text('Ganhos')
                : _activeTab == 'rewards'
                    ? Text('Recompensas')
                    : _activeTab == 'withdrawal'
                        ? Text('Saque')
                        : Text('Ajuda'),
        backgroundColor: Colors.orange[400],
        actions: _activeTab == 'dashboard'
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                  tooltip: 'Mais',
                ),
              ]
            : null,
      ),
      body: _activeTab == 'dashboard'
          ? _buildDashboard()
          : _activeTab == 'earnings'
              ? _buildEarningsScreen()
              : _activeTab == 'rewards'
                  ? _buildRewardsScreen()
                  : _activeTab == 'withdrawal'
                      ? _buildWithdrawalScreen()
                      : _buildHelpScreen(),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Painel com informações do arquivo
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Saldo principal
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$66,65',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Última corrida
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Valor da última corrida',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'R\$12,65 >',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Taxa da semana
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Taxa (esta semana)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '8.39% >',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Ganhos da semana
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ganhos desta semana',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'R\$137,35 >',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Solicitações
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R\$15,26 / (solicitação) semana',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '4 Solicitações',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      // Botão Ver Central de ganhos
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _activeTab = 'earnings';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 0),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Ver Central de ganhos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Recompensas
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.card_giftcard, color: Colors.orange[600]),
                          SizedBox(width: 8),
                          Text(
                            'Recompensa (1)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Ganhe até R\$73',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(Icons.local_shipping,
                                  color: Colors.orange[600]),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'R\$11',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Finalize 12 solicitação(ões)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Começa amanhã 00:00',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'JARDIM PRAIA MAR - Destino definido',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Tipos de itens mais transportados
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipos de itens mais transportados',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ..._itemTypes.map((item) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(item['icon'],
                                    color: Colors.orange[600], size: 20),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${item['percentage']}%',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    LinearProgressIndicator(
                                      value: item['percentage'] / 100,
                                      backgroundColor: Colors.grey[200],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.orange[400]!),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Notificações
                GestureDetector(
                  onTap: () {
                    // Navegação para notificações
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Badge(
                          label: Text('${_driverData['notifications']}'),
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          child: Icon(Icons.notifications,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notificações',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${_driverData['notifications']} não lidas',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Estatísticas
          Container(
            margin: EdgeInsets.symmetric(horizontal: 13),
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estatísticas de Entrega',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Esta semana',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Taxa de Aceitação',
                        value: '${_driverData['acceptanceRate']}%',
                        color: Colors.blue[100]!,
                        icon: Icons.check_circle,
                        iconColor: Colors.blue[600]!,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Taxa de Entrega',
                        value: '${_driverData['completionRate']}%',
                        color: Colors.green[100]!,
                        icon: Icons.local_shipping,
                        iconColor: Colors.green[600]!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Veículo atual
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Veículo Atual',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showVehicleSelection = true;
                        });
                      },
                      child: Text(
                        'Trocar',
                        style: TextStyle(
                          color: Colors.orange[600],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      _selectedVehicle == 'carro'
                          ? Icons.directions_car
                          : Icons.two_wheeler,
                      size: 40,
                      color: Colors.orange[600],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _driverData['vehicleModel'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${_driverData['vehicleColor']} • ${_driverData['vehiclePlate']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            _driverData['vehicleType'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Saldo atual
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saldo Disponível',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'R\$${_driverData['earnings']['balance'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
                SizedBox(height: 8),
                if (_driverData['earnings']['debt'] > 0)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red[600]),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Você tem um débito de R\$${_driverData['earnings']['debt'].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.red[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Botão para voltar ao mapa
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map),
                  SizedBox(width: 8),
                  Text(
                    'Voltar para o Mapa',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsScreen() {
    return Column(
      children: [
        // Resumo de ganhos
        Container(
          padding: EdgeInsets.all(24),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ganhos do dia (${DateTime.now().day} jan)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'R\$${_driverData['earnings']['today'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildEarningSummary(
                      title: 'Esta semana',
                      value:
                          'R\$${_driverData['earnings']['week'].toStringAsFixed(2)}',
                      color: Colors.green[600]!,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildEarningSummary(
                      title: 'Taxa do app',
                      value: '20%',
                      color: Colors.red[600]!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text('Central de Ganhos - Em desenvolvimento'),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningSummary({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsScreen() {
    return Center(
      child: Text('Recompensas - Em desenvolvimento'),
    );
  }

  Widget _buildWithdrawalScreen() {
    return Center(
      child: Text('Saque - Em desenvolvimento'),
    );
  }

  Widget _buildHelpScreen() {
    return Center(
      child: Text('Ajuda - Em desenvolvimento'),
    );
  }
} // FIM da classe DeliveryDriverApp

// Classes restantes do fluxo de cadastro
class PhoneRegistrationScreen extends StatefulWidget {
  @override
  _PhoneRegistrationScreenState createState() =>
      _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cadastro'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Digite seu telefone',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enviaremos um código de verificação para seu número',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                          controller: _phoneController,
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
                ),
                SizedBox(height: 20),
                Text(
                  'Exemplo: (11) 98765-4321',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_phoneController.text.isNotEmpty) {
                            setState(() {
                              _isLoading = true;
                            });
                            // Simular envio do código
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationScreen(
                                    phoneNumber: _phoneController.text,
                                  ),
                                ),
                              );
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Próximo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  VerificationScreen({required this.phoneNumber});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  String _verificationCode = '123456';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < _controllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    String enteredCode = '';
    for (var controller in _controllers) {
      enteredCode += controller.text;
    }

    if (enteredCode == _verificationCode) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DocumentUploadScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código incorreto. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Verificação'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Verifique seu número',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enviamos um código de 6 dígitos para:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.phoneNumber,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange[600],
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Text(
                    'Digite o código de verificação',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45,
                      height: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
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
                            borderSide: BorderSide(color: Colors.orange[400]!),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Não recebeu o código?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Código reenviado!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Text(
                          'Reenviar código',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading ? null : _verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Verificar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  bool _crlvUploaded = false;
  bool _cnhUploaded = false;
  bool _showPersonalInfo = false;

  @override
  Widget build(BuildContext context) {
    if (_showPersonalInfo) {
      return PersonalInfoScreen();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Documentos'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Documentos obrigatórios',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${_crlvUploaded && _cnhUploaded ? '2/2' : '0/2'} documentos enviados',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),

              // CRLV
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _crlvUploaded
                                ? Colors.green[100]
                                : Colors.orange[100],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              _crlvUploaded ? Icons.check : Icons.description,
                              color: _crlvUploaded
                                  ? Colors.green[600]
                                  : Colors.orange[600],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CRLV (Documento do veículo)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _crlvUploaded
                                    ? 'Documento enviado'
                                    : 'Documento obrigatório',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (!_crlvUploaded)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _crlvUploaded = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 0),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text('Enviar documento'),
                      ),
                  ],
                ),
              ),

              // CNH com EAR
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _cnhUploaded
                                ? Colors.green[100]
                                : Colors.orange[100],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              _cnhUploaded ? Icons.check : Icons.credit_card,
                              color: _cnhUploaded
                                  ? Colors.green[600]
                                  : Colors.orange[600],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CNH com EAR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _cnhUploaded
                                    ? 'Documento enviado'
                                    : 'Documento obrigatório',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (!_cnhUploaded)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _cnhUploaded = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 0),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text('Enviar documento'),
                      ),
                  ],
                ),
              ),

              // Documentos opcionais
              SizedBox(height: 30),
              Text(
                'Documentos opcionais',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.blue[600],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Conta bancária ou PIX',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Escolha a forma como deseja receber seus rendimentos',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Implementar escolha de método de pagamento
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50],
                        foregroundColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(double.infinity, 0),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Escolher método'),
                    ),
                  ],
                ),
              ),

              // Dicas
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dicas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '• Como adicionar EAR >',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Os documentos que você enviou serão salvos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Manteremos suas informações seguras e protegidas',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),
              ElevatedButton(
                onPressed: (_crlvUploaded && _cnhUploaded)
                    ? () {
                        setState(() {
                          _showPersonalInfo = true;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _dateValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Informações Pessoais'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Complete seu cadastro',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Preencha seus dados pessoais para finalizar o cadastro',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40),

                // Nome Completo
                Text(
                  'Nome Completo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Digite seu nome completo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu nome';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // Data de Nascimento - CORRIGIDA
                Text(
                  'Data de Nascimento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    hintText: 'DD/MM/AAAA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _dateValid ? Colors.grey[300]! : Colors.red,
                      ),
                    ),
                    prefixIcon: Icon(Icons.calendar_today),
                    errorText: _dateValid ? null : 'Data inválida',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CustomDateInputFormatter(),
                  ],
                  onChanged: (value) {
                    if (value.length == 10) {
                      try {
                        final parts = value.split('/');
                        final day = int.parse(parts[0]);
                        final month = int.parse(parts[1]);
                        final year = int.parse(parts[2]);

                        if (day < 1 ||
                            day > 31 ||
                            month < 1 ||
                            month > 12 ||
                            year < 1900) {
                          setState(() {
                            _dateValid = false;
                          });
                        } else {
                          setState(() {
                            _dateValid = true;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          _dateValid = false;
                        });
                      }
                    } else {
                      setState(() {
                        _dateValid = true;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite sua data de nascimento';
                    }
                    if (value.length < 10) {
                      return 'Data incompleta. Use DD/MM/AAAA';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                // Email
                Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'seu@email.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu e-mail';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Digite um e-mail válido';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _dateValid) {
                      // Cadastro completo - ir para tela de permissões
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PermissionsScreen(
                            onComplete: () {
                              // Após permissões, ir para a tela de conexão
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConnectScreen()),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text(
                    'Finalizar Cadastro',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
