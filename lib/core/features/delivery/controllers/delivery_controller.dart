import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/firebase_service.dart';
import '../../../core/services/location_service.dart';

class DeliveryController with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final LocationService _locationService = LocationService();

  List<Map<String, dynamic>> _availableDeliveries = [];
  List<Map<String, dynamic>> _activeDeliveries = [];
  List<Map<String, dynamic>> _deliveryHistory = [];
  Map<String, dynamic>? _currentDelivery;
  bool _isLoading = false;
  bool _isListening = false;

  List<Map<String, dynamic>> get availableDeliveries => _availableDeliveries;
  List<Map<String, dynamic>> get activeDeliveries => _activeDeliveries;
  List<Map<String, dynamic>> get deliveryHistory => _deliveryHistory;
  Map<String, dynamic>? get currentDelivery => _currentDelivery;
  bool get isLoading => _isLoading;

  Future<void> loadAvailableDeliveries(String driverId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final snapshot = await _firebaseService.firestore
          .collection('deliveries')
          .where('status', isEqualTo: 'pending')
          .where('driverId', isNull: true)
          .orderBy('createdAt', descending: true)
          .get();

      _availableDeliveries = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
        };
      }).toList();
    } catch (e) {
      print('Erro ao carregar entregas disponíveis: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDriverDeliveries(String driverId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Carregar entregas ativas
      final activeSnapshot = await _firebaseService.firestore
          .collection('deliveries')
          .where('driverId', isEqualTo: driverId)
          .where('status', whereIn: ['accepted', 'picked_up', 'in_progress'])
          .orderBy('createdAt', descending: true)
          .get();

      _activeDeliveries = activeSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
        };
      }).toList();

      // Carregar histórico
      final historySnapshot = await _firebaseService.firestore
          .collection('deliveries')
          .where('driverId', isEqualTo: driverId)
          .where('status', whereIn: ['completed', 'cancelled'])
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();

      _deliveryHistory = historySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
        };
      }).toList();
    } catch (e) {
      print('Erro ao carregar entregas do motorista: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> acceptDelivery({
    required String deliveryId,
    required String driverId,
    required String driverName,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firebaseService.firestore
          .collection('deliveries')
          .doc(deliveryId)
          .update({
        'driverId': driverId,
        'driverName': driverName,
        'status': 'accepted',
        'acceptedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Remover da lista de disponíveis
      _availableDeliveries
          .removeWhere((delivery) => delivery['id'] == deliveryId);

      // Recarregar entregas ativas
      await loadDriverDeliveries(driverId);

      // Iniciar escuta de atualizações
      _startDeliveryListener(deliveryId);
    } catch (e) {
      print('Erro ao aceitar entrega: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startDeliveryListener(String deliveryId) {
    if (_isListening) return;

    _isListening = true;
    _firebaseService.firestore
        .collection('deliveries')
        .doc(deliveryId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data()!;
        _currentDelivery = {
          'id': snapshot.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
        };
        notifyListeners();
      }
    });
  }

  Future<void> updateDeliveryStatus({
    required String deliveryId,
    required String status,
    String? notes,
  }) async {
    try {
      final updateData = {
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (notes != null) {
        updateData['notes'] = notes;
      }

      // Adicionar timestamp específico do status
      switch (status) {
        case 'picked_up':
          updateData['pickedUpAt'] = FieldValue.serverTimestamp();
          break;
        case 'in_progress':
          updateData['startedAt'] = FieldValue.serverTimestamp();
          break;
        case 'completed':
          updateData['completedAt'] = FieldValue.serverTimestamp();
          break;
        case 'cancelled':
          updateData['cancelledAt'] = FieldValue.serverTimestamp();
          break;
      }

      await _firebaseService.firestore
          .collection('deliveries')
          .doc(deliveryId)
          .update(updateData);
    } catch (e) {
      print('Erro ao atualizar status da entrega: $e');
      rethrow;
    }
  }

  Future<void> updateDeliveryLocation({
    required String deliveryId,
    required Map<String, dynamic> location,
  }) async {
    try {
      await _firebaseService.firestore
          .collection('deliveries')
          .doc(deliveryId)
          .update({
        'driverLocation': location,
        'lastLocationUpdate': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erro ao atualizar localização da entrega: $e');
    }
  }

  Future<void> completeDelivery({
    required String deliveryId,
    required String driverId,
    required double amount,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Atualizar status da entrega
      await updateDeliveryStatus(
        deliveryId: deliveryId,
        status: 'completed',
      );

      // Adicionar ganho ao motorista
      final earningsController = EarningsController();
      await earningsController.addDeliveryEarning(
        driverId: driverId,
        amount: amount,
        deliveryId: deliveryId,
        customerName: _currentDelivery?['customerName'] ?? 'Cliente',
      );

      // Limpar entrega atual
      _currentDelivery = null;
      _isListening = false;

      // Recarregar listas
      await loadDriverDeliveries(driverId);
      await loadAvailableDeliveries(driverId);
    } catch (e) {
      print('Erro ao completar entrega: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelDelivery({
    required String deliveryId,
    required String reason,
  }) async {
    try {
      await _firebaseService.firestore
          .collection('deliveries')
          .doc(deliveryId)
          .update({
        'status': 'cancelled',
        'cancellationReason': reason,
        'cancelledAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Limpar entrega atual
      _currentDelivery = null;
      _isListening = false;
    } catch (e) {
      print('Erro ao cancelar entrega: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> calculateDeliveryPrice({
    required double distance,
    required int estimatedTime,
    required String vehicleType,
  }) async {
    // Tarifas base
    double basePrice = vehicleType == 'carro' ? 8.0 : 5.0;
    double perKm = vehicleType == 'carro' ? 2.5 : 1.8;
    double perMinute = 0.3;

    // Cálculo do preço
    double distancePrice = distance * perKm;
    double timePrice = estimatedTime * perMinute;
    double subtotal = basePrice + distancePrice + timePrice;

    // Taxa do app (15%)
    double appFee = subtotal * 0.15;
    double driverEarning = subtotal - appFee;

    return {
      'basePrice': basePrice,
      'distancePrice': distancePrice,
      'timePrice': timePrice,
      'subtotal': subtotal,
      'appFee': appFee,
      'driverEarning': driverEarning,
      'total': subtotal,
    };
  }

  void dispose() {
    _isListening = false;
  }
}
