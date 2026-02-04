import 'package:flutter/material.dart';
import '../pages/map_screen_driver.dart';

class FacialVerificationScreen extends StatefulWidget {
  @override
  _FacialVerificationScreenState createState() =>
      _FacialVerificationScreenState();
}

class _FacialVerificationScreenState extends State<FacialVerificationScreen> {
  bool _isVerifying = false;
  bool _isVerified = false;

  void _startVerification() {
    setState(() {
      _isVerifying = true;
    });

    // Simula o processo de verificação facial
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isVerifying = false;
        _isVerified = true;
      });
    });
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapScreenDriver()),
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
                  onPressed: _startVerification,
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
