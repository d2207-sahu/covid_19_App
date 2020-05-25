import 'dart:async';
import 'dart:collection';
import 'package:covid19/ViewModel/MapViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Set<Marker> markers = new HashSet<Marker>();
  GoogleMapController _mapController;
  Set<Polygon> polygons = new HashSet<Polygon>();
  Set<Polyline> polylines = new HashSet<Polyline>();
  Set<Circle> circles = new HashSet<Circle>();
  final Permission _permission = Permission.location;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

//   GoogleMapController _controller;
  BitmapDescriptor imagebitmap;

  void _markerIcon() async {
//    imagebitmap = Icons.accessibility;
//        await BitmapDescriptor.fromAssetImage(ImageConfiguration, assetName);
  }

//  void _setPolygons() {
//    List<LatLng> _polygons = new List<LatLng>();
//    _polygons.add(new LatLng(89, 90));
//
//    polygons.add(
//      Polygon(polygonId: PolygonId("sn"), points: _polygons, strokeWidth: 1),
//    );
//  }

  void _setCircles() {
    print("CirclesAddition");
    circles.add(
      Circle(
        circleId: CircleId(""),
        center: LatLng(37.42796133580664, -122.085749655962),
        strokeColor: Colors.red,
        strokeWidth: 2,
        radius: 200,
//        fillColor: Colors.blue[100],
      ),
    );
  }

//  void _setPolyLines() {
//    List<LatLng> _polylines = new List<LatLng>();
//    _polylines.add(new LatLng(89, 90));
//    polylines.add(Polyline(
//      polylineId: PolylineId(""),
//      color: Colors.black,
//      points: _polylines,
//      width: 20,
//    ));
//  }

  Future<PermissionStatus> _listenForPermissionStatus() async {
    print("ListeningPermissionStatus");
    final PermissionStatus status = await _permission.status;
    setState(() => _permissionStatus = status);
    return status;
  }

  void _reactOnPermissionStatus() {
    print("ReactionPermissionStatus");
    PermissionStatus status = _permissionStatus;
    if (status.isGranted) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "Location Permission Granted",
        ),
      ));
    } else if (status.isDenied) {
      Scaffold.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: 'Grant',
          onPressed: () {
            requestPermission(_permission);
          },
        ),
        content: Text("Location Permission Denied"),
      ));
    } else if (status.isPermanentlyDenied) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Location Permission PermanentlyDenied"),
      ));
    }
  }

  Future<void> requestPermission(Permission permission) async {
    print("requestPermission");
    final status = await permission.request();
    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  @override
  void initState() {
    print("initState");
    requestPermission(_permission);
    _reactOnPermissionStatus();
  }

  Future<void> _onMapCreated(GoogleMapController controller) {
    setState(() {
      _setCircles();
      addGoogleMapsStyle(controller);
//      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      markers.add(
        Marker(
          markerId: MarkerId("9"),
          position: LatLng(37.42796133580664, -122.085749655962),
          infoWindow: InfoWindow(
            title: "fuck",
          ),
//        icon:,
        ),
      );
      //if google api you will get marker id
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void addGoogleMapsStyle(GoogleMapController mapController) async {
    String _Style = await DefaultAssetBundle.of(context)
        .loadString('assets/mapsStyle.json');
    _mapController = mapController;
    mapController.setMapStyle(_Style);
  }

  void _moveCamerToMyLocation(LatLng userLatLng) {
    final _newPosition = CameraPosition(target: userLatLng, zoom: 16);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(_newPosition));
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        MapViewModel();
      },
      child: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 45,
                        splashColor: Colors.green,
                        color: Colors.black,
                        icon: _permissionStatus.isGranted
                            ? Icon(Icons.location_on)
                            : Icon(Icons.location_off),
                        onPressed: () {
                          _permissionStatus.isGranted
                              ? Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Already LocationPermission Granted'),
                                ))
                              : requestPermission(_permission);
                          setState(() {
                            _permissionStatus.isGranted
                                ? Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Already LocationPermission Granted'),
                                  ))
                                : _permissionStatus = PermissionStatus.granted;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FutureProvider(
                        child: IconButton(
                          icon: Icon(Icons.local_activity),
                          onPressed: () {
                            print("Pressed");
                            LatLng userlatlng = Provider.of<LatLng>(context);
                            _moveCamerToMyLocation(userlatlng);
                          },
                        ),
                        create: (context) =>
                            MapViewModel().CallForUserLocation(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
//                    trackCameraPsotion
                      circles: circles,
                      onMapCreated: _onMapCreated,
                      //can have voidORFuture<void> ,  but should have args as GoogleMapController controller
                      markers: markers,
                      initialCameraPosition: _kGooglePlex,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.local_activity),
                                      onPressed: () {
                                        print("Pressed");
                                      },
                                    ),
                                  ));
                            }),
                      ),
                    ),
                  ),
//          Align(
//            alignment: Alignment.topRight,
//            child: Padding(
//              padding: const EdgeInsets.all(30.0),
//              child: FloatingActionButton.extended(
//                onPressed: _goToTheLake,
//                label: Text('To the lake!'),
//                icon: Icon(Icons.directions_boat),
//              ),
//            ),
//          ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "COVID-19 Help",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
