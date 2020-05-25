import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationModel {
  double latitude, longitude;
  LatLng userLocation;

  UserLocationModel(this.latitude, this.longitude, this.userLocation);
}
