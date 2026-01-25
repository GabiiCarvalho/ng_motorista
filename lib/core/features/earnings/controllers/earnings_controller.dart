import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/firebase_service.dart';

class EarningsController with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  double _dailyEarnings = 0.0;
  double _weeklyEarnings = 0.0;
  double _monthlyEarnings = 0.0;
  double _totalEarnings = 0.0;
  double _appFeeDebt = 0.0;
  double _pendingWithdrawals = 0.0;
  double _availableBalance = 0.0;
  bool _isLoading = false;
  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> _withdrawals = [];

  double get dailyEarnings => _dailyEarnings;
  double get weeklyEarnings => _weeklyEarnings;
  double get monthlyEarnings => _monthlyEarnings;
  double get totalEarnings => _totalEarnings;
  double get appFeeDebt => _appFeeDebt;
  double get pendingWithdrawals => _pendingWithdrawals;
  double get availableBalance => _availableBalance;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get transactions => _transactions;
  List<Map<String, dynamic>> get withdrawals => _withdrawals;

  static const double APP_FEE_PERCENTAGE = 0.15; // 15%
  static const double FIXED_APP_FEE = 125.35;

  Future<void> loadEarnings(String driverId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Carregar transações
      final transactionsSnapshot = await _firebaseService.firestore
          .collection('earnings')
          .where('driverId', isEqualTo: driverId)
          .orderBy('createdAt', descending: true)
          .get();

      _transactions = transactionsSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
        };
      }).toList();

      // Carregar saques
      final withdrawalsSnapshot = await _firebaseService.firestore
          .collection('withdrawals')
          .where('driverId', isEqualTo: driverId)
          .orderBy('createdAt', descending: true)
          .get();

      _withdrawals = withdrawalsSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
        };
      }).toList();

      // Calcular totais
      _calculateTotals();
    } catch (e) {
      print('Erro ao carregar ganhos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _calculateTotals() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final monthStart = DateTime(now.year, now.month, 1);

    _dailyEarnings = 0;
    _weeklyEarnings = 0;
    _monthlyEarnings = 0;
    _totalEarnings = 0;
    _appFeeDebt = 0;
    _pendingWithdrawals = 0;

    for (var transaction in _transactions) {
      final amount = (transaction['amount'] ?? 0).toDouble();
      final createdAt = transaction['createdAt'] as DateTime?;
      final type = transaction['type'] as String?;
      final status = transaction['status'] as String?;

      if (type == 'delivery' && status == 'completed') {
        _totalEarnings += amount;

        if (createdAt != null) {
          if (createdAt.isAfter(today)) {
            _dailyEarnings += amount;
          }
          if (createdAt.isAfter(weekStart)) {
            _weeklyEarnings += amount;
          }
          if (createdAt.isAfter(monthStart)) {
            _monthlyEarnings += amount;
          }
        }
      }

      // Calcular taxa do app
      if (type == 'app_fee') {
        _appFeeDebt += amount;
      }
    }

    // Calcular saldo disponível
    _availableBalance = _totalEarnings - _appFeeDebt - _pendingWithdrawals;

    // Verificar se atingiu a taxa fixa
    if (_appFeeDebt >= FIXED_APP_FEE) {
      // Se atingiu R$125,35, manter o valor fixo
      _appFeeDebt = FIXED_APP_FEE;
    }
  }

  Future<void> addDeliveryEarning({
    required String driverId,
    required double amount,
    required String deliveryId,
    required String customerName,
  }) async {
    try {
      // Calcular taxa do app (15%)
      final appFee = amount * APP_FEE_PERCENTAGE;
      final netEarning = amount - appFee;

      // Salvar transação da entrega
      await _firebaseService.firestore.collection('earnings').add({
        'driverId': driverId,
        'deliveryId': deliveryId,
        'amount': netEarning,
        'type': 'delivery',
        'description': 'Entrega para $customerName',
        'status': 'completed',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Salvar taxa do app
      await _firebaseService.firestore.collection('earnings').add({
        'driverId': driverId,
        'amount': -appFee, // Negativo porque é uma dedução
        'type': 'app_fee',
        'description': 'Taxa do app (15%)',
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Atualizar dívida total do app
      await _updateAppFeeDebt(driverId);

      // Recarregar dados
      await loadEarnings(driverId);
    } catch (e) {
      print('Erro ao adicionar ganho de entrega: $e');
      rethrow;
    }
  }

  Future<void> _updateAppFeeDebt(String driverId) async {
    // Buscar todas as taxas do app pendentes
    final feesSnapshot = await _firebaseService.firestore
        .collection('earnings')
        .where('driverId', isEqualTo: driverId)
        .where('type', isEqualTo: 'app_fee')
        .where('status', isEqualTo: 'pending')
        .get();

    double totalDebt = 0;
    for (var doc in feesSnapshot.docs) {
      totalDebt += (doc.data()['amount'] ?? 0).toDouble();
    }

    // Se atingiu ou ultrapassou R$125,35, consolidar
    if (totalDebt.abs() >= FIXED_APP_FEE) {
      // Criar uma taxa consolidada
      await _firebaseService.firestore.collection('app_fees').add({
        'driverId': driverId,
        'amount': FIXED_APP_FEE,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Marcar as taxas individuais como consolidadas
      for (var doc in feesSnapshot.docs) {
        await doc.reference.update({
          'status': 'consolidated',
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  Future<void> payAppFee(String driverId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Verificar saldo disponível
      if (_availableBalance < _appFeeDebt) {
        throw Exception('Saldo insuficiente para pagar a taxa');
      }

      // Criar transação de pagamento
      await _firebaseService.firestore.collection('payments').add({
        'driverId': driverId,
        'amount': -_appFeeDebt,
        'type': 'app_fee_payment',
        'description': 'Pagamento da taxa do app',
        'status': 'pending',
        'paymentMethod': 'pix',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Atualizar status das taxas
      final feesSnapshot = await _firebaseService.firestore
          .collection('app_fees')
          .where('driverId', isEqualTo: driverId)
          .where('status', isEqualTo: 'pending')
          .get();

      for (var doc in feesSnapshot.docs) {
        await doc.reference.update({
          'status': 'paid',
          'paidAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      // Criar transação de saída
      await _firebaseService.firestore.collection('earnings').add({
        'driverId': driverId,
        'amount': -_appFeeDebt,
        'type': 'app_fee_payment',
        'description': 'Pagamento da taxa do app via PIX',
        'status': 'completed',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Recarregar dados
      await loadEarnings(driverId);
    } catch (e) {
      print('Erro ao pagar taxa do app: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> requestWithdrawal({
    required String driverId,
    required double amount,
    required String pixKey,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Verificar saldo disponível
      if (_availableBalance < amount) {
        throw Exception('Saldo insuficiente para saque');
      }

      // Criar solicitação de saque
      await _firebaseService.firestore.collection('withdrawals').add({
        'driverId': driverId,
        'amount': amount,
        'pixKey': pixKey,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Atualizar saldo pendente
      _pendingWithdrawals += amount;
      _availableBalance -= amount;

      // Criar transação
      await _firebaseService.firestore.collection('earnings').add({
        'driverId': driverId,
        'amount': -amount,
        'type': 'withdrawal',
        'description': 'Solicitação de saque via PIX',
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      notifyListeners();
    } catch (e) {
      print('Erro ao solicitar saque: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> generatePixPayment(double amount) async {
    try {
      // Gerar código PIX (simulado)
      final transactionId = DateTime.now().millisecondsSinceEpoch.toString();
      final pixKey = 'ngmotorista-$transactionId';
      final qrCode =
          '00020126580014BR.GOV.BCB.PIX0136$pixKey5204000053039865405${amount.toStringAsFixed(2)}5802BR5903NG6009SAO PAULO62070503***6304';

      return {
        'pixKey': pixKey,
        'qrCode': qrCode,
        'transactionId': transactionId,
        'amount': amount,
        'expiresAt': DateTime.now().add(Duration(minutes: 30)),
      };
    } catch (e) {
      print('Erro ao gerar pagamento PIX: $e');
      rethrow;
    }
  }
}
