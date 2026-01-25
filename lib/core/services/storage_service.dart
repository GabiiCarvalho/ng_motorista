import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadFile({
    required File file,
    required String userId,
    required String documentType,
  }) async {
    try {
      String fileName =
          '${documentType}_${DateTime.now().millisecondsSinceEpoch}';
      String path = 'drivers/$userId/documents/$fileName';

      TaskSnapshot snapshot = await _storage.ref(path).putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload do arquivo: $e');
      return null;
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
    return null;
  }

  Future<String?> uploadDriverPhoto({
    required File file,
    required String userId,
  }) async {
    try {
      String path = 'drivers/$userId/profile/profile_photo';

      TaskSnapshot snapshot = await _storage.ref(path).putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload da foto: $e');
      return null;
    }
  }

  Future<String?> uploadVehiclePhoto({
    required File file,
    required String userId,
    required String vehicleId,
  }) async {
    try {
      String path = 'drivers/$userId/vehicles/$vehicleId/photo';

      TaskSnapshot snapshot = await _storage.ref(path).putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload da foto do veículo: $e');
      return null;
    }
  }

  Future<void> deleteFile(String url) async {
    try {
      await _storage.refFromURL(url).delete();
    } catch (e) {
      print('Erro ao deletar arquivo: $e');
    }
  }
}
