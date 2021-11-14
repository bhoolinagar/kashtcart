import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kisan/Driver/Auth/service_user_id.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/farmer/v_book_pay.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/loading.dart';

class v_book_2 extends StatefulWidget {
  String d_uid;
  String ve_uid;
  v_book_2({Key key, this.d_uid, this.ve_uid});
  @override
  _v_book_2 createState() => _v_book_2(ve_uid: ve_uid, d_uid: d_uid);
}

class _v_book_2 extends State<v_book_2> {
  _v_book_2({this.d_uid, this.ve_uid});
  String d_uid;
  String ve_uid;

  String land;
  String d_name;
  String rate;
  String f_name;
  String d_mobile;
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
  //TextEditingController email = TextEditingController();
  // TextEditingController mobile = TextEditingController();
  // TextEditingController village = TextEditingController();
  //TextEditingController block = TextEditingController();

  final fv_uid = FirebaseAuth.instance.currentUser;
  final _scafoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<DateTime> _datetime = ValueNotifier<DateTime>(DateTime.now());
  bool loading = false;
  Farmer_details farmer;
  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });

    final f_uid = (await FirebaseAuth.instance.currentUser).uid;

    DocumentSnapshot doc1 = await FirebaseFirestore.instance
        .collection("users")
        .doc(f_uid)
        .collection('f_Order')
        .doc(ve_uid)
        .get();
    Map _docdata = doc1.data();
    farmer = Farmer_details.fromDocument(doc1, _docdata);
    ve_uid = farmer.service_uid;
    land = farmer.land;
    d_name = farmer.d_name;
    d_mobile = farmer.d_mobile;
    rate = farmer.rate;
    f_name = farmer.f_name;
    address = farmer.f_address;
    s_e_time = farmer.s_e_time;
    s_s_time = farmer.s_s_time;
    s_s_date = farmer.s_s_date;
    s_e_date = farmer.s_e_date;
    v_name = farmer.vehicle;
    village = farmer.village;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading
        ? Loading()
        : Scaffold(
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
                  S.of(context).Book_Farm_Equipment,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            key: _scafoldKey,
            body:
                ListView(padding: EdgeInsets.only(top: 10), children: <Widget>[
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
                      child: Text("Service ID :",
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
                      child: Text(S.of(context).Driver_name,
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
                          child: Text("$d_mobile",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                        ),
                      ))
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
                      'assets/leaf.png',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                      flex: 10,
                      child: Text(S.of(context).Land,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                      flex: 13,
                      child: Text("$land", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)))
                ]),
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
                padding: const EdgeInsets.only(left: 0, right: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Icon(Icons.date_range),
                    ),
                    Expanded(
                      child: Text("Date: $s_s_date", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Icon(Icons.timelapse),
                    ),
                    Expanded(
                      child: Text("Time: $s_s_time", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
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
              //    Padding(
              //    padding: const EdgeInsets.only(left: 20, right: 20),
              //  child: Row(
              //  children: <Widget>[
              //  Expanded(
              //    child: DateTimeField(
              //format: dateFormat_s,
              //        autocorrect: true,
              //      onChanged: (value) {
              //     setState(() {
              //     s_e_date = (dateFormat_s.format(value));
              // });
              //    },
              // validator: (val) => val.isBefore(s_e_validate),
              // validator: (val) => val == null ? s_s_date.isEmpty : "Select Start date",
              //  decoration: InputDecoration(
              //    icon: Icon(
              //    Icons.date_range,
              //  color: Color(0xffe78100),
              //  size: 25,
              // ),
              //    errorText: e_date ? null : "Select date",
              //  hintText: 'Select Date'),

              //     onShowPicker: (context, currentValue) async {
              //     return showDatePicker(
              //       builder: (BuildContext context, Widget child) {
              //       return Theme(
              //       data: ThemeData.light().copyWith(
              //       colorScheme: ColorScheme.light().copyWith(
              //          primary: Color(0xff219628),
              //        onSecondary: Colors.orange),
              // primaryColor: Colors.green,
              //  ),
              //  child: child,
              // );
              // },
              // context: context,
              // initialDate: _datetime.value ?? DateTime.now(),
              //   firstDate: _datetime.value,
              // lastDate: DateTime(2100));
              //    },
              //)),
              //    SizedBox(
              //    width: 5,
              // ),
              //Expanded(
              //child: DateTimeField(
              //format: timeFormat_s,
              //autocorrect: true,
              //   onChanged: (value) {
              //   setState(() {
              //   s_e_time = (timeFormat_s.format(value));
              //});
              //  },
              /// decoration: InputDecoration(
              //errorText: s_e_validate ? null : "Select time",
              //icon: Icon(
              //Icons.access_time_rounded,
              // color: Color(0xffe78100),
              // size: 25,
              // ),

              //hintText: 'Select time',

              //  errorText: s_e_validate
              //    ? null
              //  : "Pleas Enter 11 digit Account number",
              //   ),
              // keyboardType: TextInputType.number,
              //onShowPicker: (context, currentValue) async {
              //final time = await showTimePicker(
              //context: (context),
              //builder: (BuildContext context, Widget child) {
              //return Theme(
              //data: ThemeData.light().copyWith(
              //colorScheme: ColorScheme.light().copyWith(
              //primary: Color(0xff219628),
              //onSecondary: Colors.orange),
              //primaryColor: Colors.green,
              //),
              //child: child,
              //);
              //},
              //initialTime: TimeOfDay.fromDateTime(
              //currentValue ?? DateTime.now()));
              //return DateTimeField.convert(time);
              //},
              //),
              //),
              //],
              //),
              //),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Icon(Icons.date_range),
                    ),
                    Expanded(
                      child: Text("Date: $s_e_date", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Icon(Icons.timelapse),
                    ),
                    Expanded(
                      child: Text("Time: $s_e_time", //"$v_rate",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => v_book_pay(
                            ve_uid: ve_uid,
                            d_uid: d_uid,
                          )
                      //v_book_2(ve_uid: ve_uid, d_uid: d_uid,)
                      ));
                },
                child: Container(
                  height: 40,
                  width: 120,
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff359510),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    S.of(context).pay,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              )
            ]),
          );
  }
}
