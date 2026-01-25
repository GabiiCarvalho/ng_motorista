import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import '../../../core/services/storage_service.dart';

class FacialVerificationWidget extends StatefulWidget {
  final String userId;
  final Function(bool) onVerificationComplete;

  const FacialVerificationWidget({
    Key? key,
    required this.userId,
    required this.onVerificationComplete,
  }) : super(key: key);

  @override
  _FacialVerificationWidgetState createState() =>
      _FacialVerificationWidgetState();
}

class _FacialVerificationWidgetState extends State<FacialVerificationWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isVerifying = false;
  bool _isVerified = false;
  String _verificationStatus = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _captureAndVerify() async {
    if (!_controller.value.isInitialized || _isVerifying) {
      return;
    }

    setState(() {
      _isVerifying = true;
      _verificationStatus = 'Analisando seu rosto...';
    });

    try {
      // Tirar foto
      final image = await _controller.takePicture();

      // Aqui você implementaria a lógica de verificação facial
      // Para este exemplo, vamos simular uma verificação

      await Future.delayed(Duration(seconds: 2));

      // Simular upload e verificação
      final File imageFile = File(image.path);
      final storageService = StorageService();

      final String? imageUrl = await storageService.uploadFile(
        file: imageFile,
        userId: widget.userId,
        documentType: 'facial_verification',
      );

      if (imageUrl != null) {
        // Simular verificação bem-sucedida
        await Future.delayed(Duration(seconds: 1));

        setState(() {
          _isVerified = true;
          _verificationStatus = 'Verificação facial concluída!';
        });

        widget.onVerificationComplete(true);
      } else {
        throw Exception('Falha ao fazer upload da imagem');
      }
    } catch (e) {
      setState(() {
        _verificationStatus = 'Erro na verificação: $e';
      });

      widget.onVerificationComplete(false);
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificação Facial'),
        backgroundColor: Colors.orange[400],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Text(
                  'Posicione seu rosto dentro do círculo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                if (_verificationStatus.isNotEmpty)
                  Text(
                    _verificationStatus,
                    style: TextStyle(
                      color: _isVerified ? Colors.green : Colors.orange,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 20),
                if (!_isVerified)
                  ElevatedButton.icon(
                    onPressed: _isVerifying ? null : _captureAndVerify,
                    icon: Icon(Icons.camera_alt),
                    label: Text(_isVerifying ? 'Verificando...' : 'Tirar Foto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                if (_isVerified)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.check_circle),
                    label: Text('Continuar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
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
