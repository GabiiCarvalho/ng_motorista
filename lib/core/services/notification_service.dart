import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        _onNotificationTap(response.payload);
      },
    );

    // Configurar canal para Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Configurar Firebase Messaging
    await _configureFirebaseMessaging();
  }

  Future<void> _configureFirebaseMessaging() async {
    // Configurar para mostrar notificações quando o app está em primeiro plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'Mensagem recebida em primeiro plano: ${message.notification?.title}');

      // Mostrar notificação local
      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: message.data.toString(),
        );
      }
    });

    // Quando o app está em segundo plano e a notificação é tocada
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App aberto a partir de notificação em segundo plano');
      _handleNotificationData(message.data);
    });

    // Quando o app está totalmente fechado e aberto por notificação
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationData(initialMessage.data);
    }
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

  void _onNotificationTap(String? payload) {
    if (payload != null) {
      _handleNotificationTap(payload);
    }
  }

  void _handleNotificationTap(String payload) {
    try {
      // Parse do payload e navegação
      // Exemplo: {'type': 'new_delivery', 'deliveryId': '123'}
      print('Notificação tocada: $payload');

      // Aqui você implementaria a navegação para a tela apropriada
      // usando Navigator ou outro método de gerenciamento de rotas
    } catch (e) {
      print('Erro ao processar toque na notificação: $e');
    }
  }

  void _handleNotificationData(Map<String, dynamic> data) {
    final type = data['type'];

    switch (type) {
      case 'new_delivery':
        final deliveryId = data['deliveryId'];
        // Navegar para tela de detalhes da entrega
        break;
      case 'payment_confirmed':
        final paymentId = data['paymentId'];
        // Navegar para tela de pagamentos
        break;
      case 'app_fee_reminder':
        // Navegar para tela de ganhos
        break;
    }
  }

  Future<void> scheduleAppFeeReminder() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    // Agendar notificação para lembrar da taxa do app
    await _notificationsPlugin.periodicallyShow(
      1,
      'Lembrete da Taxa do App',
      'Não se esqueça de pagar sua taxa de R\$125,35',
      RepeatInterval.daily,
      platformDetails,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
