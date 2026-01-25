import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Stream<Position>? _positionStream;
  Position? _lastPosition;

  Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      // Solicitar permissão de localização em segundo plano
      final backgroundStatus = await Permission.locationAlways.request();
      return backgroundStatus.isGranted;
    }

    return status.isGranted;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Serviço de localização desativado');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Permissão de localização negada permanentemente');
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw Exception('Permissão de localização negada');
        }
      }

      _lastPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      return _lastPosition;
    } catch (e) {
      print('Erro ao obter localização: $e');
      return null;
    }
  }

  Stream<Position> getLocationStream() {
    if (_positionStream == null) {
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 10, // Atualizar a cada 10 metros
          timeLimit: Duration(seconds: 30),
        ),
      );
    }
    return _positionStream!;
  }

  Future<String?> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return '${place.street}, ${place.subLocality}, ${place.locality}';
      }
    } catch (e) {
      print('Erro ao obter endereço: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>> getLocationData() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      String? address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'altitude': position.altitude,
        'speed': position.speed,
        'heading': position.heading,
        'timestamp': position.timestamp?.millisecondsSinceEpoch,
        'address': address,
      };
    }
    return {};
  }

  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  void dispose() {
    _positionStream = null;
  }
}
