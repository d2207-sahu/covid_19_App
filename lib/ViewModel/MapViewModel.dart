import 'package:covid19/Model/UserLocationModel.dart';
import 'package:covid19/Services/MapService.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  final _mapService = MapService();
  LatLng _userLatLng;

  Future<LatLng> CallForUserLocation() async {
    UserLocationModel _userLocation = await _mapService.getUserLocation();
    _userLatLng = _userLocation.userLocation;
    return _userLocation.userLocation;
    notifyListeners();
  }

//  LatLng getUserLatLng() {
//    return _userLatLng;
//  }
}
