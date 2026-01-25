import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/services/storage_service.dart';
import '../../../core/services/firebase_service.dart';

class DocumentUploadWidget extends StatefulWidget {
  final String userId;
  final String documentType;
  final String documentName;
  final Function(String?) onUploadComplete;

  const DocumentUploadWidget({
    Key? key,
    required this.userId,
    required this.documentType,
    required this.documentName,
    required this.onUploadComplete,
  }) : super(key: key);

  @override
  _DocumentUploadWidgetState createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  final StorageService _storageService = StorageService();
  final FirebaseService _firebaseService = FirebaseService();

  File? _selectedFile;
  String? _uploadedUrl;
  bool _isUploading = false;
  String? _errorMessage;

  Future<void> _pickImage() async {
    try {
      final File? image = await _storageService.pickImage(ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedFile = image;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao selecionar imagem: $e';
      });
    }
  }

  Future<void> _takePhoto() async {
    try {
      final File? image = await _storageService.pickImage(ImageSource.camera);
      if (image != null) {
        setState(() {
          _selectedFile = image;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao tirar foto: $e';
      });
    }
  }

  Future<void> _uploadDocument() async {
    if (_selectedFile == null) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      final String? url = await _storageService.uploadFile(
        file: _selectedFile!,
        userId: widget.userId,
        documentType: widget.documentType,
      );

      if (url != null) {
        setState(() {
          _uploadedUrl = url;
        });

        // Atualizar Firestore
        await _updateDriverDocument(url);

        widget.onUploadComplete(url);
      } else {
        throw Exception('Falha no upload');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro no upload: $e';
      });
      widget.onUploadComplete(null);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _updateDriverDocument(String url) async {
    final updateData = {
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // Adicionar URL do documento específico
    switch (widget.documentType) {
      case 'cnh':
        updateData['documents.cnhUrl'] = url;
        updateData['documents.cnhVerified'] = false;
        updateData['documents.cnhUploadedAt'] = FieldValue.serverTimestamp();
        break;
      case 'crlv':
        updateData['documents.crlvUrl'] = url;
        updateData['documents.crlvVerified'] = false;
        updateData['documents.crlvUploadedAt'] = FieldValue.serverTimestamp();
        break;
      case 'proof_of_address':
        updateData['documents.proofOfAddressUrl'] = url;
        break;
    }

    await _firebaseService.firestore
        .collection('drivers')
        .doc(widget.userId)
        .update(updateData);
  }

  void _removeDocument() {
    setState(() {
      _selectedFile = null;
      _uploadedUrl = null;
    });
    widget.onUploadComplete(null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.documentName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            if (_uploadedUrl != null)
              _buildUploadedState()
            else if (_selectedFile != null)
              _buildSelectedFileState()
            else
              _buildEmptyState(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Text(
          'Documento não enviado',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.photo_library),
                label: Text('Galeria'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _takePhoto,
                icon: Icon(Icons.camera_alt),
                label: Text('Câmera'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedFileState() {
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: FileImage(_selectedFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _removeDocument,
                icon: Icon(Icons.delete),
                label: Text('Remover'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isUploading ? null : _uploadDocument,
                icon: _isUploading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(Icons.cloud_upload),
                label: Text(_isUploading ? 'Enviando...' : 'Enviar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadedState() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Documento enviado com sucesso!',
                style: TextStyle(color: Colors.green),
              ),
            ),
            IconButton(
              onPressed: _removeDocument,
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Status: Aguardando verificação',
          style: TextStyle(color: Colors.orange),
        ),
      ],
    );
  }
}
