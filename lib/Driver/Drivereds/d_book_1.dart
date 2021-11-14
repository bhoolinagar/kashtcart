import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kisan/Driver/Auth/service_user_id.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/loading.dart';

class d_book_work extends StatefulWidget {
  String ve_id;
  String f_uid;
  d_book_work({this.ve_id, this.f_uid});
  @override
  _d_book_1 createState() => _d_book_1(f_uid: f_uid, ve_uid: ve_id);
}

class _d_book_1 extends State<d_book_work> {
  _d_book_1({this.f_uid, this.ve_uid});
  String f_uid;
  String ve_uid;

  //String land;
  String f_name;
  String rate;
  String d_name;
  String f_mobile;
  String address;

  String v_name;
  String village;

  String s_s_date;
  String s_e_date;
  String s_s_time;
  String s_e_time;
  String crop;
  //String email;
  bool s_s_validate = true;
  bool s_e_validate = true;
  bool s_date = true;
  bool e_date = true;

  final dateFormat_s = DateFormat("dd / MM / yyyy");
  final dateFormat_e = DateFormat("dd / MM / yyyy");
  final timeFormat_s = DateFormat("h:mm a");
  final timeFormat_e = DateFormat("h:mm a");
  TextEditingController amount = TextEditingController();
  TextEditingController land = TextEditingController();
  //TextEditingController email = TextEditingController();
  // TextEditingController mobile = TextEditingController();
  // TextEditingController village = TextEditingController();
  //TextEditingController block = TextEditingController();

  final fv_uid = FirebaseAuth.instance.currentUser;
  final _scafoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<DateTime> _datetime = ValueNotifier<DateTime>(DateTime.now());
  bool loading = false;
  Farmer_details farmer;
  bool _landValid = true;
  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });

    final f_uid = (await FirebaseAuth.instance.currentUser).uid;
    // DocumentSnapshot doc =
    //   await FirebaseFirestore.instance.collection("users").doc(uid).get();
    // Map _docdata = doc1.data();
    // user = User_d.fromDocument(doc, _docdata);
    //vehicle_name = user.vehicle;
    DocumentSnapshot doc1 = await FirebaseFirestore.instance
        .collection("Drivers")
        .doc(f_uid)
        .collection('d_Order')
        .doc(ve_uid)
        .get();
    Map _docdata = doc1.data();
    farmer = Farmer_details.fromDocument(doc1, _docdata);
    ve_uid = farmer.service_uid;
    land.text = farmer.land;
    f_name = farmer.f_name;
    f_mobile = farmer.mobile;
    rate = farmer.rate;
    f_name = farmer.f_name;
    address = farmer.f_address;
    s_e_time = farmer.s_e_time;
    s_s_time = farmer.s_s_time;
    s_s_date = farmer.s_s_date;
    s_e_date = farmer.s_e_date;
    v_name = farmer.vehicle;
    village = farmer.village;
    d_name = farmer.d_name;
    amount.text = farmer.amount;
    // = vehicle.v_name;
    // v_avatar_b = vehicle.avatar_b;
    // v_avtar_f = vehicle.avatarUrl_f;
    // v_avatar_l = vehicle.avatar_l;
    // v_avtar_r = vehicle.AvatarUrl_r;

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

  bool _amountValid = true;
  Future amountData() async {
    setState(() async {
      s_s_date.length < 20 || s_s_date.isEmpty ? s_date = true : s_date = false;
      s_e_date.length < 20 || s_e_date.isEmpty ? e_date = true : e_date = false;

      land.text.trim().length < 23 || land.text.isEmpty
          ? _landValid = true
          : _landValid = false;

      amount.text.trim().length == 6 || amount.text.isEmpty
          ? _amountValid = true
          : _amountValid = false;
      s_s_time.trim().length < 53 || s_s_time.isEmpty
          ? s_s_validate = true
          : s_s_validate = false;
      s_e_time.trim().length < 53 || s_e_time.isEmpty
          ? s_e_validate = true
          : s_e_validate = false;

      var fuser = await FirebaseAuth.instance.currentUser;

      if (s_date &&
          e_date &&
          s_s_validate &&
          s_e_validate &&
          _landValid &&
          _amountValid) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(f_uid)
            .collection("f_Order")
            .doc(ve_uid)
            .update({
          //  "country": Dropcountry,
          //    "state": _state,
          //    "district": district,
          "amount": amount.text,

          "land": land.text,

          "crop": crop,
          "s_s_date": s_s_date,
          's_e_date': s_e_date,

          "s_s_time": s_s_time,
          "s_e_time": s_e_time,
          "Status": "Ongoing",
          //"block": block
        });

        FirebaseFirestore.instance
            .collection("Drivers")
            .doc(fv_uid.uid)
            .collection("d_Order")
            .doc(ve_uid)
            .update({
          "Status": "Ongoing",
          //  "country": Dropcountry,
          //    "state": _state,
          //    "district": district,

          "v_uid": ve_uid,

          "land": land.text,
          //  "engine_size": Engine.text,

          "s_s_date": s_s_date,
          's_e_date': s_e_date,
          "amount": amount.text,
          "s_s_time": s_s_time,
          "s_e_time": s_e_time,
          //"block": block
        });
        //.then((value) {
        //  Navigator.of(context).push(MaterialPageRoute(
        //    builder: (context) => Order_detail(
        //      v_service_id: v_uid,
        //    v_name: vehicle_name,
        //  d_uid: ve_uid,
        //   d_name: v_Driver,
        //d_mobile: d_mobile)));
        //  });
        SnackBar snackbar = SnackBar(
          content: Text("amount is sending to Farmer"),
        );
        _scafoldKey.currentState.showSnackBar(snackbar);
      }
    });

    // final v_uid = DateTime.now().millisecondsSinceEpoch.toString();
    //   Firestore.instance.collection(fuser.uid).document(v_uid).setData({
    //   "vehicle_name": vehicle_name,
    // " company": company,
    //   "v_uid": v_uid,
    // });
  }

  //final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0d9408),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => d_drawer()));
          },
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).Driver_order_details_and_work,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      key: _scafoldKey,
      body: loading
          ? Loading()
          : ListView(padding: EdgeInsets.only(top: 10), children: <Widget>[
              Stack(
                children: [
                  Transform.translate(
                    offset: Offset(115.5, -9.5),
                    child: Container(
                        width: 45.0,
                        height: 45.0,
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
                      width: 125.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(20.0, 70.0),
                    child: Text(
                      S.of(context).Book,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xff2a2e43),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(112.0, 70.0),
                    child: Text(
                      S.of(context).Work,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xff2a2e43),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(217.0, 70.0),
                    child: Text(
                      S.of(context).pay,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xff2a2e43),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(296.0, 70.0),
                    child: Text(
                      S.of(context).Review,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(24.0, 30.0),
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
                    offset: Offset(214.0, 30.0),
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
                    offset: Offset(310.0, 30.0),
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
                    offset: Offset(120.0, 30.0),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, left: 7),
                        child: Text(
                          "2",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 19,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.6023000144958496,
                          ),
                        ),
                      ),
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
                    offset: Offset(32.5, 33.5),
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
                    offset: Offset(223.5, 32.5),
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
                  Transform.translate(
                    offset: Offset(317.5, 32.5),
                    child: Text(
                      '4',
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
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 45, right: 20),
                child: Row(children: [
                  Flexible(
                    flex: 5,
                    child: Image.asset(
                      'assets/info.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                      flex: 10,
                      child: Text(S.of(context).Service_ID,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 13,
                      child: Text("$ve_uid", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(children: [
                  Flexible(
                    flex: 5,
                    child: Image.asset(
                      'assets/farmer (2).png',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 10,
                      child: Text(S.of(context).Driver_name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 15,
                      child: Text("$d_name", //"$v_Driver",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(children: [
                  Flexible(
                    flex: 5,
                    child: Image.asset(
                      'assets/TC.png',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 10,
                      child: Text(S.of(context).Vehicle_Name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 10,
                      child: Text("$v_name", //"$vehicle_name",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, right: 20),
                child: Row(children: [
                  Flexible(
                    flex: 5,
                    child: Image.asset(
                      'assets/rupees-symbol-png-27204.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                      flex: 10,
                      child: Text(S.of(context).rate,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 10,
                      child: Text("$rate", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(children: [
                  Flexible(
                    flex: 5,
                    child: Icon(
                      Icons.person_sharp,
                      color: Color(0xffec8b35),
                      size: 30,
                    ),
                    //Image.asset('assets/farmer (2).png', width: 35, height: 35,),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 15,
                      child: Text(S.of(context).Farmer_Name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 15,
                      child: Text("$f_name", //"$v_Driver",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(children: [
                  Flexible(
                    flex: 5,
                    child: Image.asset(
                      'assets/phone.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 10,
                      child: Text(S.of(context).Driver_Mobile,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 12,
                      child: MaterialButton(
                        splashColor: Color(0xffdeb8a3),
                        // color: Color(0xff3da009),
                        onPressed: () {
                          //    _callNumver("${snapshot.data['d_mobile']}");
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 1, top: 5, right: 1),
                          height: 40,
                          width: 300,
                          //decoration: BoxDecoration(
                          //  border: Border.all(
                          //    width: 2.5, color: const Color(0xff3B9412)),
                          // color: Color(0xff3da009),
                          //borderRadius: BorderRadius.circular(30)),
                          child: Text("$f_mobile",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                        ),
                      ))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 30),
                child: Text(
                  S.of(context).Time_of_Service,
                  style: TextStyle(
                      fontSize: 19,
                      color: Color(0xff3c9a07),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 30),
                child: Text(
                  S.of(context).From,
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xffe78100),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DateTimeField(
                        format: dateFormat_s,
                        autocorrect: true,
                        onChanged: (value) {
                          setState(() {
                            s_s_date = (dateFormat_s.format(value));
                          });
                        },
                        //  val == null ? s_e_date.isEmpty : " Enter value",
                        decoration: InputDecoration(
                            errorText:
                                s_date ? null : S.of(context).Select_Date,
                            icon: Icon(Icons.date_range,
                                color: Color(0xffe78100)),
                            hintText: S.of(context).Select_Date),

                        onShowPicker: (context, currentValue) async {
                          return showDatePicker(
                                  context: context,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light()
                                            .copyWith(
                                                primary: Color(0xff219628),
                                                onSecondary: Colors.orange),
                                        // primaryColor: Colors.green,
                                      ),
                                      child: child,
                                    );
                                  },
                                  initialDate: _datetime.value,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100))
                              .then((DateTime dt) => _datetime.value = dt);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DateTimeField(
                        onChanged: (value) {
                          setState(() {
                            s_s_time = (timeFormat_s.format(value));
                          });
                        },
                        format: timeFormat_e,
                        autocorrect: true,
                        // validator: (val) => val. ? "Enter you s" : null,
                        //  val == null ? s_e_time.isEmpty : " Enter value",
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.access_time,
                              color: Color(0xffe78100),
                              size: 25,
                            ),
                            errorText:
                                s_s_validate ? null : S.of(context).Select_time,
                            hintText: S.of(context).Select_time),
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                              context: (context),
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light().copyWith(
                                        primary: Color(0xff219628),
                                        onSecondary: Colors.orange),
                                    // primaryColor: Colors.green,
                                  ),
                                  child: child,
                                );
                              },
                              initialTime: TimeOfDay.fromDateTime(
                                  _datetime.value ?? DateTime.now()));
                          return DateTimeField.convert(time);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 30),
                child: Text(
                  S.of(context).To,
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xffe78100),

                      //Color(0xff068e02),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: DateTimeField(
                      format: dateFormat_s,
                      autocorrect: true,
                      onChanged: (value) {
                        setState(() {
                          s_e_date = (dateFormat_s.format(value));
                        });
                      },
                      // validator: (val) => val.isBefore(s_e_validate),
                      // validator: (val) => val == null ? s_s_date.isEmpty : "Select Start date",
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.date_range,
                            color: Color(0xffe78100),
                            size: 25,
                          ),
                          errorText: e_date ? null : S.of(context).Select_Date,
                          hintText: S.of(context).Select_Date),

                      onShowPicker: (context, currentValue) async {
                        return showDatePicker(
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light().copyWith(
                                      primary: Color(0xff219628),
                                      onSecondary: Colors.orange),
                                  // primaryColor: Colors.green,
                                ),
                                child: child,
                              );
                            },
                            context: context,
                            initialDate: _datetime.value ?? DateTime.now(),
                            firstDate: _datetime.value,
                            lastDate: DateTime(2100));
                      },
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: DateTimeField(
                        format: timeFormat_s,
                        autocorrect: true,
                        onChanged: (value) {
                          setState(() {
                            s_e_time = (timeFormat_s.format(value));
                          });
                        },
                        decoration: InputDecoration(
                          errorText:
                              s_e_validate ? null : S.of(context).Select_time,
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Color(0xffe78100),
                            size: 25,
                          ),

                          hintText: S.of(context).Select_time,

                          //  errorText: s_e_validate
                          //    ? null
                          //  : "Pleas Enter 11 digit Account number",
                        ),
                        keyboardType: TextInputType.number,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                              context: (context),
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light().copyWith(
                                        primary: Color(0xff219628),
                                        onSecondary: Colors.orange),
                                    // primaryColor: Colors.green,
                                  ),
                                  child: child,
                                );
                              },
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()));
                          return DateTimeField.convert(time);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, right: 20),
                child: TextFormField(
                  controller: land,
                  // validator: (val) => val.isEmpty ? "Enter email id" : null,
                  decoration: InputDecoration(
                    icon: Icon(
                      //size:25,
                      Icons.landscape_outlined,
                      color: Color(0xffe78100),
                      size: 25,
                    ),
                    errorText: _landValid ? null : S.of(context).Enter_land,
                    hintText: S.of(context).Enter_land,
                    labelText: S.of(context).Land,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  controller: amount,
                  // validator: (val) => val.isEmpty ? "Enter email id" : null,
                  decoration: InputDecoration(
                    icon: Icon(
                      //size:25,
                      Icons.money,
                      color: Color(0xffe78100),
                      size: 25,
                    ),
                    errorText: _amountValid
                        ? null
                        : S.of(context).Please_Enter_valid_amount,
                    hintText: S.of(context).Please_Enter_valid_amount,
                    labelText: S.of(context).Amount,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                onPressed: //amountData,
                    () {
                  FirebaseFirestore.instance
                      .collection("Drivers")
                      .doc(fv_uid.uid)
                      .collection("d_Order")
                      .doc(ve_uid)
                      .update({
                    "Status": "Ongoing",
                    //  "country": Dropcountry,
                    //    "state": _state,
                    //    "district": district,

                    "land": land.text,
                    //  "engine_size": Engine.text,

                    "s_s_date": s_s_date,
                    's_e_date': s_e_date,
                    "amount": amount.text,
                    "s_s_time": s_s_time,
                    "s_e_time": s_e_time,
                    //"block": block
                  });

                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(f_uid)
                      .collection("f_Order")
                      .doc(ve_uid)
                      .update({
                    "Status": "Ongoing",
                    //  "country": Dropcountry,
                    //    "state": _state,
                    //    "district": district,
                    "land": land.text,
                    //  "engine_size": Engine.text,

                    "s_s_date": s_s_date,
                    's_e_date': s_e_date,
                    "amount": amount.text,
                    "s_s_time": s_s_time,
                    "s_e_time": s_e_time,
                    //"block": block
                  });
                  //  null;
                  // Navigator.of(context)
                  //   .push(MaterialPageRoute(builder: (context) => v_book_pay()
                  //v_book_2(ve_uid: ve_uid, d_uid: d_uid,)
                  // ));
                },
                child: Container(
                  height: 40,
                  width: 130,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff359510),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    S.of(context).sent_amount,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              )
            ]),
    );
  }
}
