import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:easy_localization/easy_localization.dart';
//import 'package:firebasesign/service/geo_locator.dart';
//import 'package:firebasesign/service/places.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/farmer/order_book.dart';

class BookEquipment extends StatefulWidget {
  String v_name;
  String v_rate;
  String v_Driver;
  String uid;
  String d_mobile;
  String v_address;
  GeoPoint d_coords;
  String d_address;
  GeoPoint f_coords;
  String f_address;
  BookEquipment(
      {Key key,
      this.d_address,
      this.f_address,
      this.d_coords,
      this.f_coords,
      this.v_name,
      this.v_rate,
      this.v_address,
      this.d_mobile,
      this.v_Driver,
      this.uid})
      : super(key: key);
  @override
  _BookEquipment createState() => _BookEquipment(
      vehicle_name: v_name,
      v_rate: v_rate,
      v_Driver: v_Driver,
      veh_uid: uid,
      v_address: v_address,
      d_mobile: d_mobile,
      d_coords: d_coords,
      d_address: d_address,
      f_address: f_address,
      f_coords: f_coords);
}

class _BookEquipment extends State<BookEquipment> {
  _BookEquipment(
      {this.vehicle_name,
      this.d_mobile,
      this.v_address,
      this.v_rate,
      this.v_Driver,
      this.d_coords,
      this.d_address,
      this.f_coords,
      this.f_address,
      this.veh_uid});

  GeoPoint d_coords;
  String d_address;
  GeoPoint f_coords;
  String f_address;
  final ve_uid = DateTime.now().millisecondsSinceEpoch.toString();
  //final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final dateFormat_s = DateFormat("dd / MM / yyyy");
  final dateFormat_e = DateFormat("dd / MM / yyyy");
  final timeFormat_s = DateFormat("h:mm a");
  final timeFormat_e = DateFormat("h:mm a");
  DateTime date;
  TimeOfDay time;
  String d_mobile;
  String v_address;
  //int land;
  // final locationService= GeoLocatorService();
  // final placesService = PlaceService();
  GoogleMapController mapController;
  ValueNotifier<DateTime> _datetime = ValueNotifier<DateTime>(DateTime.now());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController Engine = TextEditingController();
  TextEditingController land = TextEditingController();
  String v_rate;
  String v_Driver;
  //String photo;
  String v_uid;
  bool loading = true;
  User_d user;
  String veh_uid;
  String vehicle_name;
  //String company;
  String s_s_date;
  String s_e_date;
  String s_s_time;
  String s_e_time;
  String crop;
  //String email;
  bool s_s_validate = true;
  bool s_e_validate = true;

  // bool loading = false;
  bool _displaynameValid = true;
  bool _mobileValid = true;
  bool _contryValid = true;
  bool _stateValid = true;
  bool _districtValid = true;
  bool _blockValid = true;
  bool _vilageValid = true;
  bool _pincodeValid = true;
  bool _photoUrlValid = true;
  bool _datad = true;
  bool _vehicle_name = true;
  bool _Authority = true;
  bool _company = true;
  bool _Rc = true;
  bool _engine = true;
  bool _v_age = true;
  bool _fuelt = true;
  bool _email = true;
  bool _isRadio = false;
  bool s_date = true;
  bool e_date = true;
  FirebaseAuth Auth = FirebaseAuth.instance;
  // final uid = (FirebaseAuth.instance.currentUser).uid;
  final user_ref = FirebaseFirestore.instance.collection("Order_details");

  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    //Firestore.instance.collection("users").document(uid).get();

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map _docdata = doc.data();
    user = User_d.fromDocument(doc, _docdata);
    // v_uid= user.uid;
    name.text = user.name;
    // photo = user.avatarUrl;
    email.text = user.email;
    mobile.text = user.mobile;
    block.text = user.block;
    village.text = user.village;
    pincode.text = user.pincode;
    setState(() {
      loading = false;
    });
  }

  final vehicle = {
    "1": "Tractor",
    "2": " Pickup",
    "3": " thresher",
    "4": "Backhue loader Excavator",
    "5": "cultivator",
    "6": "Trolley",
    "7": "Tractor Spayers",
    "8": "Dump-truck",
    "9": "Hydraulic Excavator",
    "10": "power Reaper",
    "11": "Tractor Dozer",
    "12": "Tractor Generator",
    "13": "Harvester",
    "14": " Land Leveller",
    "15": "Mini-Tiller Rotary",
    "16": "Plough",
    "17": "Post Hole Digger",
    "18": "Tractor Reaper",
    "19": "Rice Plantar",
    "20": "Seeds-drill Machine",
    "21": "Water Tanker"
  };

  final Crop_type = {
    "14": "Empty field",
    "1": "Soyabean",
    "2": "Gram",
    "3": "Pulses",
    "4": "Corn",
    "5": "Moong",
    "6": "Mustard",
    "9": "Urad",
    "10": "Jower",
    "11": "chili",
    "12": "Mango",
    "13": "fruit",
    "7": "Peanut",
    "8": "Potato",
    "15": "Rice"
  };
  List<DropdownMenuItem<String>> t_croplist = List();
  List<DropdownMenuItem<String>> statelist = List();

  void Vehicle_load() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in vehicle.keys) {
      statelist.add(
        DropdownMenuItem<String>(
          child: Text(vehicle[key]),
          value: vehicle[key],
        ),
      );
    }
  }

  void CRop_list() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Crop_type.keys) {
      t_croplist.add(
        DropdownMenuItem<String>(
          child: Text(Crop_type[key]),
          value: Crop_type[key],
        ),
      );
    }
  }

  void initState() {
    super.initState();
    getUser();
    CRop_list();
    Vehicle_load();
    // Countryload();
    //  State_load();
    //  Country_load();
  }

  //for booking farm equipment in app

  Future registationData() async {
    setState(() async {
      name.text.trim().length < 30 || name.text.isEmpty
          ? _displaynameValid = true
          : _displaynameValid = false;
      mobile.text.trim().length == 10 || mobile.text.isEmpty
          ? _mobileValid = true
          : _mobileValid = false;

      s_s_date.length < 20 || s_s_date.isEmpty ? s_date = true : s_date = false;
      s_e_date.length < 20 || s_e_date.isEmpty ? e_date = true : e_date = false;
      // Dropcountry.trim().length <= 30 || Dropcountry.trim().isEmpty
      //   ? _contryValid = true
      //  : _contryValid = false;
      //  company.length <= 30 || company.isEmpty
      //    ? _company = true
      //  : _company = false;
      //district.trim().length < 23 || district.trim().isEmpty
      //  ? _districtValid = true
      //: _districtValid = false;

      vehicle_name.length < 53 || vehicle_name.isEmpty
          ? _vehicle_name = true
          : _vehicle_name = false;
      //     ? _districtValid = true
      //     : _districtValid = false;
      // _state.trim().length < 23 || _state.trim().isEmpty
      //   ? _districtValid = true
      // : _districtValid = false;
      //block.text.trim().length < 23 || block.text.isEmpty
      //  ? _blockValid = true
      // : _blockValid = false;
      village.text.trim().length < 53 || village.text.isEmpty
          ? _vilageValid = true
          : _vilageValid = false;
      pincode.text.trim().length == 6 || pincode.text.isEmpty
          ? _pincodeValid = true
          : _pincodeValid = false;
      s_s_time.trim().length < 53 || s_s_time.isEmpty
          ? s_s_validate = true
          : s_s_validate = false;
      s_e_time.trim().length < 53 || s_e_time.isEmpty
          ? s_e_validate = true
          : s_e_validate = false;
      // Fuel_type.length < 53 || Fuel_type.isEmpty
      //   ? _fuelt = true
      // : _fuelt = false;

      // Authory.text.trim().length < 53 || Authory.text.isEmpty
//          ? _Authority = true
      //        : _Authority = false;
      ///  _date.length < 20 || _date.isEmpty ? _datad = true : _datad = false;

      var fuser = await FirebaseAuth.instance.currentUser;

      if (_displaynameValid &&
          _mobileValid &&
          s_date &&
          e_date &&
          s_s_validate &&
          s_e_validate &&
          //  _blockValid &&
          _pincodeValid &&
          _vilageValid &&
          // _engine &&
          // _Rc &&
          // _company &&
          _Authority &&
          // _datad &&
          _vehicle_name) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(fuser.uid)
            .collection("f_Order")
            .doc(ve_uid)
            .set({
          "f_name": name.text,
          "f_uid": fuser.uid,
          "f_mobile": mobile.text,
          //  "country": Dropcountry,
          //    "state": _state,
          //    "district": district,
          "d_name": v_Driver,
          "d_uid": veh_uid,
          "d_mobile": d_mobile,
          "d_address": v_address,
          "v_uid": ve_uid,
          "village": village.text,
          "pincode": pincode.text,
          // "company": company,
          "land": land.text,
          //  "engine_size": Engine.text,
          "crop": crop,
          "s_s_date": s_s_date,
          's_e_date': s_e_date,
          "rate": v_rate,
          "vehicle_name": vehicle_name,
          "s_s_time": s_s_time,
          "s_e_time": s_e_time,
          "Status": "Request",
          //"block": block
        });

        FirebaseFirestore.instance
            .collection("Drivers")
            .doc(veh_uid)
            .collection("d_Order")
            .doc(ve_uid)
            .set({
          "f_name": name.text,
          "d_coords": d_coords,
          "f_address": f_address,
          "f_coords": f_coords,
          "rate": v_rate,
          //  "f_address": f_address,
          "f_uid": fuser.uid,
          "f_mobile": mobile.text,
          "Status": "Request",
          //  "country": Dropcountry,
          //    "state": _state,
          //    "district": district,
          "d_name": v_Driver,
          "d_uid": veh_uid,
          "d_mobile": d_mobile,
          "d_address": v_address,
          "v_uid": ve_uid,
          "village": village.text,
          "pincode": pincode.text,
          // "company": company,
          "land": land.text,
          //  "engine_size": Engine.text,
          "crop": crop,
          "s_s_date": s_s_date,
          's_e_date': s_e_date,
          "vehicle_name": vehicle_name,
          "s_s_time": s_s_time,
          "s_e_time": s_e_time,
          //"block": block
        }).then((value) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Order_detail(
                  v_service_id: v_uid,
                  v_name: vehicle_name,
                  d_uid: ve_uid,
                  d_name: v_Driver,
                  d_mobile: d_mobile)));
        });
        SnackBar snackbar = SnackBar(
          content: Text("Request is sending to Kaka"),
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

  final _scafoldKey = GlobalKey<ScaffoldState>();

  /// User currentUser = locator.get<UserController>().currentUser;

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
            "Book Farm Equipment",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      key: _scafoldKey,
      body: ListView(
        padding: EdgeInsets.only(top: 10),
        children: <Widget>[
          Stack(
            children: [
              Transform.translate(
                offset: Offset(18.5, -9.5),
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
                  width: 45.0,
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
                  'Book',
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
                  'Work',
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
                  'Pay',
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
                  'Review',
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
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
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
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
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
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
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
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
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
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: Row(children: [
              Image.asset(
                'assets/farmer (2).png',
                width: 35,
                height: 35,
              ),
              SizedBox(width: 10),
              Text("Driver Name:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text("$v_Driver",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: Row(children: [
              Image.asset(
                'assets/TC.png',
                width: 35,
                height: 35,
              ),
              SizedBox(width: 5),
              Text("Vehicle Name:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Text("$vehicle_name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 20),
            child: Row(children: [
              Image.asset(
                'assets/rupees-symbol-png-27204.png',
                width: 25,
                height: 25,
              ),
              SizedBox(width: 20),
              Text("Rate:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text("$v_rate",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextFormField(
                controller: name,
                // validator: (val) => val.isEmpty ? "Enter name" : null,
                decoration: InputDecoration(
                  icon: //Image.asset(
                      //  'assets/ram1.png',
                      // width: 30,
                      // height: 30,
                      // ),

                      Icon(
                    Icons.person,
                    size: 30,
                    color: Color(0xffe78100),
                  ),
                  hintText: "Enter the name",
                  labelText: 'Name',
                ),
                keyboardType: TextInputType.text),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextFormField(
                controller: mobile,
                //  validator: (val) => val.isEmpty ? "Enter enter mobile number" : null,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.call,
                    size: 25,
                    color: Color(0xffe78100),
                  ),
                  errorText:
                      _mobileValid ? null : "Enter 10 digit mobile number",
                  hintText: "Enter the Mobile number",
                  labelText: 'Mobile',
                ),
                keyboardType: TextInputType.number),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextFormField(
              controller: email,
              // validator: (val) => val.isEmpty ? "Enter email id" : null,
              decoration: InputDecoration(
                icon: Icon(
                  //size:25,
                  Icons.email,
                  color: Color(0xffe78100),
                  size: 25,
                ),
                errorText: _email ? null : "Enter email id",
                hintText: "Enter the Email number",
                labelText: 'Email',
              ),
            ),
          ),
          SizedBox(height: 15),
          //   Expanded(
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButtonFormField(
          // decoration: InputDecoration(
          //   hintText: 'Select Vehicle name ',
          // errorText: _vehicle_name
          //   ? null
          // : "please Select vehicle name",
          // icon: Icon(
          // Icons.time_to_leave_rounded,
          // size: 20,
          // color: const Color(0xff3B9412),
          // ),
          //labelText: "Vehicle Name"),
          // value: null, //vehicle_name,
          // .isNotEmpty ? vehicle_name : null,
          // isExpanded: true,
          //  onChanged: (_value) {
          //  vehicle_name = _value;
          //    },
          //  items: statelist,
          // )),
          //),
          //  ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
              decoration: InputDecoration(
                  hintText: 'Select Crop ',
                  errorText: _Authority ? null : "Select crop",
                  //    errorText: crop
                  //      ? null
                  //    : "please Select vehicle name",
                  icon: Image.asset(
                    'assets/leaf.png',
                    width: 35,
                    height: 35,
                  ),
                  //Icon(
                  // lk
                  // size: 20,
                  // color: const Color(0xff3B9412),
                  // ),
                  labelText: "Crop Name"),
              value: crop,
              // .isNotEmpty ? vehicle_name : null,
              isExpanded: true,
              validator: (val) => val.isEmpty ? "Select crop" : null,
              onChanged: (_value) {
                crop = _value;
              },
              items: t_croplist,
            )),
          ),
          SizedBox(
            height: 18,
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 30),
            child: Text(
              "Time of Service",
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
              "From ",
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
                        errorText: s_date ? null : "Select Date",
                        icon: Icon(Icons.date_range, color: Color(0xffe78100)),
                        hintText: 'Select Start Date'),

                    onShowPicker: (context, currentValue) async {
                      return showDatePicker(
                              context: context,
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
                        errorText: s_s_validate ? null : "Select time",
                        hintText: 'Select time'),
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
              "To",
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
                      errorText: e_date ? null : "Select date",
                      hintText: 'Select Date'),

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
                      errorText: s_e_validate ? null : "Select time",
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Color(0xffe78100),
                        size: 25,
                      ),

                      hintText: 'Select time',

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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: land,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.landscape,
                  color: Color(0xffe78100),
                  size: 30,
                ),
                errorText: _fuelt ? null : "Enter less than 10 land",
                hintText: "Land",
                labelText: 'Land area to be operated(in Acre)',
              ),
              keyboardType: TextInputType.number,
              //   validator: (val) => val.length <= 10 ? "Enter you should be less than 10" : null,
              // onChanged: (_val) {
              // setState(() => land = _val as int);
              // },
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextFormField(
                controller: pincode,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_searching_sharp,
                    size: 25,
                    color: Color(0xffe78100),
                  ),
                  errorText: _pincodeValid ? null : "Enter pincode",
                  hintText: "Enter pincode number",
                  labelText: 'Pincode',
                ),
                keyboardType: TextInputType.number),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextFormField(
              controller: village,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.my_location,
                  size: 25,
                  color: Color(0xffe78100),
                ),
                errorText: _vilageValid ? null : "Enter village name",
                hintText: "Enter village name",
                labelText: 'Village',
              ),
              // keyboardType: TextInputType.number
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: RadioListTile(
                    groupValue: _isRadio ? false : true,
                    value: false,
                    title: Text("I accept all", style: TextStyle(fontSize: 14)),
                    activeColor: const Color(0xff179C18),
                    onChanged: (val) {
                      setState(() => _isRadio = !_isRadio);
                    },
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text("Service Terms & conditions",
                      style: TextStyle(fontSize: 14, color: Color(0xff179C18))),
                ),
              ],
            ),

            //
          ),
          SizedBox(
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    height: 35,
                    width: 180,
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff0d9408),
                        borderRadius: BorderRadius.circular(20)),
                    //color: Color(0xffe78100),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 20),
                      child: Text(
                        "Request to  Kaka",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: registationData

                  //() {
                  //if (_formKey.currentState.validate()) {
                  //final ve_uid =
                  //  DateTime.now().millisecondsSinceEpoch.toString();

                  //FirebaseFirestore.instance
                  //  .collection("Order_details")
                  //  .doc(uid)
                  //  .collection("details")
                  //.doc(ve_uid)
                  //.set({
                  //    "uid": uid,
                  //  "mobile": mobile.text,
                  //  "country": Dropcountry,
                  //    "state": _state,
                  //    "district": district,
                  //  "v_Driver": v_Driver,
                  // "d_uid": uid,
                  //  "v_uid": ve_uid,
                  // "village": village.text,
                  //  "pincode": pincode.text,
                  //  "company": company,
                  //  "land": land.text,
                  //  "engine_size": Engine.text,
                  // "crop": crop,
                  //"s_s_date": s_s_date,
                  //   's_e_date': s_e_date,
                  // "vehicle_name": vehicle_name,
                  //    "s_s_time": s_s_time,
                  //  "s_e_time": s_e_time,
                  //  "block": block,
                  //});
                  //   }
                  //  registationData;
                  //  }
                  ),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    height: 35,
                    width: 80,
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff0d9408),
                        borderRadius: BorderRadius.circular(20)),
                    //color: Color(0xffe78100),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //  builder: (_) => Order_detail() // d_service()
                    //));
                  }),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

const String _svg_l51z3e =
    '<svg viewBox="0.0 -30.5 412.0 6.4" ><path transform="translate(0.3, -30.46)" d="M -0.0438455305993557 0 L 411.69970703125 0 L 411.69970703125 6.37982177734375 C 411.69970703125 6.37982177734375 195.9398193359375 6.595115661621094 93.00394439697266 5.628478527069092 C -9.931940078735352 4.66184139251709 -0.0438455305993557 5.628478527069092 -0.0438455305993557 5.628478527069092 L -0.0438455305993557 0 Z" fill="#000000" fill-opacity="0.26" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v0ul3 =
    '<svg viewBox="267.3 0.0 30.4 32.1" ><path transform="translate(274.03, 6.53)" d="M 11.04225921630859 -6.5201416015625 C 19.60021781921387 -6.24506664276123 23.732421875 2.688259840011597 23.732421875 6.448154926300049 C 23.732421875 10.20804977416992 15.32873916625977 25.589599609375 11.04225921630859 25.589599609375 C 6.755778312683105 25.589599609375 -6.68701171875 10.20804977416992 -6.68701171875 6.448154926300049 C -6.68701171875 2.688259840011597 2.484299182891846 -6.79521656036377 11.04225921630859 -6.5201416015625 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_o1u81b =
    '<svg viewBox="105.7 15.4 24.6 24.4" ><path transform="translate(105.69, 15.41)" d="M 12.3115234375 0 C 19.11099052429199 0 24.623046875 5.461066246032715 24.623046875 12.1976318359375 C 24.623046875 18.9341983795166 19.11099052429199 24.395263671875 12.3115234375 24.395263671875 C 5.512057304382324 24.395263671875 0 18.9341983795166 0 12.1976318359375 C 0 5.461066246032715 5.512057304382324 0 12.3115234375 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_94elrl =
    '<svg viewBox="0.0 0.0 19.1 38.7" ><path transform="translate(0.0, -0.1)" d="M 9.565673828125 0.1000000089406967 C 14.86358737945557 0.1000000089406967 19.13134765625 7.254195690155029 19.13134765625 16.10599708557129 C 19.13134765625 20.59252548217773 17.65970802307129 25.32156944274902 13.75985717773438 31.74822044372559 L 9.565673828125 38.78115844726563 L 5.29791259765625 31.74822044372559 C 1.471642374992371 25.2003173828125 -4.311734907912206e-31 20.47126770019531 -4.311734907912206e-31 16.10599708557129 C -2.614161997968926e-15 7.254195690155029 4.267762660980225 0.1000000089406967 9.565673828125 0.1000000089406967 L 9.565673828125 0.1000000089406967 Z" fill="#e19358" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mno4x8 =
    '<svg viewBox="8.3 373.8 342.8 327.2" ><path transform="translate(7.04, 350 .8)" d="M 19.05419921875 23 L 117.90625 23" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(16.5, 562.54)" d="M 0 0.30352783203125 L 115 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(91.51, 562.77)" d="M 161.48779296875 0 L 234.5473327636719 0 L 254.2928161621094 0 L 299.6162109375 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(8.5, 635.31)" d="M 0 0 L 130 3.98272705078125" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(250.75, 632.67)" d="M 0 0.4013671875 L 140.24609375 0 L 140.24609375 0.4013671875" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(250.5, 699.05)" d="M 0 0 L 138 2" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(8.32, 691.5)" d="M 0 1.72491455078125 L 141.17724609375 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qub76t =
    '<svg viewBox="2.5 0.0 20.9 17.7" ><path transform="translate(-4.53, -10.0)" d="M 6.999998092651367 10 L 17.43628692626953 27.69284057617188 L 27.8725700378418 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_8xe5nz =
    '<svg viewBox="0.0 3.2 29.5 11.3" ><path transform="translate(0.0, 26.56)" d="M 0 -18.75424194335938 L 29.52966499328613 -23.3739013671875 L 20.35762214660645 -12.034423828125 L 0 -12.034423828125 L 0 -18.75424194335938 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7s4don =
    '<svg viewBox="7.2 -0.2 22.7 18.5" ><path transform="translate(0.23, -10.2)" d="M 6.999998569488525 10 L 18.36645889282227 28.45043754577637 L 29.73291206359863 10 L 6.999998569488525 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7b7pk8 =
    '<svg viewBox="0.0 0.0 33.6 28.5" ><path transform="translate(0.0, 0.0)" d="M 13.11210060119629 28.04759979248047 L 0.9858028888702393 15.86771965026855 C 0.4405957460403442 15.8601655960083 0 15.41587829589844 0 14.86800003051758 L 0 13.70250034332275 C 0 13.17546653747559 0.4076693952083588 12.74422454833984 0.9240078330039978 12.70544910430908 L 13.11210060119629 0.4635000228881836 C 13.72770023345947 -0.1547999978065491 14.7249002456665 -0.1547999978065491 15.340500831604 0.4635000228881836 C 15.95610046386719 1.081799983978271 15.95610046386719 2.083500146865845 15.340500831604 2.701800107955933 L 5.383697032928467 12.70260047912598 L 32.61600112915039 12.70260047912598 C 33.16860198974609 12.70260047912598 33.61680221557617 13.14990043640137 33.61680221557617 13.70250034332275 L 33.61680221557617 14.86800003051758 C 33.61680221557617 15.42059993743896 33.16860198974609 15.86790084838867 32.61600112915039 15.86790084838867 L 5.442835807800293 15.86790084838867 L 15.340500831604 25.80930137634277 C 15.95610046386719 26.4276008605957 15.95610046386719 27.42930030822754 15.340500831604 28.04759979248047 C 15.03270053863525 28.35675048828125 14.62950038909912 28.51132583618164 14.22630023956299 28.51132583618164 C 13.82310009002686 28.51132583618164 13.41989994049072 28.35675048828125 13.11210060119629 28.04759979248047 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_92j24n =
    '<svg viewBox="20.2 270.5 360.6 1.0" ><path transform="translate(1.16, 247.46)" d="M 19.05419921875 23 L 379.61865234375 23" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_d1lw3 =
    '<svg viewBox="25.0 373.8 370.0 135.8" ><path transform="translate(92.36, 350.8)" d="M 160.63916015625 23 L 298.63916015625 23" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(7.04, 420.74)" d="M 19.05419921875 23 L 113.6308670043945 23" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(233.95, 431.03)" d="M 19.05419921875 23 L 161.05419921875 23" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(5.95, 486.58)" d="M 19.05419921875 23 L 176.05419921875 23" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vsmnv =
    '<svg viewBox="7.0 0.0 16.2 17.0" ><path transform="translate(-0.03, -10.0)" d="M 6.999998569488525 10 L 15.11913871765137 26.99999809265137 L 23.23827934265137 10 L 6.999998569488525 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_90hbg7 =
    '<svg viewBox="-0.1 2.3 30.0 14.2" ><path transform="translate(-7.1, -7.7)" d="M 6.999998092651367 9.999999046325684 L 22 24.2338809967041 L 37 9.999999046325684 L 6.999998092651367 9.999999046325684 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xgxsj8 =
    '<svg viewBox="105.0 815.2 205.7 40.5" ><path transform="translate(105.0, 815.17)" d="M 21.88988304138184 0 L 183.7732086181641 0 C 195.8626403808594 0 205.6630859375 9.075974464416504 205.6630859375 20.27175903320313 C 205.6630859375 31.46753883361816 195.8626403808594 40.54351806640625 183.7732086181641 40.54351806640625 L 21.88988304138184 40.54351806640625 C 9.800434112548828 40.54351806640625 0 31.46753883361816 0 20.27175903320313 C 0 9.075974464416504 9.800434112548828 0 21.88988304138184 0 Z" fill="#e39b65" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
