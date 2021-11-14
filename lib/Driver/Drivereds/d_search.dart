import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kisan/Driver/Auth/assistants/assistantMethods.dart';
import 'package:kisan/Driver/Auth/location.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/farmer/book_vehicle.dart';
import 'package:kisan/owner/loading.dart';
import 'package:provider/provider.dart';

class Satelite_GoogleMapPage extends StatefulWidget {
  @override
  s_googleMapPage createState() => s_googleMapPage();
}

class s_googleMapPage extends State<Satelite_GoogleMapPage> {
  GoogleMapController newGoogleMapController;
  String searchAddr;
  bool loading = false;
  User_d user;
  String v_uid;
  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map _docdata = doc.data();
    user = User_d.fromDocument(doc, _docdata);

    v_uid = user.uid;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  Future<void> locaitonPotion() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Position currentPosition = position;

    LatLng LatPosiotn = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: LatPosiotn, zoom: 12);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String Address = await AssistantsMethod.searchCoordinatesAddres(position);

    FirebaseFirestore.instance.collection('users').doc(v_uid).update({
      "coords": new GeoPoint(position.latitude, position.longitude),
      "place": Address,
    });
    print("This is your address" + Address);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: googleMapUi()

//
        );
  }

  searchandNavigate() {
    locationFromAddress(searchAddr).then((result) {
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(result[0].latitude, result[0].longitude),
              zoom: 10.0)));
    });
  }

  Widget googleMapUi() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationPostion != null) {
        return Stack(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: model.locationPostion,
                  //LatLng(28.56575, 35.65567),
                  zoom: 20,
                ),
                mapToolbarEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: Set<Marker>.of(model.markers.values),
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    newGoogleMapController = controller;
                  });
                },
              ),
            ),
            Positioned(
              top: 40,
              right: 5,
              left: 5.0,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffcbe2c1)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Address here",
                    hintStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 10,
                      top: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: searchandNavigate(),
                      iconSize: 30,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchAddr = val;
                    });
                  },
                ),
              ),
            ),
            // Positioned(
            // top: 160,
            // left: 300,
            //   child: Container(
            // alignment: Alignment.topLeft,
            // width: 55,
            // height: 40,
            // decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            //   color: Color(0xffef8b37)),
            // child: MaterialButton(
            //  onPressed: () {
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => GoogleMapPage()));
            // },
            //   child: Padding(
            //padding: const EdgeInsets.only(right: 50),
            //child: Icon(
            //    Icons.map,
            //size: 30,
            //color: Color(0xffcbe2c1),
            //),
            //),
            //))),
            //    Positioned(child: Book_veh())
          ],
        );
      }
      return Center(
        child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 150,
            child: Center(
                child: Row(
              children: [
                Flexible(child: Text("Please wait ")),
                Flexible(child: Loading())
              ],
            ))),
      );
    });
  }

  Widget Book_veh() {
    return Stack(
      children: [
        Positioned(
          top: 550,
          right: 5,
          left: 5.0,
          child: Container(
              //alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 1),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xa125800b)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 0, top: 10),
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xffcbe2c1),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(children: [
                          Container(
                              width: 40,
                              height: 40,
                              child: Image.asset("assets/TC.png")),
                          Text("Tractor")
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => BookEquipment()));
                        },
                        child: Text(
                          "Book",
                          style:
                              TextStyle(fontSize: 25, color: Color(0xffffffff)),
                        ),
                      )),
                ],
              )),
        ),
      ],
    );
  }
}
