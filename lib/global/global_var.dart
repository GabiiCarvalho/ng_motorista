import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
String userEmail = "";
String userPhotoURL = "";

String googleMapKey = "AIzaSyB6ZFbzlzFb80VXYXqfZFv-00X7LyJFx2A";
String serverKeyFCM = "SUA_CHAVE_DO_FCM_AQUI";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

// Variáveis do mapa
Position? currentUserPosition;
LatLng? currentUserLatLng;

// Variáveis de corrida
String tripID = "";
String driverName = "";
String driverPhone = "";
String driverPhoto = "";
String carDetails = "";
String tripStatus = "";
LatLng? driverCurrentLocation;
LatLng? userPickUpLocation;
LatLng? userDropOffLocation;

int requestTimeoutDriver = 20;
double tripFareAmount = 0.0;

// Variáveis específicas do motorista
String driverVehicleType = "";
String driverVehiclePlate = "";
String driverVehicleModel = "";
String driverVehicleColor = "";
double driverRating = 0.0;
int driverTotalDeliveries = 0;
int driverYears = 0;
int driverAcceptanceRate = 0;
int driverCompletionRate = 0;
double driverWalletBalance = 0.0;
bool driverDocumentsApproved = false;
bool driverIsOnline = false;

// Lista de motoristas online próximos
List<Map<String, dynamic>> nearbyOnlineDrivers = [];
