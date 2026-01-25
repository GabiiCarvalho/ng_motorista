import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clipboard/clipboard.dart';
import '../../../features/earnings/controllers/earnings_controller.dart';

class PixPaymentScreen extends StatefulWidget {
  final double amount;
  final String driverId;

  const PixPaymentScreen({
    Key? key,
    required this.amount,
    required this.driverId,
  }) : super(key: key);

  @override
  _PixPaymentScreenState createState() => _PixPaymentScreenState();
}

class _PixPaymentScreenState extends State<PixPaymentScreen> {
  final EarningsController _earningsController = EarningsController();
  Map<String, dynamic>? _pixData;
  bool _isLoading = false;
  bool _isCopied = false;
  bool _paymentConfirmed = false;

  @override
  void initState() {
    super.initState();
    _generatePixPayment();
  }

  Future<void> _generatePixPayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _pixData = await _earningsController.generatePixPayment(widget.amount);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao gerar pagamento PIX: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _copyToClipboard() async {
    if (_pixData?['pixKey'] != null) {
      await Clipboard.setData(ClipboardData(text: _pixData!['pixKey']));
      setState(() {
        _isCopied = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Chave PIX copiada!'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isCopied = false;
          });
        }
      });
    }
  }

  Future<void> _confirmPayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _earningsController.payAppFee(widget.driverId);

      setState(() {
        _paymentConfirmed = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pagamento confirmado com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Aguardar e voltar
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context, true);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao confirmar pagamento: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento via PIX'),
        backgroundColor: Colors.orange[400],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pixData == null
              ? Center(child: Text('Erro ao gerar pagamento'))
              : _buildPaymentContent(),
    );
  }

  Widget _buildPaymentContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Cabeçalho
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Valor a Pagar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'R\$${widget.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[600],
                  ),
                ),
                Text(
                  'Taxa do App',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // QR Code
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                Text(
                  'Escaneie o QR Code',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                QrImageView(
                  data: _pixData!['qrCode'],
                  version: QrVersions.auto,
                  size: 200,
                ),
                SizedBox(height: 16),
                Text(
                  'Ou use a chave PIX abaixo',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Chave PIX
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
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
                SizedBox(height: 8),
                SelectableText(
                  _pixData!['pixKey'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _copyToClipboard,
                  icon: Icon(_isCopied ? Icons.check : Icons.copy),
                  label: Text(_isCopied ? 'Copiado!' : 'Copiar Chave'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Instruções
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
                  'Instruções para pagamento:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                _buildInstructionStep(1, 'Abra seu aplicativo bancário'),
                _buildInstructionStep(2, 'Acesse a função PIX'),
                _buildInstructionStep(3, 'Escaneie o QR Code ou cole a chave'),
                _buildInstructionStep(4, 'Confirme o pagamento'),
                _buildInstructionStep(5, 'Aguarde a confirmação'),
              ],
            ),
          ),

          SizedBox(height: 30),

          // Botões
          if (!_paymentConfirmed)
            Column(
              children: [
                ElevatedButton(
                  onPressed: _confirmPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Já efetuei o pagamento',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _generatePixPayment,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Gerar novo QR Code'),
                ),
              ],
            )
          else
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Pagamento confirmado! Obrigado.',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 20),
        ],
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
      ),
    );
  }
}
