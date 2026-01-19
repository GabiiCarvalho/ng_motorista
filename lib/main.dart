import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NG MOTORISTA - ENTREGAS',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[400],
          elevation: 0,
        ),
      ),
      home: DeliveryDriverApp(),
    );
  }
}

class DeliveryDriverApp extends StatefulWidget {
  @override
  _DeliveryDriverAppState createState() => _DeliveryDriverAppState();
}

class _DeliveryDriverAppState extends State<DeliveryDriverApp> {
  String _currentScreen = 'main';
  bool _isOnline = false;
  String _activeTab = 'dashboard';
  bool _showProfile = false;
  bool _showEarnings = false;
  bool _showNotifications = false;
  bool _showPreferences = false;
  bool _showDeliveryDetails = false;
  bool _showActiveDelivery = false;
  bool _showVehicleSelection = false;
  String _selectedVehicle = 'carro'; // 'carro' ou 'moto'

  // Dados do motorista
  Map<String, dynamic> _driverData = {
    'name': 'Natanael',
    'rating': 4.97,
    'totalDeliveries': 2000,
    'years': 6,
    'acceptanceRate': 51,
    'completionRate': 96,
    'vehicleType': 'Carro',
    'earnings': {
      'today': 0.00,
      'week': 125.35,
      'lastDelivery': 15.40,
      'perRequest': 25.07,
    },
    'notifications': 16,
    'plate': 'ABC-1234',
    'vehicleModel': 'Toyota Corolla',
  };

  // Dados de entrega ativa
  Map<String, dynamic> _activeDelivery = {
    'id': 'DLV-101',
    'itemType': 'Eletrônicos',
    'pickupAddress': 'Rua João Nestor Simas, 275, Camboriú',
    'pickupContact': 'Gabriele · 47996412384',
    'deliveryAddress':
        'Balneario Shopping, Avenida Santa Catarina, 1 - Estados',
    'deliveryContact': 'Veronica · 47996674426',
    'paymentMethod': 'Dinheiro',
    'price': 16.60,
    'ratePerKm': 2.28,
    'multiplier': 1.6,
    'senderRating': 4.87,
    'senderDeliveries': 15,
    'profileType': 'Perfil Essencial',
    'pickupDistance': '1.4km',
    'pickupTime': '8min',
    'deliveryDistance': '5.8km',
    'deliveryTime': '12min',
    'eta': '13:54',
    'currentStreet': 'Rua João Nestor Simas, 275',
    'nextStreet': 'Av. Minas Gerais',
    'itemDescription': 'Smartphone em embalagem lacrada',
    'itemValue': 'R\$ 1.200,00',
    'deliveryNotes': 'Entregar na portaria do shopping',
    'verificationCode': '1234',
  };

  // Áreas de entrega com multiplicadores
  List<Map<String, dynamic>> _deliveryAreas = [
    {'name': 'Shopping', 'multiplier': '1.1~1.3x', 'demand': 'Alta'},
    {'name': 'TABOLEI', 'multiplier': '1.2~2.0x', 'demand': 'Média'},
    {'name': 'JARDIM I', 'multiplier': '1.2~1.6x', 'demand': 'Alta'},
    {
      'name': 'Uniavan Av. Marginal Oeste',
      'multiplier': '1.5~2.2x',
      'demand': 'Média'
    },
    {'name': 'Rio Pecan', 'multiplier': '1.1~1.8x', 'demand': 'Baixa'},
  ];

  // Recompensas
  List<Map<String, dynamic>> _rewards = [
    {
      'title': 'Ganhe até R\$64',
      'description': 'Finalize 9 entregas',
      'time': 'Começa em 13 min e 52 s',
      'amount': 'R\$9',
      'icon': Icons.local_shipping,
    },
    {
      'title': 'Bônus de final de semana',
      'description': 'Complete 15 entregas no final de semana',
      'amount': 'R\$50',
      'icon': Icons.weekend,
    },
  ];

  // Tipos de itens mais transportados
  List<Map<String, dynamic>> _itemTypes = [
    {'name': 'Documentos', 'percentage': 35, 'icon': Icons.description},
    {'name': 'Eletrônicos', 'percentage': 25, 'icon': Icons.devices},
    {'name': 'Alimentos', 'percentage': 20, 'icon': Icons.fastfood},
    {'name': 'Roupas', 'percentage': 15, 'icon': Icons.checkroom},
    {'name': 'Outros', 'percentage': 5, 'icon': Icons.more_horiz},
  ];

  // Histórico de entregas
  List<Map<String, dynamic>> _deliveryHistory = [
    {
      'id': 'DLV-100',
      'date': '14/01/2026 - 11:30',
      'status': 'Concluída',
      'itemType': 'Documentos',
      'from': 'Av. Brasil, 100',
      'to': 'Rua das Flores, 200',
      'value': 12.50,
      'rating': 5,
    },
    {
      'id': 'DLV-099',
      'date': '13/01/2026 - 15:45',
      'status': 'Concluída',
      'itemType': 'Eletrônicos',
      'from': 'Shopping Center',
      'to': 'Condomínio Solar',
      'value': 18.00,
      'rating': 4,
    },
    {
      'id': 'DLV-098',
      'date': '12/01/2026 - 09:20',
      'status': 'Cancelada',
      'itemType': 'Alimentos',
      'from': 'Restaurante Sabor',
      'to': 'Escola Municipal',
      'value': 0.00,
      'rating': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (_showVehicleSelection) {
      return _buildVehicleSelectionScreen();
    }

    if (_showProfile) {
      return _buildProfileScreen();
    }

    if (_showEarnings) {
      return _buildEarningsScreen();
    }

    if (_showNotifications) {
      return _buildNotificationsScreen();
    }

    if (_showPreferences) {
      return _buildPreferencesScreen();
    }

    if (_showDeliveryDetails) {
      return _buildDeliveryDetailsScreen();
    }

    if (_showActiveDelivery) {
      return _buildActiveDeliveryScreen();
    }

    return _buildMainScreen();
  }

  Widget _buildMainScreen() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho com status online
            Container(
              width: double.infinity,
              color: Colors.orange[400],
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showProfile = true;
                      });
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            _driverData['name'][0],
                            style: TextStyle(
                              color: Colors.orange[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _driverData['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  '${_driverData['rating']} ★',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        _selectedVehicle == 'carro'
                                            ? Icons.directions_car
                                            : Icons.two_wheeler,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        _selectedVehicle == 'carro'
                                            ? 'Carro'
                                            : 'Moto',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Switch(
                        value: _isOnline,
                        onChanged: (value) {
                          setState(() {
                            _isOnline = value;
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey[300],
                      ),
                      Text(
                        _isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Abas
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeTab = 'dashboard';
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Painel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _activeTab == 'dashboard'
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 4),
                          if (_activeTab == 'dashboard')
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeTab = 'map';
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Mapa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _activeTab == 'map'
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 4),
                          if (_activeTab == 'map')
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeTab = 'history';
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Histórico',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _activeTab == 'history'
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 4),
                          if (_activeTab == 'history')
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Conteúdo baseado na aba selecionada
            Expanded(
              child: _activeTab == 'dashboard'
                  ? _buildDashboard()
                  : _activeTab == 'map'
                      ? _buildMapView()
                      : _buildHistoryView(),
            ),

            // Botão conectar (só aparece quando offline)
            if (_activeTab == 'map' && !_isOnline)
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isOnline = true;
                    });
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
                    'Conectar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              icon: Icons.attach_money,
              label: 'Ganhos',
              isActive: false,
              onTap: () {
                setState(() {
                  _showEarnings = true;
                });
              },
            ),
            _buildBottomNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              isActive: false,
              onTap: () {
                // Implementar recompensas
              },
            ),
            _buildBottomNavItem(
              icon: Icons.account_balance_wallet,
              label: 'Saque',
              isActive: false,
              onTap: () {
                // Implementar saque
              },
            ),
            _buildBottomNavItem(
              icon: Icons.help,
              label: 'Ajuda',
              isActive: false,
              onTap: () {
                // Implementar ajuda
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleSelectionScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _showVehicleSelection = false;
            });
          },
        ),
        title: Text('Selecionar Veículo'),
        backgroundColor: Colors.orange[400],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Escolha o tipo de veículo para suas entregas',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 18),
              Expanded(
                child: Column(
                  children: [
                    // Opção Moto
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVehicle = 'moto';
                          _driverData['vehicleType'] = 'Moto';
                          _driverData['vehicleModel'] = 'Honda CG 160';
                          _driverData['plate'] = 'MOT-1234';
                          _showVehicleSelection = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: _selectedVehicle == 'moto'
                              ? Colors.orange[50]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _selectedVehicle == 'moto'
                                ? Colors.orange[400]!
                                : Colors.grey[200]!,
                            width: _selectedVehicle == 'moto' ? 3 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.two_wheeler,
                              size: 80,
                              color: _selectedVehicle == 'moto'
                                  ? Colors.orange[600]
                                  : Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Moto',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _selectedVehicle == 'moto'
                                    ? Colors.orange[600]
                                    : Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Mais rápido • Ideal para itens pequenos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.bolt, color: Colors.amber, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Entrega rápida',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Icon(Icons.money_off,
                                    color: Colors.green, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Mais econômico',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Opção Carro
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVehicle = 'carro';
                          _driverData['vehicleType'] = 'Carro';
                          _driverData['vehicleModel'] = 'Toyota Corolla';
                          _driverData['plate'] = 'CAR-5678';
                          _showVehicleSelection = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _selectedVehicle == 'carro'
                              ? Colors.orange[50]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _selectedVehicle == 'carro'
                                ? Colors.orange[400]!
                                : Colors.grey[200]!,
                            width: _selectedVehicle == 'carro' ? 3 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 80,
                              color: _selectedVehicle == 'carro'
                                  ? Colors.orange[600]
                                  : Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Carro',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _selectedVehicle == 'carro'
                                    ? Colors.orange[600]
                                    : Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Mais espaço • Ideal para itens maiores',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.inventory,
                                    color: Colors.blue, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Mais espaço',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Icon(Icons.security,
                                    color: Colors.purple, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Mais seguro',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (_selectedVehicle.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _selectedVehicle == 'moto'
                            ? Icons.two_wheeler
                            : Icons.directions_car,
                        color: Colors.orange[600],
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Veículo selecionado: ${_selectedVehicle == 'moto' ? 'Moto' : 'Carro'}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.orange[600],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? Colors.orange[400] : Colors.grey[400],
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? Colors.orange[400] : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Notificações
          GestureDetector(
            onTap: () {
              setState(() {
                _showNotifications = true;
              });
            },
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Badge(
                    label: Text('${_driverData['notifications']}'),
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    child: Icon(Icons.notifications, color: Colors.grey[600]),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notificações',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${_driverData['notifications']} não lidas',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey[400]),
                ],
              ),
            ),
          ),

          // Estatísticas
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estatísticas de Entrega',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Esta semana',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Taxa de Aceitação',
                        value: '${_driverData['acceptanceRate']}%',
                        color: Colors.blue[100]!,
                        icon: Icons.check_circle,
                        iconColor: Colors.blue[600]!,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Taxa de Entrega',
                        value: '${_driverData['completionRate']}%',
                        color: Colors.green[100]!,
                        icon: Icons.local_shipping,
                        iconColor: Colors.green[600]!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.two_wheeler, color: Colors.orange[600]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Veículo Atual',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${_driverData['vehicleType']} • ${_driverData['plate']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showVehicleSelection = true;
                          });
                        },
                        child: Text(
                          'Trocar',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Ganhos da semana
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ganhos desta semana',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'R\$${_driverData['earnings']['week']}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildEarningDetail(
                      title: 'Última entrega',
                      value: 'R\$${_driverData['earnings']['lastDelivery']}',
                    ),
                    SizedBox(width: 16),
                    _buildEarningDetail(
                      title: 'Entregas',
                      value: '0',
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildEarningDetail(
                      title: 'Taxa NG',
                      value:
                          '${(_driverData['earnings']['lastDelivery'] / _driverData['earnings']['week'] * 100).toStringAsFixed(2)}%',
                    ),
                    SizedBox(width: 16),
                    _buildEarningDetail(
                      title: '/entrega',
                      value: 'R\$${_driverData['earnings']['perRequest']}',
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showEarnings = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(double.infinity, 0),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Ver Central de ganhos'),
                ),
              ],
            ),
          ),

          // Tipos de itens mais transportados
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tipos de Itens Mais Transportados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ..._itemTypes.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(item['icon'],
                                color: Colors.orange[600], size: 20),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: item['percentage'] / 100,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange[400]!),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          '${item['percentage']}%',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Recompensas
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recompensas Disponíveis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                ..._rewards.map((reward) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            reward['icon'],
                            color: Colors.orange[600],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reward['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                reward['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                              if (reward.containsKey('time'))
                                Text(
                                  reward['time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange[600],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          reward['amount'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningDetail({
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return Stack(
      children: [
        // Simulação do mapa
        Container(
          color: Colors.grey[100],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 100, color: Colors.grey[300]),
                SizedBox(height: 16),
                Text(
                  'Mapa de Entregas',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Áreas com alta demanda de entregas',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Áreas de entrega
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: 180,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_shipping,
                        size: 16, color: Colors.orange[600]),
                    SizedBox(width: 8),
                    Text(
                      'Áreas em Alta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ..._deliveryAreas.map((area) {
                  Color demandColor;
                  switch (area['demand']) {
                    case 'Alta':
                      demandColor = Colors.red[400]!;
                      break;
                    case 'Média':
                      demandColor = Colors.orange[400]!;
                      break;
                    default:
                      demandColor = Colors.green[400]!;
                  }

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: demandColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                area['name'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Demanda: ${area['demand']}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Text(
                            area['multiplier'],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),

        // Botão de trocar veículo
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showVehicleSelection = true;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedVehicle == 'carro'
                        ? Icons.directions_car
                        : Icons.two_wheeler,
                    size: 16,
                    color: Colors.orange[600],
                  ),
                  SizedBox(width: 8),
                  Text(
                    _selectedVehicle == 'carro' ? 'Carro' : 'Moto',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryView() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Histórico de Entregas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ..._deliveryHistory.map((delivery) {
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Cabeçalho da entrega
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            delivery['id'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            delivery['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: delivery['status'] == 'Concluída'
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          delivery['status'],
                          style: TextStyle(
                            fontSize: 12,
                            color: delivery['status'] == 'Concluída'
                                ? Colors.green[700]
                                : Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Detalhes da entrega
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.inventory,
                              size: 16, color: Colors.grey[500]),
                          SizedBox(width: 8),
                          Text(
                            'Item: ${delivery['itemType']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_upward,
                              size: 16, color: Colors.orange[600]),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Coleta: ${delivery['from']}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_downward,
                              size: 16, color: Colors.green[600]),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Entrega: ${delivery['to']}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star,
                                  size: 16,
                                  color: delivery['rating'] > 0
                                      ? Colors.amber
                                      : Colors.grey[300]),
                              SizedBox(width: 4),
                              Text(
                                delivery['rating'] > 0
                                    ? '${delivery['rating']} ★'
                                    : 'Sem avaliação',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: delivery['rating'] > 0
                                      ? Colors.amber[700]
                                      : Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            delivery['value'] > 0
                                ? 'R\$${delivery['value']}'
                                : 'Cancelada',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: delivery['value'] > 0
                                  ? Colors.green[600]
                                  : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildProfileScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _showProfile = false;
            });
          },
        ),
        title: Text('Meu Perfil'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho do perfil
            Container(
              padding: EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.orange[100],
                    child: Text(
                      _driverData['name'][0],
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[600],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _driverData['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Motorista de Entregas',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${_driverData['totalDeliveries']}+',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Entregas',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 32),
                      Column(
                        children: [
                          Text(
                            '${_driverData['years']}+',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Anos',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 32),
                      Column(
                        children: [
                          Text(
                            '${_driverData['rating']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              Text(
                                ' Avaliação',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Informações do veículo
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Veículo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showVehicleSelection = true;
                            _showProfile = false;
                          });
                        },
                        child: Text(
                          'Trocar',
                          style: TextStyle(
                            color: Colors.orange[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        _selectedVehicle == 'carro'
                            ? Icons.directions_car
                            : Icons.two_wheeler,
                        size: 40,
                        color: Colors.orange[600],
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _driverData['vehicleType'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _driverData['vehicleModel'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Placa: ${_driverData['plate']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _selectedVehicle == 'carro'
                          ? 'Capacidade: Itens de até 100×70×60cm e 30kg'
                          : 'Capacidade: Itens de até 40×34×36cm e 10kg',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Estatísticas detalhadas
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estatísticas Detalhadas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildProfileStatItem(
                    title: 'Entregas Concluídas',
                    value: '${_driverData['totalDeliveries']}',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                  Divider(),
                  _buildProfileStatItem(
                    title: 'Taxa de Aceitação',
                    value: '${_driverData['acceptanceRate']}%',
                    icon: Icons.thumb_up,
                    color: Colors.blue,
                  ),
                  Divider(),
                  _buildProfileStatItem(
                    title: 'Taxa de Entrega',
                    value: '${_driverData['completionRate']}%',
                    icon: Icons.local_shipping,
                    color: Colors.orange,
                  ),
                  Divider(),
                  _buildProfileStatItem(
                    title: 'Avaliação Média',
                    value: '${_driverData['rating']} ★',
                    icon: Icons.star,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),

            // Preferências
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferências',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildPreferenceItem(
                    title: 'Definir minha área de atuação',
                    icon: Icons.location_on,
                    onTap: () {
                      setState(() {
                        _showPreferences = true;
                      });
                    },
                  ),
                  Divider(),
                  _buildPreferenceItem(
                    title: 'Configurar tipos de itens',
                    icon: Icons.settings,
                    onTap: () {
                      setState(() {
                        _showPreferences = true;
                      });
                    },
                  ),
                  Divider(),
                  _buildPreferenceItem(
                    title: 'Horários de trabalho',
                    icon: Icons.access_time,
                    onTap: () {
                      setState(() {
                        _showPreferences = true;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Botão sair
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isOnline = false;
                    _showProfile = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Desconectar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: color, size: 20),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600]),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  // As outras telas (_buildEarningsScreen, _buildNotificationsScreen,
  // _buildPreferencesScreen, _buildDeliveryDetailsScreen, _buildActiveDeliveryScreen)
  // permanecem similares mas ajustadas para entregas de itens.
  // Por questão de espaço, vou incluir apenas as telas principais.
  // As demais seguem o mesmo padrão de ajuste.

  Widget _buildEarningsScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _showEarnings = false;
            });
          },
        ),
        title: Text('Central de Ganhos'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ganhos do dia (jan.18)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'R\$${_driverData['earnings']['today']}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meus Recursos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildResourceItem(
                    title: 'Saldo Disponível',
                    value: 'R\$${_driverData['earnings']['week']}',
                    icon: Icons.account_balance_wallet,
                    color: Colors.green[600]!,
                  ),
                  Divider(),
                  _buildResourceItem(
                    title: 'Método de Resgate',
                    subtitle: 'Conta bancária',
                    value: 'R\$0,00',
                    icon: Icons.account_balance,
                    color: Colors.blue[600]!,
                  ),
                  Divider(),
                  _buildResourceItem(
                    title: 'Conta NG',
                    subtitle: 'Saque quando quiser',
                    value: 'R\$0,00',
                    icon: Icons.attach_money,
                    color: Colors.orange[600]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem({
    required String title,
    String? subtitle,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: color),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetailsScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _showDeliveryDetails = false;
            });
          },
        ),
        title: Text('Detalhes da Entrega'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.inventory,
                              size: 20, color: Colors.orange[600]),
                          SizedBox(width: 8),
                          Text(
                            _activeDelivery['itemType'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Entrega #${_activeDelivery['id']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'R\$${_activeDelivery['price']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                      Text(
                        'x${_activeDelivery['multiplier']} • ${_activeDelivery['ratePerKm']}/km',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Informações do remetente
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange[400],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Coleta',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${_activeDelivery['pickupTime']} (${_activeDelivery['pickupDistance']})',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _activeDelivery['pickupAddress'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _activeDelivery['pickupContact'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Informações do destinatário
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange[400]!,
                            width: 2,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Entrega',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${_activeDelivery['deliveryTime']} (${_activeDelivery['deliveryDistance']})',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _activeDelivery['deliveryAddress'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _activeDelivery['deliveryContact'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Detalhes do item
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalhes do Item',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildItemDetail(
                      'Descrição', _activeDelivery['itemDescription']),
                  SizedBox(height: 8),
                  _buildItemDetail(
                      'Valor do Item', _activeDelivery['itemValue']),
                  SizedBox(height: 8),
                  _buildItemDetail(
                      'Observações', _activeDelivery['deliveryNotes']),
                  SizedBox(height: 8),
                  _buildItemDetail('Código de Verificação',
                      _activeDelivery['verificationCode']),
                ],
              ),
            ),

            // Método de pagamento
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.payments, color: Colors.green[600]),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _activeDelivery['paymentMethod'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Não afeta a TA',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Botões de ação
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showDeliveryDetails = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Recusar'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showDeliveryDetails = false;
                          _showActiveDelivery = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Aceitar Entrega'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveDeliveryScreen() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chegada prevista: ${_activeDelivery['eta']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _activeDelivery['currentStreet'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'R\$${_activeDelivery['price']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                      Text(
                        'x${_activeDelivery['multiplier']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Mapa/instruções
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _selectedVehicle == 'carro'
                            ? Icons.directions_car
                            : Icons.two_wheeler,
                        size: 100,
                        color: Colors.orange[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Siga para ${_activeDelivery['nextStreet']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Próxima entrega: ${_activeDelivery['deliveryAddress']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Código de Entrega',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _activeDelivery['verificationCode'],
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[600],
                                letterSpacing: 8,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Solicite este código na entrega',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Informações do item
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.inventory, size: 24, color: Colors.orange[600]),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _activeDelivery['itemType'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _activeDelivery['itemDescription'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Implementar chamada
                    },
                    icon: Icon(Icons.phone, color: Colors.green[600]),
                  ),
                  IconButton(
                    onPressed: () {
                      // Implementar mensagem
                    },
                    icon: Icon(Icons.message, color: Colors.blue[600]),
                  ),
                ],
              ),
            ),

            // Botões de controle
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showActiveDelivery = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Problema'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implementar chegada
                        setState(() {
                          _showActiveDelivery = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Entregue'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _showNotifications = false;
            });
          },
        ),
        title: Text('Notificações'),
        backgroundColor: Colors.orange[400],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            title: 'Nova entrega disponível',
            message: 'Entrega de eletrônicos - 5.8km',
            time: 'Há 5 minutos',
            isUnread: true,
            icon: Icons.local_shipping,
          ),
          _buildNotificationItem(
            title: 'Pagamento recebido',
            message: 'R\$15,40 creditado na sua conta',
            time: 'Há 1 hora',
            isUnread: true,
            icon: Icons.payments,
          ),
          _buildNotificationItem(
            title: 'Recompensa disponível',
            message: 'Complete 3 entregas e ganhe R\$10',
            time: 'Ontem',
            isUnread: true,
            icon: Icons.card_giftcard,
          ),
          _buildNotificationItem(
            title: 'Avaliação recebida',
            message: 'Você recebeu 5★ na entrega #DLV-100',
            time: '2 dias atrás',
            isUnread: false,
            icon: Icons.star,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required bool isUnread,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange[50],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, size: 20, color: Colors.orange[600]),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isUnread ? Colors.black : Colors.grey[600],
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange[400],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _showPreferences = false;
            });
          },
        ),
        title: Text('Preferências'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Configurações de Entregas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildPreferenceItem(
                    title: 'Definir minha área de atuação',
                    icon: Icons.location_on,
                    onTap: () {},
                  ),
                  Divider(),
                  _buildPreferenceItem(
                    title: 'Tipos de itens aceitos',
                    icon: Icons.inventory,
                    onTap: () {},
                  ),
                  Divider(),
                  _buildPreferenceItem(
                    title: 'Horários de trabalho',
                    icon: Icons.access_time,
                    onTap: () {},
                  ),
                  Divider(),
                  _buildPreferenceItem(
                    title: 'Preferências de pagamento',
                    icon: Icons.payments,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Configurações do Veículo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildPreferenceItem(
                    title: 'Trocar veículo',
                    icon: _selectedVehicle == 'carro'
                        ? Icons.directions_car
                        : Icons.two_wheeler,
                    onTap: () {
                      setState(() {
                        _showPreferences = false;
                        _showVehicleSelection = true;
                      });
                    },
                  ),
                  Divider(),
                  _buildPreferenceItem(
                    title: 'Atualizar dados do veículo',
                    icon: Icons.edit,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
