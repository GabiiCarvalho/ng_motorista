class Driver {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;
  final double rating;
  final int totalDeliveries;
  final Map<String, dynamic>? location;
  final bool isOnline;
  final bool isAvailable;
  final String? fcmToken;
  final DateTime? lastLocationUpdate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DriverDocuments? documents;
  final DriverVehicle? vehicle;
  final DriverBankInfo? bankInfo;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl,
    this.rating = 0.0,
    this.totalDeliveries = 0,
    this.location,
    this.isOnline = false,
    this.isAvailable = true,
    this.fcmToken,
    this.lastLocationUpdate,
    this.createdAt,
    this.updatedAt,
    this.documents,
    this.vehicle,
    this.bankInfo,
  });

  factory Driver.fromMap(Map<String, dynamic> data, String id) {
    return Driver(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      photoUrl: data['photoUrl'],
      rating: (data['rating'] ?? 0.0).toDouble(),
      totalDeliveries: data['totalDeliveries'] ?? 0,
      location: data['location'] is Map
          ? Map<String, dynamic>.from(data['location'])
          : null,
      isOnline: data['isOnline'] ?? false,
      isAvailable: data['isAvailable'] ?? true,
      fcmToken: data['fcmToken'],
      lastLocationUpdate: data['lastLocationUpdate']?.toDate(),
      createdAt: data['createdAt']?.toDate(),
      updatedAt: data['updatedAt']?.toDate(),
      documents: data['documents'] != null
          ? DriverDocuments.fromMap(
              Map<String, dynamic>.from(data['documents']))
          : null,
      vehicle: data['vehicle'] != null
          ? DriverVehicle.fromMap(Map<String, dynamic>.from(data['vehicle']))
          : null,
      bankInfo: data['bankInfo'] != null
          ? DriverBankInfo.fromMap(Map<String, dynamic>.from(data['bankInfo']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'rating': rating,
      'totalDeliveries': totalDeliveries,
      'location': location,
      'isOnline': isOnline,
      'isAvailable': isAvailable,
      'fcmToken': fcmToken,
      'lastLocationUpdate': lastLocationUpdate,
      'createdAt': createdAt,
      'updatedAt': FieldValue.serverTimestamp(),
      'documents': documents?.toMap(),
      'vehicle': vehicle?.toMap(),
      'bankInfo': bankInfo?.toMap(),
    };
  }
}

class DriverDocuments {
  final String? cnhUrl;
  final String? crlvUrl;
  final String? proofOfAddressUrl;
  final bool cnhVerified;
  final bool crlvVerified;
  final DateTime? cnhVerifiedAt;
  final DateTime? crlvVerifiedAt;

  DriverDocuments({
    this.cnhUrl,
    this.crlvUrl,
    this.proofOfAddressUrl,
    this.cnhVerified = false,
    this.crlvVerified = false,
    this.cnhVerifiedAt,
    this.crlvVerifiedAt,
  });

  factory DriverDocuments.fromMap(Map<String, dynamic> data) {
    return DriverDocuments(
      cnhUrl: data['cnhUrl'],
      crlvUrl: data['crlvUrl'],
      proofOfAddressUrl: data['proofOfAddressUrl'],
      cnhVerified: data['cnhVerified'] ?? false,
      crlvVerified: data['crlvVerified'] ?? false,
      cnhVerifiedAt: data['cnhVerifiedAt']?.toDate(),
      crlvVerifiedAt: data['crlvVerifiedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cnhUrl': cnhUrl,
      'crlvUrl': crlvUrl,
      'proofOfAddressUrl': proofOfAddressUrl,
      'cnhVerified': cnhVerified,
      'crlvVerified': crlvVerified,
      'cnhVerifiedAt': cnhVerifiedAt,
      'crlvVerifiedAt': crlvVerifiedAt,
    };
  }
}

class DriverVehicle {
  final String type; // 'carro' ou 'moto'
  final String plate;
  final String model;
  final String color;
  final int year;
  final String? photoUrl;

  DriverVehicle({
    required this.type,
    required this.plate,
    required this.model,
    required this.color,
    required this.year,
    this.photoUrl,
  });

  factory DriverVehicle.fromMap(Map<String, dynamic> data) {
    return DriverVehicle(
      type: data['type'] ?? 'carro',
      plate: data['plate'] ?? '',
      model: data['model'] ?? '',
      color: data['color'] ?? '',
      year: data['year'] ?? DateTime.now().year,
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'plate': plate,
      'model': model,
      'color': color,
      'year': year,
      'photoUrl': photoUrl,
    };
  }
}

class DriverBankInfo {
  final String bankName;
  final String accountType; // 'corrente' ou 'poupança'
  final String agency;
  final String account;
  final String pixKey;
  final String pixType; // 'cpf', 'email', 'telefone', 'aleatoria'

  DriverBankInfo({
    required this.bankName,
    required this.accountType,
    required this.agency,
    required this.account,
    required this.pixKey,
    required this.pixType,
  });

  factory DriverBankInfo.fromMap(Map<String, dynamic> data) {
    return DriverBankInfo(
      bankName: data['bankName'] ?? '',
      accountType: data['accountType'] ?? 'corrente',
      agency: data['agency'] ?? '',
      account: data['account'] ?? '',
      pixKey: data['pixKey'] ?? '',
      pixType: data['pixType'] ?? 'cpf',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'accountType': accountType,
      'agency': agency,
      'account': account,
      'pixKey': pixKey,
      'pixType': pixType,
    };
  }
}
