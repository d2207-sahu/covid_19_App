import 'package:covid19/Model/UserLocationModel.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  Location _location = new Location();
  Firestore _fireStore = Firestore.instance;
  Geoflutterfire _geoPoint = Geoflutterfire();

  Future<bool> addIssuesToDatabase(Map<String, dynamic> data) async {
//    TODO before this add data to the geoFlutterFire
    await _fireStore.collection("Issues").document().setData(data).then((val) {
      print("Data Setting");
    }).catchError((error) {
      print("Error:$error");
    }).whenComplete(() {
      print("Completed");
    });
    return true;
  }

  Future<UserLocationModel> getUserLocation() async {
    print("getUserLocation");
    bool _hasPermission;
    PermissionStatus _permissionStatus = await _location.hasPermission();
    _permissionStatus == PermissionStatus.granted
        ? _hasPermission = true
        : _hasPermission = true;
    print("Permission $_hasPermission");
    _hasPermission
        ? await _location.getLocation().then((value) {
            final _latlng = LatLng(value.latitude, value.longitude);
            return UserLocationModel(value.latitude, value.longitude, _latlng);
          })
        : print("NoPermission");
    return null;
  }
}
