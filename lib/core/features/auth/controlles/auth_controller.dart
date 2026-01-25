import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../services/firebase_service.dart';
import '../../../services/location_service.dart';
import '../../driver/models/driver_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AuthController with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final LocationService _locationService = LocationService();

  User? _currentUser;
  Driver? _currentDriver;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  Driver? get currentDriver => _currentDriver;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthController() {
    _initialize();
  }

  void _initialize() {
    _firebaseService.auth.authStateChanges().listen((User? user) {
      _currentUser = user;
      if (user != null) {
        _loadDriverData(user.uid);
      } else {
        _currentDriver = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadDriverData(String userId) async {
    try {
      final doc = await _firebaseService.firestore
          .collection('drivers')
          .doc(userId)
          .get();

      if (doc.exists) {
        _currentDriver = Driver.fromMap(doc.data()!, doc.id);
      }
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar dados do motorista: $e');
    }
  }

  Future<void> registerWithPhone({
    required String phoneNumber,
    required String name,
    required String email,
    required DateTime birthDate,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Verificar se o telefone já está cadastrado
      final phoneQuery = await _firebaseService.firestore
          .collection('drivers')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (phoneQuery.docs.isNotEmpty) {
        throw Exception('Este número de telefone já está cadastrado');
      }

      // Verificar se o email já está cadastrado
      final emailQuery = await _firebaseService.firestore
          .collection('drivers')
          .where('email', isEqualTo: email)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        throw Exception('Este email já está cadastrado');
      }

      // Criar usuário com email e senha temporária
      final userCredential =
          await _firebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: 'temp_password_${DateTime.now().millisecondsSinceEpoch}',
      );

      // Criar documento do motorista
      final driver = Driver(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phoneNumber,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firebaseService.firestore
          .collection('drivers')
          .doc(userCredential.user!.uid)
          .set(driver.toMap());

      _currentUser = userCredential.user;
      await _loadDriverData(userCredential.user!.uid);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _firebaseService.auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> signInWithPhone({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _firebaseService.auth.signInWithCredential(credential);

      // Obter token FCM e salvar
      final fcmToken = await _firebaseService.messaging.getToken();
      if (fcmToken != null && _currentUser != null) {
        await _firebaseService.saveFCMToken(_currentUser!.uid, fcmToken);
      }
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeDriverProfile({
    required Map<String, dynamic> documents,
    required DriverVehicle vehicle,
    required DriverBankInfo bankInfo,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_currentUser == null) {
        throw Exception('Usuário não autenticado');
      }

      await _firebaseService.firestore
          .collection('drivers')
          .doc(_currentUser!.uid)
          .update({
        'documents': documents,
        'vehicle': vehicle.toMap(),
        'bankInfo': bankInfo.toMap(),
        'profileCompleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await _loadDriverData(_currentUser!.uid);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_currentUser != null) {
        // Atualizar status para offline
        await _firebaseService.setDriverOnlineStatus(_currentUser!.uid, false);
      }

      await _firebaseService.auth.signOut();
      _currentUser = null;
      _currentDriver = null;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    File? photo,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_currentUser == null) {
        throw Exception('Usuário não autenticado');
      }

      final updateData = <String, dynamic>{};

      if (name != null) updateData['name'] = name;
      if (email != null) updateData['email'] = email;
      if (phone != null) updateData['phone'] = phone;

      updateData['updatedAt'] = FieldValue.serverTimestamp();

      await _firebaseService.firestore
          .collection('drivers')
          .doc(_currentUser!.uid)
          .update(updateData);

      await _loadDriverData(_currentUser!.uid);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLocation() async {
    try {
      if (_currentUser == null) return;

      final location = await _locationService.getLocationData();
      if (location.isNotEmpty) {
        await _firebaseService.updateDriverLocation(
          _currentUser!.uid,
          location,
        );
      }
    } catch (e) {
      print('Erro ao atualizar localização: $e');
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
