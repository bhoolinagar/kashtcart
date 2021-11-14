import "dart:async";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:intl/intl.dart";
import 'package:kisan/farmer/book_vehicle.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:location/location.dart';

String mapKey = "AIzaSyBSSwP3xczNQ8-HxPU9--NTmvL2D13LsJc";

class D_sr extends StatefulWidget {
  String v_name;
  String v_review;
  String v_rate;
  D_sr({this.v_name, this.v_review, this.v_rate});
  @override
  _d_sr createState() =>
      _d_sr(v_name: v_name, v_rate: v_rate, v_review: v_review);
}

class _d_sr extends State<D_sr> {
  String v_name;
  String v_review;
  String v_rate;
  String d_name;
  String d_mobile;
  _d_sr({this.v_name, this.v_review, this.v_rate});

  BitmapDescriptor _pinLocationIcon;
  LocationData _currentPosition;
  String _address, _dateTime;
  GoogleMapController mapController;
  Marker marker;
  Map<MarkerId, Marker> _markers;
  Location location = Location();
  bool loading = false;
  GoogleMapController _controller;

  final MarkerId _markerId = MarkerId('1');
  LatLng _initialcameraposition = LatLng(23.593750, 77.0965629);

  CollectionReference v_Makar = FirebaseFirestore.instance.collection("v_name");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
    setCustmMap();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude, l.longitude),
              bearing: 192.33342,
              zoom: 65),
        ),
      );

      _markers = <MarkerId, Marker>{};
      Marker marker = Marker(
          markerId: _markerId,
          position: LatLng(l.latitude, l.longitude),
          icon: _pinLocationIcon,
          draggable: true,
          onDragEnd: ((newP) {
            location = LatLng(newP.latitude, newP.longitude) as Location;
            //  notifyListeners();
          }));
      _markers[_markerId] = marker;
      // notifyListeners
    });
  }

  setCustmMap() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/TC.png");
  }
//var filterdis;
  //bool maptoggle= false;
  // List clients=[];
  // inialMarker(client){
  // mapController.clearMarker.then((value) {
  // mapController.addMarker(
  //  MarkerOptions(

  //)
  // );
  // });
  // }
  // populateMarker(){
  // clients=[];
  //FirebaseFirestore.instance
  //  .collection("$v_name")
  //.get().then((value) {
  //if(value.docs.isNotEmpty){
  //setState(() {
  // maptoggle=true;
  //  });
  //  }
  // for(int i=0; i<value.docs.length;i++){
  // clients.add(value.docs[i].data());

  //}

  //});

  // }
  Future<bool> getDist() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Distance"),
            contentPadding: EdgeInsets.all(10),
            content: TextField(
              decoration: InputDecoration(
                hintText: "Enter distance",
              ),
              onChanged: (value) {
                setState(() {
                  // filterdis=value;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    //    FilterMarker(filterdis);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 200, width: 100,

        decoration: BoxDecoration(
          color: Colors.green.withOpacity(.2),
          // image: DecorationImage(
          //   image: AssetImage('assets/locaiton.png'), fit: BoxFit.cover),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            //  color: Colors.blueGrey.withOpacity(.8),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("$v_name")
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            // Vehicle ve_Ref = Vehicle.fromDocument(snapshot.data.);
                            List _mark = snapshot.data.docs.toList();
                            // List rev = snapshot.data.docs.toList();
                            var marks = Set<Marker>();
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              GeoPoint pos = snapshot.data.docs[i]['coords'];

                              marks.add(
                                new Marker(
                                    icon: _pinLocationIcon,
                                    draggable: false,
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookEquipment(
                                                    v_name: v_name,
                                                    v_rate: v_rate,
                                                    f_address: _address,
                                                    d_address: snapshot.data
                                                        .docs[i]['address'],
                                                    d_coords: snapshot
                                                        .data.docs[i]['coords'],
                                                    d_mobile: snapshot.data
                                                        .docs[i]['d_mobile'],
                                                    v_Driver: snapshot
                                                        .data.docs[i]['d_name'],
                                                    uid: snapshot.data.docs[i]
                                                        ['uid'],
                                                  )));
                                    },
                                    markerId: MarkerId(
                                        //  snapshot.data.docs[i]['v_uid']!= null?
                                        "${snapshot.data.docs[i]['v_uid']}"
                                        //   : "No data found"
                                        ),
                                    infoWindow: InfoWindow(
                                        title: //snapshot.data.docs[i]['d_name']!= null?
                                            "${snapshot.data.docs[i]['d_name']}",
                                        // "No data found",
                                        snippet: //snapshot.data().docs[i]['d_mobile'] = !null ?
                                            '${snapshot.data.docs[i]['address']}'
                                        //            : "No data found"

                                        ),
                                    position: //snapshot.data.docs[i]['coords'] ==null ? LatLng(28.56575, 35.65567) :
                                        new LatLng(
                                            snapshot.data.docs[i]['coords']
                                                .latitude,
                                            snapshot.data.docs[i]['coords']
                                                .longitude)),
                              );
                              // Marker marker = Marker(
                              //   icon: _pinLocationIcon,
                              // markerId: MarkerId('${_mark[i]['place']}'),
                              // draggable: false,
                              //  infoWindow: InfoWindow(
                              //  title: '${_mark[i]['user']}',
                              //snippet: '${_mark[i]['village']}',
                              // ),
                              //position: LatLng(pos.latitude, pos.longitude)

                              // _mark[i]['c,
                              //_mark[i]['coords']['longitude']
                              //);
                              // marks.add(marker);
                            }
                            return GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: _initialcameraposition, zoom: 15),
                              mapType: MapType.normal,
                              onMapCreated: _onMapCreated,
                              trafficEnabled: true,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              markers: marks,
                            );
                          }
                          if (snapshot.hasData && !snapshot.data.exists) {
                            return Center(
                                child: Text("No Driver Found",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.black38)));
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Something went wrong",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.black38)));
                          }
                          return Center(
                              child: CircularProgressIndicator(
                            semanticsLabel: "Loading",
                            strokeWidth: 2.5,
                            backgroundColor: Colors.greenAccent,
                          ));

                          //Text(" no Data");
                        }),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  //      if (_dateTime != null)
                  //      Padding(
                  //      padding: const EdgeInsets.only(top: 0, left: 50),
                  //    child: Text(
                  //    "Date/Time: $_dateTime",
                  //  style: TextStyle(
                  //  fontSize: 15,
                  //  color: Colors.black,
                  //),
                  // ),
                  //),
                  // SizedBox(
                  // height: 3,
                  // ),
                  //  if (_currentPosition != null)
                  //  Padding(
                  //  padding: const EdgeInsets.only(top: 60, left: 40),
                  //child: Text(
                  //"Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}",
                  //style: TextStyle(
                  //  fontSize: 17,
                  //color: Colors.black,
                  //      fontWeight: FontWeight.bold),
                  //    ),
                  //  ),
                  SizedBox(
                    height: 3,
                  ),
                  if (_address != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 25),
                      child: Text(
                        "Current Address: $_address",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  // SizedBox(
                  // height: 3,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 580),
                    child: Container(
                        //alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                            left: 5, top: 20, bottom: 10, right: 1),
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff3B9412)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  width: 120,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: Color(0xffcbe2c1),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        child: Image.asset("assets/TC.png")),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 10,
                                          child: Text(S.of(context).Vehicle,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Flexible(
                                            flex: 10,
                                            child: Text("${v_name}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ))),
                                      ],
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color(0xffcbe2c1),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    children: [
                                      Container(
                                          // alignment: Alignment.bottomCenter,
                                          padding: const EdgeInsets.only(
                                              left: 0, top: 3),
                                          width: 40,
                                          height: 40,
                                          child: Image.asset(
                                              "assets/rupees-symbol-png-27204.png")),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              S.of(context).rate,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("${v_rate}",
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color(0xffcbe2c1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text("${v_review}"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: 15,
                                                height: 15,
                                                child: Image.asset(
                                                    "assets/star.png")),
                                            Container(
                                                width: 15,
                                                height: 15,
                                                child: Image.asset(
                                                    "assets/star.png")),
                                            Container(
                                                width: 15,
                                                height: 15,
                                                child: Image.asset(
                                                    "assets/star.png")),
                                            Container(
                                                width: 15,
                                                height: 15,
                                                child: Image.asset(
                                                    "assets/star.png")),
                                            Container(
                                                width: 15,
                                                height: 15,
                                                child: Image.asset(
                                                    "assets/star.png")),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        S.of(context).Review,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            //  Container(
                            //    width: 150,
                            //  height: 40,
                            //  decoration: BoxDecoration(
                            //    borderRadius: BorderRadius.circular(40),
                            //   color: Color(0xffef8b37)),
                            //child: MaterialButton(
                            //color: Colors.redAccent,
                            //  onPressed: () {
                            //  Navigator.of(context).pushReplacement(
                            //    MaterialPageRoute(
                            //      builder: (context) =>
                            //        BookEquipment()));
                            //   },
                            // child: Text(
                            // "Book",
                            // style: TextStyle(
                            //   fontSize: 25, color: Color(0xffffffff)),
                            //),
                            //)),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Details() {
    return Container(
        //alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 1),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xa125800b)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 0, top: 0),
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xffcbe2c1),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(children: [
                    Container(
                        width: 45,
                        height: 45,
                        child: Image.asset("assets/TC.png")),
                    Row(
                      children: [
                        Text("Vehicle: ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text("Tractor"),
                      ],
                    )
                  ]),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 70,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xffcbe2c1),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    children: [
                      Container(
                          // alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(left: 0, top: 3),
                          width: 40,
                          height: 40,
                          child: Image.asset(
                              "assets/rupees-symbol-png-27204.png")),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              "Rate: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("500/hr"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 70,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xffcbe2c1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text("4.3/5"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                          ],
                        ),
                      ),
                      Text(
                        "Review",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xffef8b37)),
                child: MaterialButton(
                  //color: Colors.redAccent,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BookEquipment()));
                  },
                  child: Text(
                    "Book",
                    style: TextStyle(fontSize: 25, color: Color(0xffffffff)),
                  ),
                )),
          ],
        ));
  }

  getLoc() async {
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

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);
        print("The current location : $_initialcameraposition");
        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
}

//void FilterMarker(filterdis) {

//  for (int i=0;i <mark.lengh;i++){

//  }
//}
