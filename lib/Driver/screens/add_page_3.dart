import "dart:async";
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/screens/add_page_2.dart';
import 'package:kisan/Driver/screens/d_home.dart';
import 'package:kisan/generated/l10n.dart';

class add_page_3 extends StatefulWidget {
  String ve_id;
  add_page_3({Key key, @required this.ve_id}) : super(key: key);

  @override
  _add_page_3 createState() => _add_page_3(ve_id: ve_id);
}

class _add_page_3 extends State<add_page_3> {
  _add_page_3({Key key, @required this.ve_id});
  bool get wantKeepAlive => true;
  File imageFile_f;
  File imageFile_b;
  File imageFile_l;
  File imageFile_r;
  String v_avtar_f;
  String v_avatar_b;
  String v_avtar_r;
  String v_avatar_l;
  String ve_id;
  //String photo;
  //Completer<GoogleMapController> _controllergooglemap = Completer();

  //GoogleMapController new_googlecontroller;
  // static final CameraPosition _kgooglePlex =
  // CameraPosition(target: LatLng(37.454352477, -134.4534212), zoom: 14.4565);

  pickImage_1(ImageSource imageSource) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      imageFile_f = File(pickedFile.path);
      //imageFile_b = File(pickedFile.path);
    });
  }

  pickImage_2(ImageSource imageSource) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      imageFile_b = File(pickedFile.path);
      //imageFile_b = File(pickedFile.path);
    });
  }

  pickImage_3(ImageSource imageSource) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      imageFile_l = File(pickedFile.path);
      //imageFile_b = File(pickedFile.path);
    });
  }

  pickImage_4(ImageSource imageSource) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      imageFile_r = File(pickedFile.path);
      //imageFile_b = File(pickedFile.path);
    });
  }

  Vehicle vehicle;
  String vehicle_name;
  User_d user;
  bool loading = true;

  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });

    final uid = (await FirebaseAuth.instance.currentUser).uid;
    // DocumentSnapshot doc =
    //   await FirebaseFirestore.instance.collection("users").doc(uid).get();
    // Map _docdata = doc1.data();
    // user = User_d.fromDocument(doc, _docdata);
    //vehicle_name = user.vehicle;
    DocumentSnapshot doc1 = await FirebaseFirestore.instance
        .collection("Driver")
        .doc(uid)
        .collection('driver')
        .doc(ve_id)
        .get();
    Map _docdata = doc1.data();
    vehicle = Vehicle.fromDocument(doc1, _docdata);
    ve_id = vehicle.v_uid;
    vehicle_name = vehicle.v_name;
    v_avatar_b = vehicle.avatar_b;
    v_avtar_f = vehicle.avatarUrl_f;
    v_avatar_l = vehicle.avatar_l;
    v_avtar_r = vehicle.AvatarUrl_r;

    //v_avatar_b = vehicle.avatar_b;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  final _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController =
      TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  String productId_b = DateTime.now().millisecondsSinceEpoch.toString();
  String ProductId_r = DateTime.now().microsecond.toString();
  String productId_l = DateTime.now().day.toString();

  bool uploading = false;
  File Image_f;

  _getFromGallery() async {
    PickedFile pick = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        Image_f = File(pick.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile_f != null) {
      return displayAdminUploadFormScreen_f(imageFile_f);
    } else if (imageFile_b != null) {
      return displayAdminUploadFormScreen_b(imageFile_b);
    } else if (imageFile_l != null) {
      return displayAdminUploadFormScreen_l(imageFile_l);
    } else if (imageFile_r != null) {
      return displayAdminUploadFormScreen_r(imageFile_r);
    }
    // if (imageFile_b == null) {return displayAdminUploadFormScreen(imageFile_b);}

    //imageFile_r == null
    return displayAdminHomeScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: const Color(0xff0d9408)),
        ),
        title: Text(
          S.of(context).add_farm_equipment,
          style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontFamily: 'Signatra',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (c) => d_home(
                      currentId: null,
                    ));
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
          height: 900,
          width: 400,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //  colors: [
              //  Colors.teal,
              //  Colors.lightBlue,
              //],
              //begin: const FractionalOffset(0.0, 0.0),
              //end: const FractionalOffset(1.0, 0.0),
              //stops: [0.0, 1.0],
              //tileMode: TileMode.clamp,
              ),
          //  ),
          child: ListView(//mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(158.5, -9.5),
                    child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/locaiton.png'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Transform.translate(
                    offset: Offset(4.0, 45.0),
                    child: Container(
                      width: 900.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff0d9408),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(4.0, 40.0),
                    child: Container(
                      width: 180.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(32.0, 70.0),
                    child: Text(
                      S.of(context).Register,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xff2a2e43),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(142.0, 70.0),
                    child: Text(
                      S.of(context).Add_photo,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xff2a2e43),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(250.0, 70.0),
                    child: Text(
                      S.of(context).add_bank_details,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(44.0, 30.0),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff0d9408),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(164.0, 30.0),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff0d9408),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(290.0, 30.0),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff0d9408),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(52.5, 33.5),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 19,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.6023000144958496,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(173.5, 32.5),
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.634000015258789,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(297.5, 32.5),
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.634000015258789,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Container(
                    width: 180.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //   color: Colors.green.withOpacity(.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.6),
                            blurRadius: 1,
                            offset: Offset(-1, 8),
                          )
                        ]
                        //  border:
                        //    Border.all(width: 2.0, color: const Color(0xffe78100)),
                        ),
                    child: v_avtar_f == null
                        ? Container(
                            width: 155.0,
                            height: 155.0,
                            child: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 1,
                                  offset: Offset(-1, 8),
                                )
                              ],
                              color: Colors.orangeAccent.withOpacity(.7),
                              // border:
                              //   Border.all(width: 2.0, color: Colors.green),
                              image: DecorationImage(
                                  image: AssetImage("assets/TC.png"),
                                  fit: BoxFit.cover),

                              //CircleAvatar(
                              // backgroundColor: Colors.green,
                              //  radius: 82.0,
                              //  backgroundImage: NetworkImage(
                              //    photo,
                              //   ),
                            ))
                        : Container(
                            width: 145.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffffffff),

                                //border:
                                //   Border.all(width: 2.0, color: Colors.green),
                                image: DecorationImage(
                                    image: NetworkImage(v_avtar_f),
                                    fit: BoxFit.cover)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 100, top: 140),
                              child: null,
                            )
                            //CircleAvatar(
                            // backgroundColor: Colors.green,
                            //  radius: 82.0,
                            //  backgroundImage: NetworkImage(
                            //    photo,
                            //   ),
                            ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Container(
                    width: 180.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //  color: Colors.green.withOpacity(.6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            blurRadius: 1,
                            offset: Offset(-1, 8),
                          )
                        ]
                        //  border:
                        //    Border.all(width: 2.0, color: const Color(0xffe78100)),
                        ),
                    child: v_avatar_b == null
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3),
                            child: Container(
                              width: 155.0,
                              height: 155.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 100, top: 140),
                                child: MaterialButton(
                                  onPressed: () => takeImage_2(context),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: const Color(0xff0d9408),
                                    child: Container(
                                        width: 180.0,
                                        height: 180.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: const AssetImage(
                                                'assets/edit.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    blurRadius: 1,
                                    offset: Offset(-1, 8),
                                  )
                                ],
                                color: Colors.cyanAccent.withOpacity(.5),
                                // border:
                                //    Border.all(width: 2.0, color: Colors.green),

                                image: DecorationImage(
                                    //  alignment: AlignmentGeometryTween(end: 20),
                                    image: AssetImage(
                                      "assets/TC.png",
                                    ),
                                    fit: BoxFit.cover),

                                //CircleAvatar(
                                // backgroundColor: Colors.green,
                                //  radius: 82.0,
                                //  backgroundImage: NetworkImage(
                                //    photo,
                                //   ),
                              ),
                            ),
                          )
                        : Container(
                            width: 145.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                //  color: const Color(0xffffffff),
                                //border:
                                //  Border.all(width: 2.0, color: Colors.green),
                                image: DecorationImage(
                                    image: NetworkImage(v_avatar_b),
                                    fit: BoxFit.cover)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 100, top: 140),
                              child: MaterialButton(
                                onPressed: () => takeImage_2(context),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.green,
                                  child: Container(
                                      width: 180.0,
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: const AssetImage(
                                              'assets/edit.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            //CircleAvatar(
                            // backgroundColor: Colors.green,
                            //  radius: 82.0,
                            //  backgroundImage: NetworkImage(
                            //    photo,
                            //   ),
                          ),
                  ),
                ),
              ),
            ]),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 26, bottom: 10),
                  child: MaterialButton(
                    onPressed: () => takeImage_1(context),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xff0d9408),
                      child: Container(
                          width: 400.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/edit.png'),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 226, bottom: 10),
                  child: MaterialButton(
                    onPressed: () {
                      takeImage_2(context);
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xff0d9408),
                      child: Container(
                        width: 400.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/edit.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    width: 10,
                    child: MaterialButton(
                        // color: Colors.green,
                        onPressed: () => takeImage_1(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            9.0,
                          ),
                        ),
                        child: Text(
                            S.of(context).Upload_front_side_of_vehicle_image)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      takeImage_2(context);
                      // displayAdminUploadFormScreen(imageFile_b);
                    },
                    child: Text(S.of(context).Upload_back_side_vehicle_Image),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Container(
                    width: 180.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //   color: Colors.green.withOpacity(.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.6),
                            blurRadius: 1,
                            offset: Offset(-1, 8),
                          )
                        ]
                        //  border:
                        //    Border.all(width: 2.0, color: const Color(0xffe78100)),
                        ),
                    child: v_avatar_l == null
                        ? Container(
                            width: 155.0,
                            height: 155.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 1,
                                  offset: Offset(-1, 8),
                                )
                              ],
                              color: Colors.brown.withOpacity(.4),
                              // border:
                              //   Border.all(width: 2.0, color: Colors.green),
                              image: DecorationImage(
                                  image: AssetImage("assets/TC.png"),
                                  fit: BoxFit.cover),

                              //CircleAvatar(
                              // backgroundColor: Colors.green,
                              //  radius: 82.0,
                              //  backgroundImage: NetworkImage(
                              //    photo,
                              //   ),
                            ))
                        : Container(
                            width: 145.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.cyanAccent.withOpacity(.5),

                                //border:
                                //   Border.all(width: 2.0, color: Colors.green),
                                image: DecorationImage(
                                    image: NetworkImage(v_avatar_l),
                                    fit: BoxFit.cover)),
                            child: null
                            //CircleAvatar(
                            // backgroundColor: Colors.green,
                            //  radius: 82.0,
                            //  backgroundImage: NetworkImage(
                            //    photo,
                            //   ),
                            ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Container(
                    width: 180.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //  color: Colors.green.withOpacity(.6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            blurRadius: 1,
                            offset: Offset(-1, 8),
                          )
                        ]
                        //  border:
                        //    Border.all(width: 2.0, color: const Color(0xffe78100)),
                        ),
                    child: v_avtar_r == null
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3),
                            child: Container(
                                width: 185.0,
                                height: 135.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1),
                                      blurRadius: 1,
                                      offset: Offset(-1, 8),
                                    )
                                  ],
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(.5),
                                  // border:
                                  //    Border.all(width: 2.0, color: Colors.green),
                                  image: DecorationImage(

                                      //  alignment: AlignmentGeometryTween(end: 20),
                                      image: AssetImage(
                                        "assets/TC.png",
                                      ),
                                      fit: BoxFit.cover),

                                  //CircleAvatar(
                                  // backgroundColor: Colors.green,
                                  //  radius: 82.0,
                                  //  backgroundImage: NetworkImage(
                                  //    photo,
                                  //   ),
                                )),
                          )
                        : Container(
                            width: 145.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    blurRadius: 1,
                                    offset: Offset(-1, 8),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.orangeAccent,
                                //  border:
                                //   Border.all(width: 2.0, color: Colors.green),
                                image: DecorationImage(
                                    image: NetworkImage(v_avtar_r),
                                    fit: BoxFit.cover)),
                            child: null
                            //CircleAvatar(
                            // backgroundColor: Colors.green,
                            //  radius: 82.0,
                            //  backgroundImage: NetworkImage(
                            //    photo,
                            //   ),
                            ),
                  ),
                ),
              ),
            ]),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 26, bottom: 10),
                  child: MaterialButton(
                    onPressed: () => takeImage_3(context),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xff0d9408),
                      child: Container(
                          width: 400.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/edit.png'),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 226, bottom: 10),
                  child: MaterialButton(
                    onPressed: () => takeImage_4(context),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xff0d9408),
                      child: Container(
                          width: 400.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/edit.png'),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    width: 10,
                    child: MaterialButton(
                        // color: Colors.green,
                        onPressed: () => takeImage_3(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            9.0,
                          ),
                        ),
                        child: Text(
                            S.of(context).Upload_left_side_of_vehicle_image)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      takeImage_4(context);
                      //   displayAdminUploadFormScreen(imageFile_b);
                    },
                    child:
                        Text(S.of(context).Upload_Right_side_of_vehicle_Image),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 12, right: 30, bottom: 20),
                          child: Container(
                            width: 85,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular((20)),
                              child: Container(
                                width: 50,
                                height: 45,
                                child: RaisedButton(
                                  color: Colors.orange.withBlue(50),
                                  onPressed: () => OnSavedIamge(v_avtar_f,
                                      v_avatar_l, v_avatar_b, v_avtar_r),
                                  child: Text(
                                    S.of(context).Save,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        // padding: const EdgeInsets.only(left:60,top:12,right: 50,bottom: 20),
                        // child: Container(
                        //  width: 85,
                        //  height: 35,

                        //   child: ClipRRect(
                        //    borderRadius: BorderRadius.circular((20)),
                        //  child: Container(
                        //   width: 50,
                        //  height: 45,
                        //  child: RaisedButton(

                        //  color: Colors.green.withBlue(50),

                        //   onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(
                        // builder: (context)=> add_page_3())),
                        // child: Text("Next",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //    fontSize: 20,
                        //   fontWeight: FontWeight.bold
                        //   ),),

                        //  ),
                        //  ),
                        //  ),
                        //   ),
                        //   ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, top: 12, right: 20, bottom: 20),
                    child: Container(
                      width: 85,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular((20)),
                        child: Container(
                          width: 50,
                          height: 45,
                          child: RaisedButton(
                            color: const Color(0xff0d9408),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => add_page_2())),
                            child: Text(
                              S.of(context).Next,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  takeImage_3(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Select_Image,
            style: TextStyle(
              color: Color(0xff138909),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                S.of(context).Take_Picture,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_3(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Select_Gallery,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_3(ImageSource.gallery);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Cancel,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  takeImage_2(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Select_Image,
            style: TextStyle(
              color: Color(0xff138909),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                S.of(context).Take_Picture,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_2(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Select_Gallery,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_2(ImageSource.gallery);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Cancel,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  takeImage_4(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Select_Image,
            style: TextStyle(
              color: Color(0xff138909),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                S.of(context).Take_Picture,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                pickImage_4(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Select_Gallery,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_4(ImageSource.gallery);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Cancel,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  takeImage_1(mfContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Select_Image,
            style: TextStyle(
              color: Color(0xff138909),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                S.of(context).Take_Picture,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_1(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Select_Gallery,
                style: TextStyle(
                  color: Color(0xff138909),
                ),
              ),
              onPressed: () {
                pickImage_1(ImageSource.gallery);
              },
            ),
            SimpleDialogOption(
              child: Text(
                S.of(context).Cancel,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  displayAdminUploadFormScreen_f(
    File Image_file_f,
  ) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green
              // gradient: LinearGradient(
              // colors: [
              // Colors.teal,
              //Colors.lightBlue,
              // ],
              //  begin: const FractionalOffset(0.0, 0.0),
              // end: const FractionalOffset(1.0, 0.0),
              //stops: [0.0, 1.0],
              // tileMode: TileMode.clamp,
              // ),
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // clearFormInfo();
          },
        ),
        title: Text(
          'Upload Image ',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
            onPressed: uploading
                ? null
                : () {
                    uploadImageAndSaveItemInfo_f(Image_file_f);
                  },
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            //  uploading ? Loading() : Text(' lselect'),
            SizedBox(
              width: 20,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        height: 180.0,
                        decoration: BoxDecoration(
                            // boxShadow: [
                            // BoxShadow(
                            // color: Colors.grey.withOpacity(1),
                            // blurRadius: 1,
                            //  offset: Offset(-1, 8),
                            // )
                            // ],
                            //  color: Colors.deepPurpleAccent.withOpacity(.5),
                            ),
                        width: 0,
                        // width: MediaQuery.of(context).size.width * 0.9,

                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 1,
                                  offset: Offset(-1, 8),
                                )
                              ],
                              color: Colors.deepPurpleAccent.withOpacity(.5),
                              image: DecorationImage(
                                image: FileImage(Image_file_f),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: MaterialButton(
                    onPressed: () {
                      // uploadItemImage()
                      uploadImageAndSaveItemInfo_f(Image_file_f);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        // BoxShadow(
                        // color: Colors.grey.withOpacity(1),
                        // blurRadius: 1,
                        // offset: Offset(-1, 8),
                        // )
                        // ],
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28, top: 10),
                        child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //    color: Colors.grey.withOpacity(1),
                        //    blurRadius: 1,
                        //    offset: Offset(-1, 8),
                        //   )
                        // ],
                        borderRadius: BorderRadius.circular(98),
                        color: Color(0xff3B9412)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text("Cancel",
                          style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  displayAdminUploadFormScreen_b(
    File Image_file_f,
  ) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green
              // gradient: LinearGradient(
              // colors: [
              // Colors.teal,
              //Colors.lightBlue,
              // ],
              //  begin: const FractionalOffset(0.0, 0.0),
              // end: const FractionalOffset(1.0, 0.0),
              //stops: [0.0, 1.0],
              // tileMode: TileMode.clamp,
              // ),
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // clearFormInfo();
          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              uploadImageAndSaveItemInfo_b(Image_file_f);
            },
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
        title: Text(
          'Upload back of Image ',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            //  uploading ? Loading() : Text(' lselect'),
            SizedBox(
              width: 20,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        height: 180.0,
                        decoration: BoxDecoration(
                            // boxShadow: [
                            // BoxShadow(
                            // color: Colors.grey.withOpacity(1),
                            // blurRadius: 1,
                            //  offset: Offset(-1, 8),
                            // )
                            // ],
                            //  color: Colors.deepPurpleAccent.withOpacity(.5),
                            ),
                        width: 0,
                        // width: MediaQuery.of(context).size.width * 0.9,

                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 1,
                                  offset: Offset(-1, 8),
                                )
                              ],
                              color: Colors.deepPurpleAccent.withOpacity(.5),
                              image: DecorationImage(
                                image: FileImage(Image_file_f),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: MaterialButton(
                    onPressed: () {
                      //  saveItemInfo_b(Image_file_f);
                      uploadImageAndSaveItemInfo_b(Image_file_f);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        // BoxShadow(
                        // color: Colors.grey.withOpacity(1),
                        // blurRadius: 1,
                        // offset: Offset(-1, 8),
                        // )
                        // ],
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28, top: 10),
                        child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //    color: Colors.grey.withOpacity(1),
                        //    blurRadius: 1,
                        //    offset: Offset(-1, 8),
                        //   )
                        // ],
                        borderRadius: BorderRadius.circular(98),
                        color: Color(0xff3B9412)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text("Cancel",
                          style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  displayAdminUploadFormScreen_l(
    File Image_file_f,
  ) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green
              // gradient: LinearGradient(
              // colors: [
              // Colors.teal,
              //Colors.lightBlue,
              // ],
              //  begin: const FractionalOffset(0.0, 0.0),
              // end: const FractionalOffset(1.0, 0.0),
              //stops: [0.0, 1.0],
              // tileMode: TileMode.clamp,
              // ),
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // clearFormInfo();
          },
        ),
        title: Text(
          S.of(context).Upload_Image,
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
            onPressed: uploading
                ? null
                : () {
                    uploadImageAndSaveItemInfo_l(Image_file_f);
                  },
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            //  uploading ? Loading() : Text(' lselect'),
            SizedBox(
              width: 20,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        height: 180.0,
                        decoration: BoxDecoration(
                            // boxShadow: [
                            // BoxShadow(
                            // color: Colors.grey.withOpacity(1),
                            // blurRadius: 1,
                            //  offset: Offset(-1, 8),
                            // )
                            // ],
                            //  color: Colors.deepPurpleAccent.withOpacity(.5),
                            ),
                        width: 0,
                        // width: MediaQuery.of(context).size.width * 0.9,

                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 1,
                                  offset: Offset(-1, 8),
                                )
                              ],
                              color: Colors.deepPurpleAccent.withOpacity(.5),
                              image: DecorationImage(
                                image: FileImage(Image_file_f),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: MaterialButton(
                    onPressed: () => uploading
                        ? null
                        : () {
                            //saveItemInfo_l(Image_file_f);
                            uploadImageAndSaveItemInfo_l(Image_file_f);
                          },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        // BoxShadow(
                        // color: Colors.grey.withOpacity(1),
                        // blurRadius: 1,
                        // offset: Offset(-1, 8),
                        // )
                        // ],
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28, top: 10),
                        child: Text(
                         S.of(context).Upload,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //    color: Colors.grey.withOpacity(1),
                        //    blurRadius: 1,
                        //    offset: Offset(-1, 8),
                        //   )
                        // ],
                        borderRadius: BorderRadius.circular(98),
                        color: Color(0xff3B9412)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text(S.of(context).Cancel,
                          style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  displayAdminUploadFormScreen_r(
    File Image_file_r,
  ) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green
              // gradient: LinearGradient(
              // colors: [
              // Colors.teal,
              //Colors.lightBlue,
              // ],
              //  begin: const FractionalOffset(0.0, 0.0),
              // end: const FractionalOffset(1.0, 0.0),
              //stops: [0.0, 1.0],
              // tileMode: TileMode.clamp,
              // ),
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => add_page_3(
                      ve_id: ve_id,
                    )));
            // clearFormInfo();
          },
        ),
        title: Text(
          S.of(context).Upload_Image,
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
            onPressed: uploading
                ? null
                : () {
                    uploadImageAndSaveItemInfo_r(Image_file_r);
                  },
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            //  uploading ? Loading() : Text(' lselect'),
            SizedBox(
              width: 20,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        height: 180.0,
                        decoration: BoxDecoration(
                            // boxShadow: [
                            // BoxShadow(
                            // color: Colors.grey.withOpacity(1),
                            // blurRadius: 1,
                            //  offset: Offset(-1, 8),
                            // )
                            // ],
                            //  color: Colors.deepPurpleAccent.withOpacity(.5),
                            ),
                        width: 0,
                        // width: MediaQuery.of(context).size.width * 0.9,

                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 1,
                                  offset: Offset(-1, 8),
                                )
                              ],
                              color: Color(0xff3B9412),
                              image: DecorationImage(
                                image: FileImage(Image_file_r),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: MaterialButton(
                    onPressed: () {
                      //saveItemInfo_r(Image_file_r);

                      uploadImageAndSaveItemInfo_r(Image_file_r);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        // BoxShadow(
                        // color: Colors.grey.withOpacity(1),
                        // blurRadius: 1,
                        // offset: Offset(-1, 8),
                        // )
                        // ],
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28, top: 10),
                        child: Text(
                          S.of(context).Upload,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //    color: Colors.grey.withOpacity(1),
                        //    blurRadius: 1,
                        //    offset: Offset(-1, 8),
                        //   )
                        // ],
                        borderRadius: BorderRadius.circular(98),
                        color: Colors.greenAccent),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text(S.of(context).Cancel,
                          style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  uploadImageAndSaveItemInfo_f(File ImageFe) async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl_f = await uploadItemImage(ImageFe);
    //String imageDownloadUrl_b = await uploadItemImage(imageFile_b);
    //String imageDownloadUrl_l = await uploadItemImage(imageFile_l);
    // String imageDownloadUrl_r = await uploadItemImage(imageFile_r);

    saveItemInfo_f(imageDownloadUrl_f);
  }

  uploadImageAndSaveItemInfo_b(File ImageFe) async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl_f = await uploadItemImage_b(ImageFe);
    //String imageDownloadUrl_b = await uploadItemImage(imageFile_b);
    //String imageDownloadUrl_l = await uploadItemImage(imageFile_l);
    // String imageDownloadUrl_r = await uploadItemImage(imageFile_r);

    saveItemInfo_b(imageDownloadUrl_f);
  }

  uploadImageAndSaveItemInfo_l(File ImageFe) async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl_f = await uploadItemImage(ImageFe);
    //String imageDownloadUrl_b = await uploadItemImage(imageFile_b);
    //String imageDownloadUrl_l = await uploadItemImage(imageFile_l);
    // String imageDownloadUrl_r = await uploadItemImage(imageFile_r);

    saveItemInfo_l(imageDownloadUrl_f);
  }

  uploadImageAndSaveItemInfo_r(File ImageFe) async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl_f = await uploadItemImage_r(ImageFe);
    //String imageDownloadUrl_b = await uploadItemImage(imageFile_b);
    //String imageDownloadUrl_l = await uploadItemImage(imageFile_l);
    // String imageDownloadUrl_r = await uploadItemImage(imageFile_r);

    saveItemInfo_r(imageDownloadUrl_f);
  }

  Future<String> uploadItemImage(mfileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Items');

    final uid = (await FirebaseAuth.instance.currentUser).uid;
    productId = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask =
        storageReference.child('product_$productId.jpg').putFile(mfileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadItemImage_b(mfileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Items');

    final uid = (await FirebaseAuth.instance.currentUser).uid;
    productId_b = DateTime.now().microsecond.toString();
    UploadTask uploadTask =
        storageReference.child('product_$productId_b.jpg').putFile(mfileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadItemImage_l(mfileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Items');

    // final uid = (await FirebaseAuth.instance.currentUser()).uid;
    productId_l = DateTime.now().day.toString();
    UploadTask uploadTask =
        storageReference.child('product_$productId_l.jpg').putFile(mfileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadItemImage_r(mfileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Items');

    // final uid = (await FirebaseAuth.instance.currentUser()).uid;
    productId_b = DateTime.now().microsecond.toString();
    UploadTask uploadTask =
        storageReference.child('product_$productId_b.jpg').putFile(mfileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo_f(String ImageFe) async {
    // String imageDownloadUrl_f = await uploadItemImage(ImageFe);
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    final itemsRef = FirebaseFirestore.instance
        .collection('Driver')
        .doc(uid)
        .collection('driver');

    //DocumentSnapshot doc = await FirebaseFirestore.instance
    //  .collection("Driver")
    //.doc(uid)
    //.collection("driver")
    // .doc(ve_id)
    //.get();
    //Map _docdata = doc.data();
    //user = User_d.fromDocument(doc, _docdata);
    //vehicle_name = user.vehicle;
    //final v_uid=  ;
    itemsRef.doc(ve_id).update({
      // 'shortInfo': _shortInfoTextEditingController.text.trim(),
      // 'longDescription': _descriptionTextEditingController.text.trim(),
      //  'price': int.parse(_priceTextEditingController.text),
      //  'publishedDate': DateTime.now(),
      'status': 'available',
      "v_avatar_f": ImageFe,

      // 'title': _titleTextEditingController.text.trim(),
    });
    print(" Name of is:  $ImageFe");
    setState(() {
      imageFile_f = null;
      // imageFile_b = null;
      //imageFile_r = null;
      //imageFile_l = null;
      //   imageFile_b = null;
      //   imageFile_l = null;
      //  imageFile_r = null;
      uploading = false;
      //  productId = DateTime.now().millisecondsSinceEpoch.toString();
      //  _descriptionTextEditingController.clear();
      //  _titleTextEditingController.clear();
      // _shortInfoTextEditingController.clear();
      //  _priceTextEditingController.clear();
    });
    SnackBar snackbar = SnackBar(
      content: Text("data saved"),
    );
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  saveItemInfo_b(String ImageFe) async {
    // String imageDownloadUrl_b = await uploadItemImage(ImageFe);
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    final itemsRef = FirebaseFirestore.instance
        .collection('Driver')
        .doc(uid)
        .collection('driver');

    itemsRef.doc(ve_id).update({
      // 'shortInfo': _shortInfoTextEditingController.text.trim(),
      // 'longDescription': _descriptionTextEditingController.text.trim(),
      //  'price': int.parse(_priceTextEditingController.text),
      //  'publishedDate': DateTime.now(),
      'status': 'available',
      "v_avatar_b": ImageFe,

      // 'title': _titleTextEditingController.text.trim(),
    });
    print(" Name of is:  $ImageFe");
    setState(() {
      imageFile_b = null;
      // imageFile_b = null;
      //imageFile_r = null;
      //imageFile_l = null;
      //   imageFile_b = null;
      //   imageFile_l = null;
      //  imageFile_r = null;
      uploading = false;
      //  productId = DateTime.now().millisecondsSinceEpoch.toString();
      //  _descriptionTextEditingController.clear();
      //  _titleTextEditingController.clear();
      // _shortInfoTextEditingController.clear();
      //  _priceTextEditingController.clear();
    });
    SnackBar snackbar = SnackBar(
      content: Text("data saved"),
    );
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  saveItemInfo_l(String ImageFe) async {
    // String imageDownloadUrl_f = await uploadItemImage(ImageFe);
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    final itemsRef = FirebaseFirestore.instance
        .collection('Driver')
        .doc(uid)
        .collection('driver');

    itemsRef.doc(ve_id).update({
      // 'shortInfo': _shortInfoTextEditingController.text.trim(),
      // 'longDescription': _descriptionTextEditingController.text.trim(),
      //  'price': int.parse(_priceTextEditingController.text),
      //  'publishedDate': DateTime.now(),
      'status': 'available',
      "v_avatar_l": ImageFe,

      // 'title': _titleTextEditingController.text.trim(),
    });
    print(" Name of is:  $ImageFe");
    setState(() {
      imageFile_l = null;
      // imageFile_b = null;
      //imageFile_r = null;
      //imageFile_l = null;
      //   imageFile_b = null;
      //   imageFile_l = null;
      //  imageFile_r = null;
      uploading = false;
      //  productId = DateTime.now().millisecondsSinceEpoch.toString();
      //  _descriptionTextEditingController.clear();
      //  _titleTextEditingController.clear();
      // _shortInfoTextEditingController.clear();
      //  _priceTextEditingController.clear();
    });
    SnackBar snackbar = SnackBar(
      content: Text("data saved"),
    );
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  saveItemInfo_r(String ImageFe) async {
    // String imageDownloadUrl_f = await uploadItemImage(ImageFe);
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    final itemsRef = FirebaseFirestore.instance
        .collection('Driver')
        .doc(uid)
        .collection('driver');

    itemsRef.doc(ve_id).update({
      // 'shortInfo': _shortInfoTextEditingController.text.trim(),
      // 'longDescription': _descriptionTextEditingController.text.trim(),
      //  'price': int.parse(_priceTextEditingController.text),
      //  'publishedDate': DateTime.now(),
      'status': 'available',
      "v_avatar_r": ImageFe,

      // 'title': _titleTextEditingController.text.trim(),
    });
    print(" Name of is:  $ImageFe");
    setState(() {
      imageFile_r = null;

      uploading = false;
    });
    SnackBar snackbar = SnackBar(
      content: Text("data saved"),
    );
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  void OnSavedIamge(String v_avtar_f, String v_avatar_l, String v_avatar_b,
      String v_avtar_r) async {
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    final itemsRef = FirebaseFirestore.instance.collection(uid);

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Driver")
        .doc(uid)
        .collection('driver')
        .doc(ve_id)
        .get();
    Map _docdata = doc.data();
    vehicle = Vehicle.fromDocument(doc, _docdata);
    vehicle_name = vehicle.v_name;

    String village = vehicle.village;
    String pincode = vehicle.pincode;
    //String photoUrl = user.avatarUrl;

    String Authory = vehicle.Authority;
    String company = vehicle.v_company_name;
    String Rc = vehicle.v_Rc;
    String Engine = vehicle.Engine_size;
    String Fuel_type = vehicle.Fuel_type;
    String _date = vehicle.v_date;
    //   final v_uid = DateTime.now().day.toString();
    itemsRef.doc(ve_id).update({
      // 'shortInfo': _shortInfoTextEditingController.text.trim(),
      // 'longDescription': _descriptionTextEditingController.text.trim(),
      //  'price': int.parse(_priceTextEditingController.text),
      //  'publishedDate': DateTime.now(),
      'status': 'available',
      "v_avatar_b": v_avatar_b,
      "v_avatar_f": v_avtar_f,
      "v_avatar_r": v_avtar_r,
      "v_avatar_l": v_avatar_l,
      "v_name": vehicle_name,
      "v_uid": ve_id,
      "village": village,
      "pincode": pincode,
      "company": company,
      "registration": Authory,
      "engine_size": Engine,
      "fuel_type": Fuel_type,
      "rc": Rc,
      "vehicle_name": vehicle_name,
      "r_date": _date

      // 'title': _titleTextEditingController.text.trim(),
    });
    print("Value of Uid ${ve_id}");
  }
}

const String _svg_r1x70w =
    '<svg viewBox="8.0 30.4 191.0 310.6" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 35.94, 51.99)" d="M 0.5593361854553223 0.5593361854553223 L 15.86343765258789 15.86342811584473 C 16.60922050476074 16.60921096801758 17.8183650970459 17.81835746765137 18.56414794921875 18.56414222717285 C 19.30994033813477 19.30993270874023 19.30993461608887 19.3099308013916 18.56414985656738 18.56414413452148 L 3.260061740875244 3.260061740875244 C 2.514275074005127 2.514276027679443 1.305122852325439 1.305122852325439 0.5593380928039551 0.5593390464782715 C -0.1864447593688965 -0.1864442825317383 -0.1864471435546875 -0.1864476203918457 0.5593361854553223 0.5593361854553223 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 20.51, 43.9)" d="M 4.6072998046875 17.21065139770508 L 19.91138076782227 1.906576156616211 C 20.65716361999512 1.160793304443359 20.65716361999512 1.160796165466309 19.91138458251953 1.906576156616211 C 19.16560173034668 2.652356147766113 17.95644760131836 3.861508369445801 17.21066474914551 4.607291221618652 L 1.906577944755554 19.911376953125 C 1.16079318523407 20.65716171264648 1.160793662071228 20.65716171264648 1.906578063964844 19.911376953125 C 2.652359962463379 19.16559219360352 3.861514568328857 17.95643615722656 4.6072998046875 17.21065139770508 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(8.0, 197.0)" d="M 0 0 L 191 0 L 191 144 L 0 144 L 0 0 Z" fill="#4fcfd4" fill-opacity="0.48" stroke="#707070" stroke-width="1" stroke-opacity="0.48" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hvg28l =
    '<svg viewBox="45.0 42.9 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 45.0, 42.94)" d="M 1.050692958415311e-06 1.504374495198135e-06 L 6.852663318568375e-06 1.993870682781562e-06 C 7.135399300750578e-06 2.017724227698636e-06 7.383937827398768e-06 2.266263436467852e-06 7.407790690194815e-06 2.54899919127638e-06 C 7.43164719096967e-06 2.831735400832258e-06 7.221779924293514e-06 3.04160084851901e-06 6.93904303261661e-06 3.017747076228261e-06 L 1.137074718826625e-06 2.528251798139536e-06 C 8.543385092707467e-07 2.504398253222462e-06 6.057985046936665e-07 2.25585881707957e-06 5.819451871502679e-07 1.973123062271043e-06 C 5.580914717029373e-07 1.690386625341489e-06 7.679569762331084e-07 1.480520950281061e-06 1.050692958415311e-06 1.504374495198135e-06 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 45.0, 42.94)" d="M 4.390864205561229e-07 -1.160429974333965e-07 L 6.241054961719783e-06 -6.055371386537445e-07 C 6.523789124912582e-06 -6.293907972576562e-07 6.733654117851984e-06 -4.195252358840662e-07 6.70980307404534e-06 -1.367895947623765e-07 C 6.685949756501941e-06 1.459463874198264e-07 6.437411229853751e-06 3.944855961890426e-07 6.154673428682145e-06 4.183391411061166e-07 L 3.527047738316469e-07 9.078342486645852e-07 C 6.996894086341854e-08 9.316885325461044e-07 -1.398964855070517e-07 7.218227437988389e-07 -1.160428979574135e-07 4.390864489778323e-07 C -9.218921803721969e-08 1.563512768143482e-07 1.563506373258861e-07 -9.218867091931315e-08 4.390864205561229e-07 -1.160429974333965e-07 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j6tf5o =
    '<svg viewBox="45.0 42.9 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 45.0, 42.94)" d="M 5.111551217851229e-07 4.240882844896987e-08 L 6.313114226941252e-06 5.319093361322302e-07 C 6.595848844881402e-06 5.55762994736142e-07 6.844386916782241e-06 8.043015213843319e-07 6.86824023432564e-06 1.087037048819184e-06 C 6.892095825605793e-06 1.369772121506685e-06 6.68222992317169e-06 1.579637114446086e-06 6.399493940989487e-06 1.555783342155337e-06 L 5.975375074740441e-07 1.066283971340454e-06 C 3.14802036882611e-07 1.042430085362867e-06 6.626234494433447e-08 7.93890990280488e-07 4.24088568706793e-08 5.111560312798247e-07 C 1.855494247138267e-08 2.284200490976218e-07 2.284198217239464e-07 1.855494247138267e-08 5.111551217851229e-07 4.240882844896987e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 45.0, 42.94)" d="M 5.119212573845289e-07 -3.433598649849046e-08 L 6.313876838248689e-06 -5.238338189883507e-07 C 6.59661191093619e-06 -5.476881597132888e-07 6.806475539633539e-06 -3.378230246653402e-07 6.782624041079544e-06 -5.508825395850181e-08 C 6.758769814041443e-06 2.276471349205167e-07 6.510231287393253e-06 4.761862726354593e-07 6.2274948504637e-06 5.000397322874051e-07 L 4.255388432738982e-07 9.895392167891259e-07 C 1.428036711104141e-07 1.013393557514064e-06 -6.706117972044012e-08 8.035285645746626e-07 -4.320741098240433e-08 5.207927529227163e-07 C -1.935351789938977e-08 2.380581634042755e-07 2.291860283776259e-07 -1.048145392701372e-08 5.119212573845289e-07 -3.433598649849046e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3l4kua =
    '<svg viewBox="1.8 34.0 409.1 9.8" ><path transform="translate(2.12, 34.0)" d="M -0.04563090205192566 0 L 408.7761535644531 0 L 408.7761535644531 9.747811317443848 C 408.7761535644531 9.747811317443848 194.5473022460938 10.07676219940186 92.34188079833984 8.599824905395508 C -9.863560676574707 7.122886657714844 -0.04563090205192566 8.599824905395508 -0.04563090205192566 8.599824905395508 L -0.04563090205192566 0 Z" fill="#000000" fill-opacity="0.26" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pk9al0 =
    '<svg viewBox="0.0 0.0 23.4 41.8" ><path transform="translate(0.0, -0.1)" d="M 11.68280029296875 0.1000000536441803 C 18.15327644348145 0.1000000536441803 23.3656005859375 7.82693338394165 23.3656005859375 17.38737678527832 C 23.3656005859375 22.23308563232422 21.5682487487793 27.34071731567383 16.80525970458984 34.2818603515625 L 11.68280029296875 41.87782669067383 L 6.470474720001221 34.2818603515625 C 1.797353863716125 27.20975303649902 -1.111205918391533e-07 22.10211944580078 -1.111205918391533e-07 17.38737678527832 C -1.111205918391533e-07 7.82693338394165 5.212326526641846 0.1000000536441803 11.68280029296875 0.1000000536441803 L 11.68280029296875 0.1000000536441803 Z" fill="#d8772d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_19q0g8 =
    '<svg viewBox="25.0 733.9 100.0 42.0" ><path transform="translate(25.04, 733.87)" d="M 10.64356327056885 0 L 89.35643005371094 0 C 95.23470306396484 0 100 9.402019500732422 100 21 C 100 32.59798049926758 95.23470306396484 42 89.35643005371094 42 L 78.64769744873047 42 L 10.64356327056885 42 C 4.765285491943359 42 0 32.59798049926758 0 21 C 0 9.402019500732422 4.765285491943359 0 10.64356327056885 0 Z" fill="#d6681e" stroke="#b95a1a" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ympvr4 =
    '<svg viewBox="276.0 733.9 100.0 42.0" ><path transform="translate(276.04, 733.87)" d="M 10.64356327056885 0 L 89.35643005371094 0 C 95.23470306396484 0 100 9.402019500732422 100 21 C 100 32.59798049926758 95.23470306396484 42 89.35643005371094 42 L 78.64769744873047 42 L 10.64356327056885 42 C 4.765285491943359 42 0 32.59798049926758 0 21 C 0 9.402019500732422 4.765285491943359 0 10.64356327056885 0 Z" fill="#d6681e" stroke="#b95a1a" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
