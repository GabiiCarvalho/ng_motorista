import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  static FirebaseFirestore? _firestore;
  static FirebaseAuth? _auth;
  static FirebaseStorage? _storage;
  static FirebaseMessaging? _messaging;

  Future<void> initialize() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _storage = FirebaseStorage.instance;
    _messaging = FirebaseMessaging.instance;

    await _configureMessaging();
  }

  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception(
          'Firebase não inicializado. Chame initialize() primeiro.');
    }
    return _firestore!;
  }

  static FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception(
          'Firebase não inicializado. Chame initialize() primeiro.');
    }
    return _auth!;
  }

  static FirebaseStorage get storage {
    if (_storage == null) {
      throw Exception(
          'Firebase não inicializado. Chame initialize() primeiro.');
    }
    return _storage!;
  }

  static FirebaseMessaging get messaging {
    if (_messaging == null) {
      throw Exception(
          'Firebase não inicializado. Chame initialize() primeiro.');
    }
    return _messaging!;
  }

  Future<void> _configureMessaging() async {
    // Solicitar permissão para notificações
    NotificationSettings setting = await _messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      print('Usuário concedeu permissão para notificação');

      // Obter token FCM
      String? token = await _messaging!.getToken();
      print('FCM Token: $token');

      // Salvar token no FireStore para usuário atual
      if (_auth!.currentUser != null && token != null) {
        await saveFCMToken(_auth!.currentUser!.uid, token);
      }
    }

    // Configurar handlers para mensagens em primeiro plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'Mensagem recebida em primeiro plano: ${message.notification?.title}');
      // Aqui você pode mostrar uma notificação local
    });

    // Configurar handlers para quando o app está em segundo plano
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App aberto a partir de notificação em segundo plano');
      // Navegar para a tela apropriada
    });
  }

  Future<void> saveFCMToken(String userId, String token) async {
    await firestore.collection('drivers').doc(userId).update({
      'fcmToken': token,
      'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDriverLocation(
      String userId, Map<String, dynamic> location) async {
    await firestore.collection('drivers').doc(userId).update({
      'location': location,
      'lastLocationUpdate': FieldValue.serverTimestamp(),
      'isOnline': true,
    });
  }

  Future<void> setDriverOnlineStatus(String userId, bool isOnline) async {
    await firestore.collection('drivers').doc(userId).update({
      'isOnline': isOnline,
      'lastStatusUpdate': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendDeliveryRequestToDrivers(
      Map<String, dynamic> deliveryData) async {
    // Buscar motoristas online próximos à localização da entrega
    final driversSnapshot = await firestore
        .collection('drivers')
        .where('isOnline', isEqualTo: true)
        .where('isAvailable', isEqualTo: true)
        .get();

    for (var doc in driversSnapshot.docs) {
      final driver = doc.data();
      final driverLocation = driver['location'] as Map<String, dynamic>?;
      final fcmToken = driver['fcmToken'] as String?;

      if (driverLocation != null && fcmToken != null) {
        //Calcular distância (simplificado - na prática use uma função de cálculo de distância)
        // Enviar notificação para o motorista
        await _sendNotificationToDriver(
          fcmToken,
          deliveryData,
          driver['name'] ?? 'Motorista',
        );
      }
    }
  }

  Future<void> _sendNotificationToDriver(
    String fcmToken,
    Map<String, dynamic> deliveryData,
    String driverName,
  ) async {
    // Aqui você implementaria o envio via Cloud Functions ou HTTP request
    // Para simplificar, vamos utilizar o Firestore
    await firestore.collection('notifications').add({
      'driverId': FirebaseAuth.instance.currentUser?.uid,
      'fcmToken': fcmToken,
      'deliveryData': deliveryData,
      'title': 'Nova corrida disponível',
      'body': 'Uma nova entrega está disponível na sua área',
      'createdAt': FieldValue.serverTimestamp(),
      'read': false,
    });
  }
}
