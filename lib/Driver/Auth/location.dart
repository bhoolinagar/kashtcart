import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  BitmapDescriptor _pinLocationIcon;
  BitmapDescriptor get pinLocatioIcon => _pinLocationIcon;
  Map<MarkerId, Marker> _markers;
  Map<MarkerId, Marker> get markers => _markers;
  Map<CircleId, Circle> _cirlces;
  Map<CircleId, Circle> get circles => circles;

  String vehicle_name;

  final CircleId circlerId = CircleId('1');
  final MarkerId markerId = MarkerId('1');

  Location _location;
  Location get location => _location;
  LatLng _locationPostion;

  LatLng get locationPostion => _locationPostion;
  bool locationSrviceActive = true;
  LocationProvider() {
    _location = new Location();
    this.vehicle_name;
  }
  initalization() async {
    await getUserLocation();
    await setCustomMapPin();
    await getUser();
  }

  final ref = FirebaseFirestore.instance.collection("users");

  final v_uid = (FirebaseAuth.instance.currentUser).uid;
  String currentPosition;
  User_d user;
  String u_uid;
  Future<DocumentSnapshot> getUser() async {
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map _docdata = doc.data();
    user = User_d.fromDocument(doc, _docdata);

    u_uid = user.uid;
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }

  getUserLocation() async {
    // currentPosition = position ;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.onLocationChanged.listen((LocationData c_location) async {
      _locationPostion = LatLng(c_location.latitude, c_location.longitude);
      _getAddress(c_location.latitude, c_location.longitude).then((value) {
        currentPosition = "${value.first.addressLine}";
      });

      print(_locationPostion);

        //FirebaseFirestore.instance.collection('Markers').doc(v_uid).set({
       // "coords": new GeoPoint(c_location.latitude, c_location.longitude),
       // "address": currentPosition,
     // });

     // FirebaseFirestore.instance
       //   .collection("${vehicle_name}")
         // .doc(u_uid)
         // .collection('vehicle')
         // .doc(v_uid)
         // .update({
      //  "uid": u_uid,
       // "v_uid": v_uid,
        // "village": village.text,
        // "pincode": pincode.text,
        // "company": company,
        //    "registration": Authory.text,
        //  "engine_size": Engine.text,
        // "fuel_type": Fuel_type,
        // "rc": Rc.text,
       // "vehicle_name": vehicle_name,
       // "coords": new GeoPoint(c_location.latitude, c_location.longitude),
       // "address": currentPosition,
        ///    "r_date": _date,
        //  'rate': Rate.text
      //});
      FirebaseFirestore.instance.collection('users').doc(v_uid).update({
        "coords": new GeoPoint(c_location.latitude, c_location.longitude),
        "address": currentPosition,
      });
      // print('this is your addess' +Addess);
      _markers = <MarkerId, Marker>{};
      _cirlces = <CircleId, Circle>{};

      Circle circles = Circle(
        circleId: circlerId,
        center: LatLng(c_location.latitude, c_location.longitude),
        radius: 3000,
      );

      Marker marker = Marker(
          markerId: markerId,
          position: LatLng(c_location.latitude, c_location.longitude),
          icon: pinLocatioIcon,
          draggable: true,
          onDragEnd: ((newPosition) {
            _locationPostion =
                LatLng(newPosition.latitude, newPosition.longitude);
            notifyListeners();
          }));
      _markers[markerId] = marker;

      notifyListeners();
    });
  }

  setCustomMapPin() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          devicePixelRatio: 2.5,
        ),
        'assets/locaiton.png');
  }
}
