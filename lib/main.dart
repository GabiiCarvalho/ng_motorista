import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:math';

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
        appBarTheme: const AppBarTheme(
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
    Future.delayed(const Duration(seconds: 3), () {
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
                  boxShadow: const [
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
              const SizedBox(height: 30),
              const Text(
                'Motorista NG',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 180),
              const Text(
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
      body: Column(
        children: [
          // Conteúdo superior (título e logo)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
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
                    const SizedBox(height: 8),
                    Text(
                      'Faça entregas e ganhe dinheiro de forma simples e segura.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Logo centralizada
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/logo.jpeg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'S',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'N&G',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'EXPRESS',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),

          // Botões e texto de termos POSICIONADOS NO FINAL
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          minimumSize: const Size(double.infinity, 0),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
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
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          minimumSize: const Size(double.infinity, 0),
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

                const SizedBox(height: 20),

                // Texto dos termos quase encostando no final
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Ao se cadastrar ou acessar sua conta, você concorda com nossos\nTermos de Uso e Política de Privacidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Entrar'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Digite seu telefone',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Faça login com seu número de telefone cadastrado',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
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
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '(00) 00000-0000',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Exemplo: (11) 98765-4321',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_phoneController.text.isNotEmpty) {
                            setState(() {
                              _isLoading = true;
                            });
                            // CORREÇÃO: Ir para verificação facial
                            Future.delayed(const Duration(seconds: 1), () {
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
                              const SnackBar(
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
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Próximo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
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
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Verificação Facial'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Verificação de Segurança',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Para sua segurança, precisamos confirmar que é realmente você',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

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
              const SizedBox(height: 40),

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
                    const SizedBox(height: 20),
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
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text(
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
                    const SizedBox(height: 20),
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
                    Future.delayed(const Duration(seconds: 3), () {
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

  @override
  Widget build(BuildContext context) {
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
                          // Ir para a tela do mapa quando conectar
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen()),
                          );
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

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove todos os caracteres não numéricos
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita a 8 dígitos
    if (newText.length > 8) {
      newText = newText.substring(0, 8);
    }

    // Formata como DD/MM/AAAA
    String formatted = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += newText[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
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
  double _dailyEarnings = 0.0;
  double _appFee = 0.0; // Taxa do app - COMEÇA EM ZERO
  double _totalEarnings = 0.0;
  List<double> _completedDeliveries = [];

  // Balão de ganhos do dia
  bool _showEarningsBalloon = true;

  // CORREÇÃO: Variáveis para área em alta movível
  bool _showHighDemandAreas = true;
  bool _isDragging = false;
  Offset _highDemandPosition = Offset(20, 140);

  // Variável para controlar pagamento da taxa
  bool _appFeePaid = true; // Inicialmente paga (taxa zerada)

  @override
  void initState() {
    super.initState();
    // Inicializar valores
    _updateEarnings();
  }

  void _updateEarnings() {
    // Calcular ganhos brutos (soma de todas as corridas)
    double grossEarnings =
        _completedDeliveries.fold(0, (sum, element) => sum + element);

    // Calcular taxa do app (15%) apenas se não foi paga
    if (!_appFeePaid) {
      _appFee = grossEarnings * 0.15;
    } else {
      _appFee = 0.0; // Taxa zerada após pagamento
    }

    // Calcular ganhos líquidos
    _totalEarnings = grossEarnings - _appFee;

    // Atualizar ganhos do dia
    _dailyEarnings = _totalEarnings;
  }

  void _completeDelivery(double deliveryValue) {
    setState(() {
      _completedDeliveries.add(deliveryValue);
      _appFeePaid = false; // Nova corrida, taxa acumula novamente
      _updateEarnings();
    });
  }

  // Método para pagar a taxa do app
  void _payAppFee() {
    setState(() {
      _appFee = 0.0;
      _appFeePaid = true;
      _updateEarnings();

      // Mostrar mensagem de pagamento confirmado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Pagamento da taxa confirmado! Taxa zerada: R\$0,00'),
            ],
          ),
          backgroundColor: Colors.green[600],
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  void _showDeliveryCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double deliveryValue =
            20.0 + Random().nextDouble() * 10.0; // Valor aleatório entre 20-30
        return AlertDialog(
          title: Text('Corrida Finalizada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 60, color: Colors.green[600]),
              SizedBox(height: 16),
              Text(
                'Corrida finalizada com sucesso!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Valor da corrida:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'R\$${deliveryValue.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Taxa do App (15%): -R\$${(deliveryValue * 0.15).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ganho líquido: R\$${(deliveryValue * 0.85).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
              SizedBox(height: 16),
              // Mostrar taxa acumulada total
              if (_appFee > 0)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money, color: Colors.orange[600]),
                      SizedBox(width: 8),
                      Text(
                        'Taxa acumulada: R\$${_appFee.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _completeDelivery(deliveryValue);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Corrida adicionada aos ganhos do dia!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[400],
              ),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar todas as áreas em alta
  void _showAllHighDemandAreas(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Text(
                'Todas as Áreas com Alta Demanda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildDetailedAreaItem(
                        'Shopping', '1.1~1.3x', 'Alta', '5-10 min'),
                    _buildDetailedAreaItem(
                        'TABOLEI', '1.2~2.0x', 'Média', '10-15 min'),
                    _buildDetailedAreaItem(
                        'JARDIM I', '1.2~1.6x', 'Alta', '5-8 min'),
                    _buildDetailedAreaItem('Uniavan Av. Marginal Oeste',
                        '1.5~2.2x', 'Média', '15-20 min'),
                    _buildDetailedAreaItem(
                        'Rio Pecan', '1.1~1.8x', 'Baixa', '20-25 min'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailedAreaItem(
      String name, String multiplier, String demand, String waitTime) {
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
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                    SizedBox(width: 4),
                    Text(
                      'Tempo de espera: $waitTime',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
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
                  // Botão para pagar taxa do app
                  if (_appFee > 0)
                    GestureDetector(
                      onTap: _payAppFee,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.attach_money,
                                size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Pagar Taxa',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        if (_isOnline)
                          ElevatedButton(
                            onPressed: _showDeliveryCompletionDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                            ),
                            child: Text('Simular Corrida Completa'),
                          ),
                      ],
                    ),
                  ),
                ),

                // Balão de ganhos do dia (centralizado na parte superior)
                if (_showEarningsBalloon && _isOnline)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showEarningsBalloon = !_showEarningsBalloon;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.orange[300]!,
                            width: 3,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Cabeçalho do balão
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 24,
                                  color: Colors.green[700],
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'GANHOS DO DIA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12),

                            // Valor principal
                            Text(
                              'R\$${_dailyEarnings.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),

                            SizedBox(height: 8),

                            // Informações detalhadas
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Taxa (15%):',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        _appFeePaid
                                            ? 'R\$0,00 (PAGA)'
                                            : '-R\$${_appFee.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _appFeePaid
                                              ? Colors.green[600]
                                              : Colors.red[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bruto:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        'R\$${(_dailyEarnings + _appFee).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '${_completedDeliveries.length} corridas',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.orange[700],
                                            fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  ),

                // Botão para mostrar/ocultar balão
                if (_isOnline)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _showEarningsBalloon = !_showEarningsBalloon;
                        });
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(
                        _showEarningsBalloon
                            ? Icons.visibility_off
                            : Icons.attach_money,
                        color: Colors.orange[600],
                      ),
                    ),
                  ),

                // CORREÇÃO: Áreas de entrega (quando online) - MOVÍVEL E MINIMIZÁVEL
                if (_isOnline && _showHighDemandAreas)
                  Positioned(
                    top: _highDemandPosition.dy,
                    left: _highDemandPosition.dx,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _isDragging = true;
                          _highDemandPosition = Offset(
                            _highDemandPosition.dx + details.delta.dx,
                            _highDemandPosition.dy + details.delta.dy,
                          );
                        });
                      },
                      onPanEnd: (details) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          setState(() {
                            _isDragging = false;
                          });
                        });
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isDragging
                              ? Colors.white.withOpacity(0.8)
                              : Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: _isDragging ? 10 : 6,
                              offset: Offset(0, _isDragging ? 4 : 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cabeçalho com botão de minimizar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.local_shipping,
                                        size: 14, color: Colors.orange[600]),
                                    SizedBox(width: 6),
                                    Text(
                                      'Áreas em Alta',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showHighDemandAreas = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.minimize,
                                      size: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _buildAreaItem('Shopping', '1.1~1.3x', 'Alta'),
                            _buildAreaItem('TABOLEI', '1.2~2.0x', 'Média'),
                            // Botão para expandir/ver mais áreas
                            if (!_isDragging)
                              TextButton(
                                onPressed: () {
                                  _showAllHighDemandAreas(context);
                                },
                                child: Text(
                                  'Ver todas...',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange[600],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // CORREÇÃO: Botão para restaurar a área quando minimizada
                if (_isOnline && !_showHighDemandAreas)
                  Positioned(
                    top: 140,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showHighDemandAreas = true;
                          _highDemandPosition =
                              Offset(20, 140); // Resetar posição
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
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
                            Icon(Icons.local_shipping,
                                size: 14, color: Colors.orange[600]),
                            SizedBox(width: 6),
                            Text(
                              'Áreas em Alta',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                  if (_isOnline) {
                    _showEarningsBalloon = true;
                  }
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
            _buildBottomNavItem(
              icon: Icons.history,
              label: 'Histórico',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeliveryDriverApp(initialTab: 'history'),
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
        margin: EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: demandColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Demanda: $demand',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Text(
                multiplier,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
          ],
        ));
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
                'Selecionar seu veículo',
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

// TELA DE PAGAMENTO VIA PIX
class PixPaymentScreen extends StatefulWidget {
  final double amountDue;

  PixPaymentScreen({required this.amountDue});

  @override
  _PixPaymentScreenState createState() => _PixPaymentScreenState();
}

class _PixPaymentScreenState extends State<PixPaymentScreen> {
  String _pixKey = '';
  bool _isLoading = false;
  bool _isCopied = false;

  @override
  void initState() {
    super.initState();
    _generatePixKey();
  }

  void _generatePixKey() {
    setState(() {
      _isLoading = true;
    });

    // Simular geração de chave PIX aleatória
    Future.delayed(Duration(seconds: 1), () {
      final random = Random();
      final key =
          '${DateTime.now().millisecondsSinceEpoch}${random.nextInt(9999).toString().padLeft(4, '0')}';
      setState(() {
        _pixKey = key;
        _isLoading = false;
      });
    });
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _pixKey));
    setState(() {
      _isCopied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chave PIX copiada!'),
        backgroundColor: Colors.green,
      ),
    );

    // Resetar após 2 segundos
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Pagamento via PIX'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone PIX
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.qr_code,
                size: 60,
                color: Colors.blue[600],
              ),
            ),

            // Valor devido
            Text(
              'Valor Devido',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'R\$ ${widget.amountDue.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            SizedBox(height: 30),

            // Chave PIX
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  Text(
                    'Chave PIX',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 12),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    Column(
                      children: [
                        SelectableText(
                          _pixKey,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),

                        // Botão copiar
                        ElevatedButton.icon(
                          onPressed: _copyToClipboard,
                          icon: Icon(_isCopied ? Icons.check : Icons.copy),
                          label: Text(_isCopied ? 'Copiado!' : 'Copiar Chave'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // QR Code
            Text(
              'Ou escaneie o QR Code',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Simulação de QR Code
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'QR Code PIX',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Aponte a câmera do seu\naplicativo bancário',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Instruções
            Container(
              padding: EdgeInsets.all(20),
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
                        'Instruções para pagamento',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildInstructionStep(1, 'Copie a chave PIX acima'),
                  _buildInstructionStep(2, 'Abra seu aplicativo bancário'),
                  _buildInstructionStep(3, 'Cole a chave no campo PIX'),
                  _buildInstructionStep(4,
                      'Confirme o pagamento de R\$${widget.amountDue.toStringAsFixed(2)}'),
                  _buildInstructionStep(
                      5, 'Aguardar confirmação (até 2 dias úteis)'),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Botões de ação
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Voltar'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _generatePixKey();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Gerar Nova Chave'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep(int number, String text) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ));
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

  // Variáveis para filtros
  String _selectedFilter = 'all';
  Map<String, dynamic> _filterSettings = {
    'period': 'all',
    'status': ['completed'],
    'minValue': 0.0,
    'customDate': {'start': null, 'end': null},
  };

  DateTime? _customStartDate;
  DateTime? _customEndDate;

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

  // Dados do motorista
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
      'debt': 125.35, // Débito da taxa do app (negativo)
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
                        : _activeTab == 'help'
                            ? Text('Ajuda')
                            : _activeTab == 'history'
                                ? Text('Histórico de Corridas')
                                : Text('Painel'),
        backgroundColor: Colors.orange[400],
        actions: _activeTab == 'dashboard' ? [] : null,
      ),
      body: _activeTab == 'dashboard'
          ? _buildDashboard()
          : _activeTab == 'earnings'
              ? _buildEarningsScreen()
              : _activeTab == 'rewards'
                  ? _buildRewardsScreen()
                  : _activeTab == 'withdrawal'
                      ? _buildWithdrawalScreen()
                      : _activeTab == 'help'
                          ? _buildHelpScreen()
                          : _activeTab == 'history'
                              ? _buildHistoryScreen()
                              : Container(),
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
                        title: 'Taxa de Aceites',
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

          // Saldo atual com alerta de débito
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
                    color: _driverData['earnings']['debt'] > 0
                        ? Colors.red[600]
                        : Colors.green[600],
                  ),
                ),
                SizedBox(height: 8),
                if (_driverData['earnings']['debt'] > 0)
                  GestureDetector(
                    onTap: () {
                      // Navegar para a tela de PIX para pagar débito
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PixPaymentScreen(
                            amountDue: _driverData['earnings']['debt'],
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Você tem um débito de R\$${_driverData['earnings']['debt'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.red[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Toque para pagar via PIX',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.red[400]),
                        ],
                      ),
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

          // Botão de Sair
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: OutlinedButton(
              onPressed: () {
                // Confirmação antes de sair
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Sair do App'),
                    content: Text(
                        'Tem certeza que deseja sair? Você será redirecionado para a tela de login.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Redirecionar para a tela de login
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Sair'),
                      ),
                    ],
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red[400]!, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app, color: Colors.red[400]),
                  SizedBox(width: 8),
                  Text(
                    'Sair do App',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold,
                    ),
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
        ));
  }

  Widget _buildEarningsScreen() {
    double _appFeeDebt = _driverData['earnings']['debt'];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com saldo
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _appFeeDebt > 0 ? Colors.red[400] : Colors.orange[400],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    _appFeeDebt > 0 ? 'Débito Pendente' : 'Saldo Disponível',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'R\$${_appFeeDebt.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _appFeeDebt > 0 ? 'TAXA DO APP' : 'Esta semana',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  // Botão de pagar débito se houver
                  if (_appFeeDebt > 0)
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PixPaymentScreen(
                                amountDue: _appFeeDebt,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: Text('Pagar Débito via PIX'),
                      ),
                    ),
                ],
              ),
            ),

            // Alerta de débito
            if (_appFeeDebt > 0)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PixPaymentScreen(
                        amountDue: _appFeeDebt,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red[600]),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Débito Pendente',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                              ),
                            ),
                            Text(
                              'Taxa do App: R\$${_appFeeDebt.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Toque para pagar via PIX',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.red[400]),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 20),

            // Resumo por dia
            Text(
              'Resumo por Dia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            ..._buildDailyEarnings(),

            SizedBox(height: 20),

            // Detalhes
            Text(
              'Detalhes dos Ganhos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildEarningDetail('Entregas Completas', '15', '+ R\$225,00'),
            _buildEarningDetail('Bônus de Horário', '3', '+ R\$45,00'),
            _buildEarningDetail('Gorjetas', '8', '+ R\$64,50'),
            _buildEarningDetail('Taxa do App (15%)', '',
                '- R\$${_appFeeDebt.toStringAsFixed(2)}',
                isDebt: true),

            SizedBox(height: 30),

            // Histórico de Saques
            Text(
              'Histórico de Saques',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildWithdrawalHistory('15/01/2024', 'R\$350,00', 'Concluído'),
            _buildWithdrawalHistory('08/01/2024', 'R\$280,50', 'Concluído'),
            _buildWithdrawalHistory('01/01/2024', 'R\$410,75', 'Concluído'),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDailyEarnings() {
    List<Map<String, dynamic>> dailyEarnings = [
      {'day': 'Seg', 'amount': 85.50, 'deliveries': 6},
      {'day': 'Ter', 'amount': 92.25, 'deliveries': 7},
      {'day': 'Qua', 'amount': 78.00, 'deliveries': 5},
      {'day': 'Qui', 'amount': 110.75, 'deliveries': 8},
      {'day': 'Sex', 'amount': 65.50, 'deliveries': 4},
      {'day': 'Sáb', 'amount': 125.35, 'deliveries': 9},
      {'day': 'Dom', 'amount': 0.00, 'deliveries': 0},
    ];

    return dailyEarnings.map((day) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day['day'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$${day['amount'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
                Text(
                  '${day['deliveries']} entregas',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildEarningDetail(String title, String count, String value,
      {bool isDebt = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (count.isNotEmpty)
                Text(
                  '$count itens',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDebt
                  ? Colors.red[600]
                  : (value.startsWith('+')
                      ? Colors.green[600]
                      : Colors.red[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalHistory(String date, String amount, String status) {
    Color statusColor =
        status == 'Concluído' ? Colors.green[600]! : Colors.orange[600]!;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet, color: Colors.orange[600]),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange[400]!, Colors.orange[600]!],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Recompensas Disponíveis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Complete desafios e ganhe bônus',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Recompensas ativas
            Text(
              'Recompensas Ativas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildRewardCard(
              'Entrega Expressa',
              'Complete 10 entregas em 24h',
              'R\$50,00',
              Icons.local_shipping,
              8,
              10,
            ),
            _buildRewardCard(
              'Fim de Semana Produtivo',
              '20 entregas no sábado e domingo',
              'R\$100,00',
              Icons.weekend,
              15,
              20,
            ),
            _buildRewardCard(
              'Cliente Fiel',
              '5 entregas para o mesmo cliente',
              'R\$25,00',
              Icons.star,
              3,
              5,
            ),

            SizedBox(height: 20),

            // Recompensas conquistadas
            Text(
              'Recompensas Conquistadas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildAchievedReward(
              'Primeira Entrega',
              'Concluída em 10/01/2024',
              'R\$10,00',
            ),
            _buildAchievedReward(
              'Entrega Noturna',
              'Concluída em 12/01/2024',
              'R\$20,00',
            ),
            _buildAchievedReward(
              'Meta Semanal',
              'Concluída em 14/01/2024',
              'R\$75,00',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardCard(
    String title,
    String description,
    String reward,
    IconData icon,
    int progress,
    int total,
  ) {
    double percentage = progress / total;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.orange[600]),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                reward,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orange[400]!),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '$progress/$total',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(double.infinity, 0),
            ),
            child: Text('Continuar Desafio'),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievedReward(String title, String date, String reward) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green[600]),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            reward,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saldo disponível
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
                children: [
                  Text(
                    'Saldo Disponível para Saque',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'R\$${_driverData['earnings']['balance'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _driverData['earnings']['balance'] > 0
                        ? () {
                            // Abrir modal de saque
                            _showWithdrawalModal(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: Text(
                      'Solicitar Saque',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Métodos de saque
            Text(
              'Métodos de Saque',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildPaymentMethod(
              'Conta Bancária',
              'Banco do Brasil ••• 1234',
              Icons.account_balance,
            ),
            _buildPaymentMethod(
              'PIX',
              'Chave: 123.456.789-00',
              Icons.qr_code,
            ),
            _buildPaymentMethod(
              'Carteira Digital',
              'Disponível em 24h',
              Icons.wallet,
            ),

            SizedBox(height: 20),

            // Limites e taxas
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informações Importantes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildInfoItem('Valor mínimo para saque:', 'R\$ 20,00'),
                  _buildInfoItem('Taxa por saque:', 'R\$ 1,50'),
                  _buildInfoItem('Prazo para liberação:', '1-2 dias úteis'),
                  _buildInfoItem('Limite diário:', 'R\$ 1.000,00'),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Próximo saque programado
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.orange[600]),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Próximo Saque Programado',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Segunda-feira, 10:00 AM',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Alterar',
                      style: TextStyle(
                        color: Colors.orange[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(String title, String details, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.orange[600]),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  details,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Radio(
            value: title,
            groupValue: 'Conta Bancária',
            onChanged: (value) {},
            activeColor: Colors.orange[400],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showWithdrawalModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Solicitar Saque',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Valor do Saque',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: '0,00',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Método de Recebimento',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'pix',
                    child: Text('PIX'),
                  ),
                  DropdownMenuItem(
                    value: 'conta',
                    child: Text('Conta Bancária'),
                  ),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saque solicitado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 0),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Confirmar Saque',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHelpScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[400],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Central de Ajuda',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Estamos aqui para ajudar',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Contato rápido
            Text(
              'Contato Rápido',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildContactOption(
              'Chat Online',
              'Converse com nosso suporte',
              Icons.chat,
              Colors.blue[600]!,
            ),
            _buildContactOption(
              'Telefone',
              '(11) 99999-9999',
              Icons.phone,
              Colors.green[600]!,
            ),
            _buildContactOption(
              'E-mail',
              'suporte@ngmotorista.com',
              Icons.email,
              Colors.orange[600]!,
            ),

            SizedBox(height: 20),

            // Perguntas frequentes
            Text(
              'Perguntas Frequentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildFAQItem(
              'Como recebo minhas entregas?',
              'Você receberá notificações quando houver entregas disponíveis na sua área.',
            ),
            _buildFAQItem(
              'Quanto tempo leva para o saque?',
              'O saque leva de 1 a 2 dias úteis para ser processado.',
            ),
            _buildFAQItem(
              'Como altero meu veículo?',
              'Vá até a tela de perfil e selecione "Trocar Veículo".',
            ),
            _buildFAQItem(
              'O que fazer em caso de problema com uma entrega?',
              'Entre em contato imediatamente com nosso suporte pelo chat.',
            ),

            SizedBox(height: 20),

            // Documentos importantes
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Documentos e Links Úteis',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildDocumentLink('Termos de Uso', Icons.description),
                  _buildDocumentLink('Política de Privacidade', Icons.security),
                  _buildDocumentLink('Manual do Motorista', Icons.book),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Avisos
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[600]),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Em caso de emergência, ligue para 190 ou 192',
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
    );
  }

  // MÉTODOS PARA HISTÓRICO E FILTROS

  // Lista de todas as entregas
  List<Map<String, dynamic>> _getAllDeliveries() {
    return [
      {
        'id': '001',
        'customerName': 'Maria Silva',
        'customerRating': 4.8,
        'pickupLocation': 'Shopping Center Iguatemi',
        'deliveryLocation': 'Rua das Flores, 123 - Centro',
        'distance': 4.2,
        'duration': '25 min',
        'value': 18.50,
        'paymentMethod': 'Cartão de Crédito',
        'date': DateTime.now().subtract(Duration(hours: 2)),
        'status': 'completed',
        'items': ['Documentos', 'Presente'],
        'vehicleType': 'Carro',
      },
      {
        'id': '002',
        'customerName': 'João Santos',
        'customerRating': 5.0,
        'pickupLocation': 'Avenida Paulista, 1000',
        'deliveryLocation': 'Rua Augusta, 500 - Consolação',
        'distance': 3.8,
        'duration': '20 min',
        'value': 15.80,
        'paymentMethod': 'PIX',
        'date': DateTime.now().subtract(Duration(days: 1)),
        'status': 'completed',
        'items': ['Eletrônico'],
        'vehicleType': 'Carro',
      },
      {
        'id': '003',
        'customerName': 'Ana Oliveira',
        'customerRating': 4.5,
        'pickupLocation': 'Restaurante Madero',
        'deliveryLocation': 'Condomínio Green Valley, Apt 302',
        'distance': 5.5,
        'duration': '32 min',
        'value': 22.00,
        'paymentMethod': 'Dinheiro',
        'date': DateTime.now().subtract(Duration(days: 2)),
        'status': 'completed',
        'items': ['Alimentos'],
        'vehicleType': 'Carro',
      },
      {
        'id': '004',
        'customerName': 'Pedro Costa',
        'customerRating': 4.9,
        'pickupLocation': 'Farmácia Droga Raia',
        'deliveryLocation': 'Hospital São Lucas',
        'distance': 2.3,
        'duration': '15 min',
        'value': 12.00,
        'paymentMethod': 'Cartão de Débito',
        'date': DateTime.now().subtract(Duration(days: 8)),
        'status': 'cancelled',
        'items': ['Medicamentos'],
        'vehicleType': 'Carro',
      },
      {
        'id': '005',
        'customerName': 'Carla Mendes',
        'customerRating': 4.7,
        'pickupLocation': 'Livraria Cultura',
        'deliveryLocation': 'Escola Estadual São Paulo',
        'distance': 6.1,
        'duration': '35 min',
        'value': 28.50,
        'paymentMethod': 'Cartão de Crédito',
        'date': DateTime.now().subtract(Duration(days: 15)),
        'status': 'completed',
        'items': ['Livros'],
        'vehicleType': 'Carro',
      },
      {
        'id': '006',
        'customerName': 'Ricardo Alves',
        'customerRating': 4.3,
        'pickupLocation': 'Aeroporto de Congonhas',
        'deliveryLocation': 'Hotel Ibis',
        'distance': 8.5,
        'duration': '45 min',
        'value': 35.00,
        'paymentMethod': 'PIX',
        'date': DateTime.now().subtract(Duration(days: 30)),
        'status': 'in_progress',
        'items': ['Bagagem'],
        'vehicleType': 'Carro',
      },
    ];
  }

  // Método para aplicar filtros
  List<Map<String, dynamic>> _getFilteredDeliveries() {
    List<Map<String, dynamic>> allDeliveries = _getAllDeliveries();

    // Filtrar por período
    List<Map<String, dynamic>> filteredByPeriod =
        _filterByPeriod(allDeliveries);

    // Filtrar por status
    List<Map<String, dynamic>> filteredByStatus =
        _filterByStatus(filteredByPeriod);

    // Filtrar por valor mínimo
    List<Map<String, dynamic>> filteredByValue =
        _filterByValue(filteredByStatus);

    return filteredByValue;
  }

  // Método para filtrar por período
  List<Map<String, dynamic>> _filterByPeriod(
      List<Map<String, dynamic>> deliveries) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    // Obter início da semana (segunda-feira)
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final startOfLastWeek = startOfWeek.subtract(Duration(days: 7));
    final endOfLastWeek = startOfWeek.subtract(Duration(days: 1));

    // Obter início do mês
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfLastMonth = DateTime(now.month == 1 ? now.year - 1 : now.year,
        now.month == 1 ? 12 : now.month - 1, 1);
    final endOfLastMonth = startOfMonth.subtract(Duration(days: 1));

    switch (_filterSettings['period']) {
      case 'today':
        return deliveries.where((delivery) {
          final deliveryDate = (delivery['date'] as DateTime);
          return deliveryDate.isAfter(today);
        }).toList();

      case 'yesterday':
        return deliveries.where((delivery) {
          final deliveryDate = (delivery['date'] as DateTime);
          return deliveryDate.isAfter(yesterday) &&
              deliveryDate.isBefore(today);
        }).toList();

      case 'week':
        return deliveries.where((delivery) {
          final deliveryDate = (delivery['date'] as DateTime);
          return deliveryDate.isAfter(startOfWeek);
        }).toList();

      case 'last_week':
        return deliveries.where((delivery) {
          final deliveryDate = (delivery['date'] as DateTime);
          return deliveryDate.isAfter(startOfLastWeek) &&
              deliveryDate.isBefore(startOfWeek);
        }).toList();

      case 'month':
        return deliveries.where((delivery) {
          final deliveryDate = (delivery['date'] as DateTime);
          return deliveryDate.isAfter(startOfMonth);
        }).toList();

      case 'last_month':
        return deliveries.where((delivery) {
          final deliveryDate = (delivery['date'] as DateTime);
          return deliveryDate.isAfter(startOfLastMonth) &&
              deliveryDate.isBefore(startOfMonth);
        }).toList();

      case 'custom':
        if (_customStartDate != null && _customEndDate != null) {
          final startDate = DateTime(_customStartDate!.year,
              _customStartDate!.month, _customStartDate!.day);
          final endDate = DateTime(_customEndDate!.year, _customEndDate!.month,
              _customEndDate!.day + 1); // +1 para incluir o dia final

          return deliveries.where((delivery) {
            final deliveryDate = (delivery['date'] as DateTime);
            return deliveryDate.isAfter(startDate) &&
                deliveryDate.isBefore(endDate);
          }).toList();
        }
        return deliveries;

      case 'all':
      default:
        return deliveries;
    }
  }

  // Método para filtrar por status
  List<Map<String, dynamic>> _filterByStatus(
      List<Map<String, dynamic>> deliveries) {
    final List<String> statusFilter = _filterSettings['status'];

    if (statusFilter.isEmpty) {
      return deliveries;
    }

    return deliveries.where((delivery) {
      return statusFilter.contains(delivery['status']);
    }).toList();
  }

  // Método para filtrar por valor mínimo
  List<Map<String, dynamic>> _filterByValue(
      List<Map<String, dynamic>> deliveries) {
    final double minValue = _filterSettings['minValue'];

    if (minValue <= 0) {
      return deliveries;
    }

    return deliveries.where((delivery) {
      return delivery['value'] >= minValue;
    }).toList();
  }

  // Método para calcular resumo baseado no filtro
  String _calculateTotalEarnings() {
    final filtered = _getFilteredDeliveries();
    double total = 0;
    for (var delivery in filtered) {
      total += delivery['value'];
    }
    return 'R\$${total.toStringAsFixed(2)}';
  }

  String _calculateTotalDistance() {
    final filtered = _getFilteredDeliveries();
    double total = 0;
    for (var delivery in filtered) {
      total += delivery['distance'];
    }
    return '${total.toStringAsFixed(1)} km';
  }

  String _calculateTotalTime() {
    final filtered = _getFilteredDeliveries();
    int totalMinutes = 0;

    for (var delivery in filtered) {
      String duration = delivery['duration'];
      List<String> parts = duration.split(' ');
      if (parts.isNotEmpty) {
        totalMinutes += int.parse(parts[0]);
      }
    }

    if (totalMinutes < 60) {
      return '$totalMinutes min';
    } else {
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      return minutes > 0 ? '$hours h $minutes min' : '$hours h';
    }
  }

  Widget _buildHistoryScreen() {
    final filteredDeliveries = _getFilteredDeliveries();

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(''),
        backgroundColor: Colors.orange[400],
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterModal,
            tooltip: 'Filtrar',
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportHistory,
            tooltip: 'Exportar',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros rápidos
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.grey[50],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Hoje', 'today'),
                  SizedBox(width: 8),
                  _buildFilterChip('Esta semana', 'week'),
                  SizedBox(width: 8),
                  _buildFilterChip('Este mês', 'month'),
                  SizedBox(width: 8),
                  _buildFilterChip('Todos', 'all'),
                ],
              ),
            ),
          ),

          // Resumo
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('${filteredDeliveries.length}', 'Corridas'),
                _buildSummaryItem(_calculateTotalDistance(), 'KM'),
                _buildSummaryItem(_calculateTotalEarnings(), 'Valor'),
                _buildSummaryItem(_calculateTotalTime(), 'Tempo'),
              ],
            ),
          ),

          // Lista de corridas
          Expanded(
            child: filteredDeliveries.isEmpty
                ? _buildEmptyHistory()
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredDeliveries.length,
                    itemBuilder: (context, index) {
                      return _buildDeliveryCard(filteredDeliveries[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    bool isSelected = _selectedFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = value;
          _filterSettings['period'] = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange[400] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange[400]! : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    DateTime deliveryDate = delivery['date'];
    String formattedDate =
        '${deliveryDate.day.toString().padLeft(2, '0')}/${deliveryDate.month.toString().padLeft(2, '0')}/${deliveryDate.year}';
    String formattedTime =
        '${deliveryDate.hour.toString().padLeft(2, '0')}:${deliveryDate.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
          // Cabeçalho com data/hora e status
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$formattedDate • $formattedTime',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(delivery['status']),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getStatusText(delivery['status']),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Informações do cliente
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Text(
                        delivery['customerName'].substring(0, 1),
                        style: TextStyle(
                          color: Colors.orange[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            delivery['customerName'],
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
                                '${delivery['customerRating']} ★',
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

                SizedBox(height: 12),

                // Localização
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.green[600]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Coleta:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            delivery['pickupLocation'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.red[600]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Entrega:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            delivery['deliveryLocation'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Detalhes da corrida
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDetailItem(
                        Icons.directions_car,
                        '${delivery['distance']} km',
                        'Distância',
                      ),
                      _buildDetailItem(
                        Icons.access_time,
                        delivery['duration'],
                        'Duração',
                      ),
                      _buildDetailItem(
                        Icons.attach_money,
                        'R\$${delivery['value'].toStringAsFixed(2)}',
                        'Valor',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),

                // Forma de pagamento e itens
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.credit_card,
                            size: 16, color: Colors.grey[600]),
                        SizedBox(width: 6),
                        Text(
                          delivery['paymentMethod'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    if (delivery['items'] != null &&
                        delivery['items'].isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.inventory,
                              size: 16, color: Colors.grey[600]),
                          SizedBox(width: 6),
                          Text(
                            delivery['items'].join(', '),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                  ],
                ),

                SizedBox(height: 8),

                // Ações
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showDeliveryDetails(delivery);
                        },
                        icon: Icon(Icons.visibility, size: 16),
                        label: Text('Ver Detalhes'),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _repeatDelivery(delivery);
                        },
                        icon: Icon(Icons.repeat, size: 16),
                        label: Text('Repetir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          foregroundColor: Colors.white,
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

  Widget _buildDetailItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.orange[600]),
            SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16),
          Text(
            'Nenhuma corrida no histórico',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Suas corridas aparecerão aqui',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
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
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text('Começar a trabalhar'),
          ),
        ],
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filtrar Histórico',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Filtro por data
                    Text(
                      'Período',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterOption('Hoje', 'today', setModalState),
                        _buildFilterOption('Ontem', 'yesterday', setModalState),
                        _buildFilterOption(
                            'Esta semana', 'week', setModalState),
                        _buildFilterOption(
                            'Última semana', 'last_week', setModalState),
                        _buildFilterOption('Este mês', 'month', setModalState),
                        _buildFilterOption(
                            'Mês passado', 'last_month', setModalState),
                        _buildFilterOption(
                            'Personalizado', 'custom', setModalState),
                      ],
                    ),

                    if (_filterSettings['period'] == 'custom') ...[
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Data inicial',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          _customStartDate ?? DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      setModalState(() {
                                        _customStartDate = selectedDate;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[100],
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _customStartDate != null
                                            ? '${_customStartDate!.day}/${_customStartDate!.month}/${_customStartDate!.year}'
                                            : 'Selecionar data',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(Icons.calendar_today, size: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Data final',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          _customEndDate ?? DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      setModalState(() {
                                        _customEndDate = selectedDate;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[100],
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _customEndDate != null
                                            ? '${_customEndDate!.day}/${_customEndDate!.month}/${_customEndDate!.year}'
                                            : 'Selecionar data',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(Icons.calendar_today, size: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],

                    SizedBox(height: 20),

                    // Filtro por status
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildStatusFilter(
                            'Concluídas', 'completed', setModalState),
                        _buildStatusFilter(
                            'Canceladas', 'cancelled', setModalState),
                        _buildStatusFilter(
                            'Em andamento', 'in_progress', setModalState),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Filtro por valor
                    Text(
                      'Valor Mínimo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Slider(
                      value: _filterSettings['minValue'],
                      min: 0,
                      max: 50,
                      divisions: 10,
                      label:
                          'R\$ ${_filterSettings['minValue'].toStringAsFixed(2)}',
                      onChanged: (value) {
                        setModalState(() {
                          _filterSettings['minValue'] = value;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      'R\$ ${_filterSettings['minValue'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                _filterSettings = {
                                  'period': 'all',
                                  'status': ['completed'],
                                  'minValue': 0.0,
                                  'customDate': {'start': null, 'end': null},
                                };
                                _customStartDate = null;
                                _customEndDate = null;
                                _selectedFilter = 'all';
                              });
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text('Limpar Filtros'),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedFilter = _filterSettings['period'];
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Aplicar Filtros'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOption(
      String label, String value, StateSetter setModalState) {
    bool isSelected = _filterSettings['period'] == value;

    return GestureDetector(
        onTap: () {
          setModalState(() {
            _filterSettings['period'] = value;
            if (value != 'custom') {
              _customStartDate = null;
              _customEndDate = null;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange[400] : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.orange[400]! : Colors.grey[300]!,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ));
  }

  Widget _buildStatusFilter(
      String label, String value, StateSetter setModalState) {
    List<String> statusList = List.from(_filterSettings['status']);
    bool isSelected = statusList.contains(value);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setModalState(() {
          if (selected) {
            if (!statusList.contains(value)) {
              statusList.add(value);
            }
          } else {
            statusList.remove(value);
          }
          _filterSettings['status'] = statusList;
        });
      },
      selectedColor: Colors.orange[400],
      checkmarkColor: Colors.white,
      showCheckmark: true,
    );
  }

  void _exportHistory() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exportar Histórico',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildExportOption('PDF', Icons.picture_as_pdf),
              _buildExportOption('Excel', Icons.table_chart),
              _buildExportOption('CSV', Icons.grid_on),
              _buildExportOption('Imprimir', Icons.print),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Center(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExportOption(String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange[600]),
      title: Text(label),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Histórico exportado em $label'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  void _showDeliveryDetails(Map<String, dynamic> delivery) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        DateTime deliveryDate = delivery['date'];
        String formattedDate =
            '${deliveryDate.day.toString().padLeft(2, '0')}/${deliveryDate.month.toString().padLeft(2, '0')}/${deliveryDate.year}';
        String formattedTime =
            '${deliveryDate.hour.toString().padLeft(2, '0')}:${deliveryDate.minute.toString().padLeft(2, '0')}';

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detalhes da Corrida',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Informações principais
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange[100],
                          radius: 30,
                          child: Text(
                            delivery['customerName'].substring(0, 1),
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.orange[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                delivery['customerName'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  SizedBox(width: 4),
                                  Text(
                                    '${delivery['customerRating']} ★',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'ID: ${delivery['id']}',
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

                  SizedBox(height: 20),

                  // Rota e tempo
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Coleta
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.location_on,
                                  size: 18, color: Colors.green[600]),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Coleta',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    delivery['pickupLocation'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Linha divisória
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Container(
                            height: 20,
                            child: VerticalDivider(
                              color: Colors.grey[300],
                              thickness: 1,
                              indent: 16,
                              endIndent: 0,
                            ),
                          ),
                        ),

                        // Entrega
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.location_on,
                                  size: 18, color: Colors.red[600]),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Entrega',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    delivery['deliveryLocation'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Estatísticas da corrida
                  Text(
                    'Estatísticas da Corrida',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(1.5),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            _buildTableCell('Distância', isHeader: true),
                            _buildTableCell('Duração', isHeader: true),
                            _buildTableCell('Valor', isHeader: true),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell('${delivery['distance']} km'),
                            _buildTableCell(delivery['duration']),
                            _buildTableCell(
                                'R\$${delivery['value'].toStringAsFixed(2)}'),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell('Data', isHeader: true),
                            _buildTableCell('Hora', isHeader: true),
                            _buildTableCell('Veículo', isHeader: true),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell(formattedDate),
                            _buildTableCell(formattedTime),
                            _buildTableCell(delivery['vehicleType']),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Pagamento e itens
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        // Pagamento
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[200]!),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.credit_card, color: Colors.blue[600]),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pagamento',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      delivery['paymentMethod'],
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'R\$${delivery['value'].toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Itens
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.inventory, color: Colors.green[600]),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Itens Transportados',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    if (delivery['items'] != null &&
                                        delivery['items'].isNotEmpty)
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        children: delivery['items']
                                            .map<Widget>((item) {
                                          return Chip(
                                            label: Text(item),
                                            backgroundColor: Colors.orange[50],
                                            labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange[700],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Botões de ação
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _contactCustomer(delivery);
                        },
                        icon: Icon(Icons.message, size: 20),
                        label: Text('Contatar Cliente'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          _repeatDelivery(delivery);
                        },
                        icon: Icon(Icons.repeat, size: 20),
                        label: Text('Repetir Corrida'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          _reportIssue(delivery);
                        },
                        child: Text(
                          'Reportar Problema com esta corrida',
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 12 : 14,
          fontWeight: isHeader ? FontWeight.w500 : FontWeight.normal,
          color: isHeader ? Colors.grey[600] : Colors.grey[800],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _contactCustomer(Map<String, dynamic> delivery) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Contatar Cliente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.phone, color: Colors.green[600]),
                title: Text('Ligar para ${delivery['customerName']}'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ligando para o cliente...'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.message, color: Colors.blue[600]),
                title: Text('Enviar mensagem'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Abrindo conversa...'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _repeatDelivery(Map<String, dynamic> delivery) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Repetir Corrida'),
          content: Text(
              'Deseja repetir esta corrida para ${delivery['customerName']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Corrida solicitada novamente!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[400],
              ),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _reportIssue(Map<String, dynamic> delivery) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reportar Problema',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Corrida: ${delivery['id']} • ${delivery['customerName']}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tipo de Problema',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildIssueOption('Pagamento', 'payment'),
                  _buildIssueOption('Cliente', 'customer'),
                  _buildIssueOption('Rota', 'route'),
                  _buildIssueOption('Itens', 'items'),
                  _buildIssueOption('Outro', 'other'),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Descrição',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Descreva o problema...',
                  border: OutlineInputBorder(),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Problema reportado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 0),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Enviar Relatório'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIssueOption(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: false,
      onSelected: (selected) {},
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green[600]!;
      case 'cancelled':
        return Colors.red[600]!;
      case 'in_progress':
        return Colors.orange[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'Concluída';
      case 'cancelled':
        return 'Cancelada';
      case 'in_progress':
        return 'Em andamento';
      default:
        return 'Desconhecido';
    }
  }

  Widget _buildContactOption(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentLink(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.open_in_new, size: 16),
      onTap: () {},
    );
  }
}

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalInfoScreen(),
                          ),
                        );
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

  Widget _buildDateFieldWithFormatter() {
    return TextFormField(
      controller: _birthDateController,
      decoration: InputDecoration(
        hintText: 'DD/MM/AAAA',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      keyboardType: TextInputType.datetime,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(8), // DDMMAAAA = 8 dígitos
        _DateInputFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, digite sua data de nascimento';
        }

        // Verificar se tem o formato completo
        if (value.length < 10) {
          return 'Data incompleta. Use DD/MM/AAAA';
        }

        // Validação básica de formato de data
        final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
        if (!regex.hasMatch(value)) {
          return 'Formato inválido. Use DD/MM/AAAA';
        }

        // Validação de data real (opcional)
        try {
          final parts = value.split('/');
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);

          if (day < 1 || day > 31) return 'Dia inválido';
          if (month < 1 || month > 12) return 'Mês inválido';
          if (year < 1900 || year > DateTime.now().year) return 'Ano inválido';

          // Verificar se é uma data válida
          DateTime(year, month, day);
        } catch (e) {
          return 'Data inválida';
        }

        return null;
      },
    );
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

                // Data de Nascimento
                Text(
                  'Data de Nascimento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),

                // Usar o campo com formatter
                _buildDateFieldWithFormatter(),

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
                    if (_formKey.currentState!.validate()) {
                      // Cadastro completo - ir para tela de permissões
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PermissionsScreen(
                            onComplete: () {
                              // Após permissões, ir para a tela do mapa
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen()),
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
                      borderRadius: BorderRadius.circular(12),
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
