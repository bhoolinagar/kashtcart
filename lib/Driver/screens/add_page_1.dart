import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/locator.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/Drivereds/d_search.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/user-controller.dart';
import 'package:location/location.dart';

import './add_page_3.dart';
import 'd_home.dart';

class add_page_1 extends StatefulWidget {
  String profileId;
  add_page_1({this.profileId});
  @override
  Add_page createState() => Add_page();
}

getUid() async {
  return (await FirebaseAuth.instance.currentUser).uid;
}

class Add_page extends State<add_page_1> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  String Dropcountry = "India";
  String _state;
  String district;
  TextEditingController block = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController photoUrl = TextEditingController();
  String vehicle_name = "Tractor";
  TextEditingController Authory = TextEditingController();
  final dateFormat = DateFormat("dd/MM/yyy");
  //final timeFormat = DateFormat("h:mm a");
  String driver_name;
  String d_mobile;
  String company = "Mahindra";
  TextEditingController Rc = TextEditingController();
  TextEditingController Engine = TextEditingController();
  TextEditingController v_age = TextEditingController();
  String Fuel_type;

  String address;
  GeoPoint geoPoints;
  bool _isRadio = false;
  String _date = "date";
  // String ve_uid;
  TimeOfDay time;
  final ve_uid = DateTime.now().millisecondsSinceEpoch.toString();
  bool loading = false;
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
  ValueNotifier<DateTime> _datetime = ValueNotifier<DateTime>(DateTime.now());
  //String States;
  User_d user;
  String v_uid;
  final vehicle = {
    "1": "Tractor",
    "2": "Pickup",
    "3": "Thresher",
    "4": "Backhoe loader Excavator",
    "5": "Cultivator",
    "6": "Trolley",
    "7": "Tractor Spayres",
    "8": "Dump truck",
    "9": "Hydraulic Excavator",
    "10": "Power Reaper",
    "11": "Tractor Dozer",
    "12": "Tractor Generator",
    "13": "Harvester",
    "14": "Land leveller",
    "15": "Mini tiller",
    "16": "Plough",
    "17": "Post hole",
    "18": "Tractor reaper",
    "19": "Rice transplanter",
    "20": "seed-drill",
    "21": "water_tanker",
  };
  final Tractor_c = {
    "1": "Mahindra",
    "2": "Farmtrac",
    "3": "New Hollend",
    "4": "Sonalika",
    "5": "PowerTrac",
    "6": "Tata",
    "7": "scarfue",
    "8": "JCB",
    "9": "Ashok lyload",
    "10": "Other"
  };

  final pickup = {
    "1": "Mahindra",
    "2": " Tata",
    "3": " scarfue",
    "4": "JCB",
    "5": "Ashok lyload"
  };
  final threasher = {
    "2": " Tata",
    "3": "scarfuue",
    "4": "balram",
    "5": " Ashok lyload"
  };

  final jcb = {
    "1": "Mahindra",
    "2": " Tata",
    "3": " scarfuue",
    "4": "JCB",
    "5": "Ashok lyload"
  };
  final cultivator_c = {
    "1": "Mahindra",
    "2": " Umirya",
    "3": " ram",
    "4": "bhooli",
    "5": "Ashok lyload"
  };

  String Value;
  void populate_veh() {
    for (String key in Tractor_c.keys) {
      vehclilist.add(
        DropdownMenuItem<String>(
          child: Text(Tractor_c[key]),
          value: Tractor_c[key],
        ),
      );
    }
  }

  void populate_pik() {
    for (String key in pickup.keys) {
      vehclilist.add(
        DropdownMenuItem<String>(
          child: Text(pickup[key]),
          value: pickup[key],
        ),
      );
    }
  }

  void populate_thre() {
    for (String key in threasher.keys) {
      vehclilist.add(
        DropdownMenuItem<String>(
          child: Text(threasher[key]),
          value: threasher[key],
        ),
      );
    }
  }

  void populate_jcb() {
    for (String key in jcb.keys) {
      vehclilist.add(
        DropdownMenuItem<String>(
          child: Text(jcb[key]),
          value: jcb[key],
        ),
      );
    }
  }

  void populate_cul() {
    for (String key in cultivator_c.keys) {
      vehclilist.add(
        DropdownMenuItem<String>(
          child: Text(cultivator_c[key]),
          value: cultivator_c[key],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    Countryload();
    State_load();
    Country_load();
    T_fuel_load();
    // valueChange(vehicle_name);
    populate_veh();
    //getLoc();
    //  DistrictValue(district);
    // mp_dist();
  }

  final t_fuel = {
    "1": "Diesel",
    "2": "Biodiesel",
    "3": " Compressed Natural gas(CNG)",
    "4": "Electric Battery",
    "5": "Petrol"
  };

  List<DropdownMenuItem<String>> countrylist = List();
  List<DropdownMenuItem<String>> t_fuellist = List();
  List<DropdownMenuItem<String>> vehclilist = List();
  //String _mycountry = " ";
  List<DropdownMenuItem<String>> statelist = List();
  List<DropdownMenuItem<String>> districtlist = List();
  var jsonCode = const JsonCodec();
  List<DropdownMenuItem> _countryItems = [];

  void T_fuel_load() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in t_fuel.keys) {
      t_fuellist.add(
        DropdownMenuItem<String>(
          child: Text(t_fuel[key]),
          value: t_fuel[key],
        ),
      );
    }
  }

  void Countryload() {
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

  bool disabledropdown = false;
  void valueChange(_value) {
    if (_value == 'Tractor') {
      vehclilist = [];
      populate_veh();
    }

    if (_value == 'Pickup') {
      vehclilist = [];
      populate_pik();
    }
    if (_value == 'JCB') {
      vehclilist = [];
      populate_jcb();
    }

    if (_value == 'Thresher') {
      vehclilist = [];
      populate_thre();
    }
    if (_value == 'Cultivator') {
      vehclilist = [];
      populate_cul();
    } else {
      Text("Select india");
    }
    setState(() {
      vehicle_name = _value;
      disabledropdown = true;
    });
  }

  void secondvalue(_value) {
    setState(() {
      company = _value;
    });
  }

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
    name.text = user.name;
    mobile.text = user.mobile;
    Dropcountry = user.country;
    _state = user.state;
    district = user.district;
    block.text = user.block;
    village.text = user.village;
    pincode.text = user.pincode;
    photoUrl.text = user.avatarUrl;
    address = user.address;
    geoPoints = user.geoPoints;

    setState(() {
      loading = false;
    });

    final vehicle = await FirebaseFirestore.instance
        .collection("Driver")
        .doc(uid)
        .collection('driver')
        .doc(ve_uid)
        .get();

    v_use = Vehicle.fromDocument(doc, _docdata);

    vehicle_name = v_use.v_name;
    Authory.text = v_use.Authority;
    company = v_use.v_company_name;
    Rc.text = v_use.v_Rc;
    Engine.text = v_use.Engine_size;
    Fuel_type = v_use.Fuel_type;
    _date = v_use.v_date;
  }

  Vehicle v_use;
  final AuthService _auth = AuthService();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  User_d currentUser = locator.get<UserController>().currentUser;

  Future registationData() async {
    setState(() async {
      name.text.trim().length < 30 || name.text.isEmpty
          ? _displaynameValid = true
          : _displaynameValid = false;
//mobile.text.trim().length == 10 || mobile.text.isEmpty
      //    ? _mobileValid = true
      //   : _mobileValid = false;
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
      //? _districtValid = true
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

      Engine.text.trim().length < 53 || Engine.text.isEmpty
          ? _engine = true
          : _engine = false;
      Rc.text.trim().length < 53 || Rc.text.isEmpty ? _Rc = true : _Rc = false;
      Fuel_type.length < 53 || Fuel_type.isEmpty
          ? _fuelt = true
          : _fuelt = false;

      Authory.text.trim().length < 53 || Authory.text.isEmpty
          ? _Authority = true
          : _Authority = false;
      _date.length < 20 || _date.isEmpty ? _datad = true : _datad = false;

      if ( //_displaynameValid &&
          //  _mobileValid &&
          //  _blockValid &&
          _pincodeValid &&
              _vilageValid &&
              _engine &&
              _Rc &&
              _company &&
              _Authority &&
              _datad &&
              _vehicle_name) {
        var fuser = await FirebaseAuth.instance.currentUser;

        FirebaseFirestore.instance
            .collection("Driver")
            .doc(fuser.uid)
            .collection('driver')
            .doc(ve_uid)
            .set({
          "uid": v_uid,
          //  "mobile": mobile.text,
          //  "country": Dropcountry,
          //    "state": _state,
          //    "district": district,
          "v_uid": ve_uid,
          "village": village.text,
          "pincode": pincode.text,
          "company": company,
          "registration": Authory.text,
          "engine_size": Engine.text,
          "v_avatar_f": null,
          "fuel_type": Fuel_type,
          "rc": Rc.text,
          "vehicle_name": vehicle_name,
          "r_date": _date,
          "rate": 00,
          "coords": geoPoints,
          "d_mobile": mobile.text,
          "d_name": name.text
        });
        FirebaseFirestore.instance.collection("${vehicle_name}").doc(fuser.uid)
            //.collection('vehicle')
            //.doc(ve_uid)
            .set({
          "uid": fuser.uid,
          "v_uid": ve_uid,
          "village": village.text,
          "pincode": pincode.text,
          "company": company,
          "registration": Authory.text,
          "engine_size": Engine.text,
          "fuel_type": Fuel_type,
          "rc": Rc.text,
          "vehicle_name": vehicle_name,
          "r_date": _date,
          'rate': 00,
          "address": address,
          "coords": geoPoints,
          "d_mobile": mobile.text,
          "d_name": name.text
        });

        //  final ve_uid = DateTime.now().millisecondsSinceEpoch.toString();

        // final v_uid = DateTime.now().millisecondsSinceEpoch.toString();
        //   Firestore.instance.collection(fuser.uid).document(v_uid).setData({
        //   "vehicle_name": vehicle_name,
        // " company": company,
        //   "v_uid": v_uid,
        // });
        SnackBar snackbar = SnackBar(
          content: Text("data saved"),
        );
        _scafoldKey.currentState.showSnackBar(snackbar);
      }
    });

    SnackBar snackbar = SnackBar(
      content: Text("data update"),
    );
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  final contries = {
    "1": "Afghanistan",
    "2": "Albania",
    "3": "Algeria",
    "4": "American Samoa",
    "5": "Andorra",
    "6": "Angola",
    "7": "Anguilla",
    "8": "Antarctica",
    "9": "Antigua And Barbuda",
    "10": "Argentina",
    "11": "Armenia",
    "12": "Aruba",
    "13": "Australia",
    "14": "Austria",
    "15": "Azerbaijan",
    "16": "Bahamas The",
    "17": "Bahrain",
    "18": "Bangladesh",
    "19": "Barbados",
    "20": "Belarus",
    "21": "Belgium",
    "22": "Belize",
    "23": "Benin",
    "24": "Bermuda",
    "25": "Bhutan",
    "26": "Bolivia",
    "27": "Bosnia and Herzegovina",
    "28": "Botswana",
    "29": "Bouvet Island",
    "30": "Brazil",
    "31": "British Indian Ocean Territory",
    "32": "Brunei",
    "34": "Burkina Faso",
    "35": "Burundi",
    "36": "Cambodia",
    "37": "Cameroon",
    "38": "Canada",
    "39": "Cape Verde",
    "40": "Cayman Islands",
    "42": "Chad",
    "43": "Chile",
    "44": "China",
    "45": "Christmas Island",
    "46": "Cocos (Keeling) Islands",
    "47": "Colombia",
    "48": "Comoros",
    "49": "Congo",
    "50": "Congo The Democratic Republic Of The",
    "51": "Cook Islands",
    "52": "Costa Rica",
    "53": "Cote D'Ivoire (Ivory Coast)",
    "54": "Croatia (Hrvatska)",
    "55": "Cuba",
    "56": "Cyprus",
    "57": "Czech Republic",
    "58": "Denmark",
    "59": "Djibouti",
    "60": "Dominica",
    "61": "Dominican Republic",
    "62": "East Timor",
    "63": "Ecuador",
    "64": "Egypt",
    "65": "El Salvador",
    "66": "Equatorial Guinea",
    "67": "Eritrea",
    "68": "Estonia",
    "69": "Ethiopia",
    "70": "External Territories of Australia",
    "71": "Falkland Islands",
    "72": "Faroe Islands",
    "73": "Fiji Islands",
    "74": "Finland",
    "75": "France",
    "76": "French Guiana",
    "77": "French Polynesia",
    "78": "French Southern Territories",
    "79": "Gabon",
    "80": "Gambia The",
    "81": "Georgia",
    "82": "Germany",
    "83": "Ghana",
    "84": "Gibraltar",
    "85": "Greece",
    "86": "Greenland",
    "87": "Grenada",
    "88": "Guadeloupe",
    "89": "Guam",
    "90": "Guatemala",
    "91": "Guernsey and Alderney",
    "92": "Guinea",
    "93": "Guinea-Bissau",
    "94": "Guyana",
    "95": "Haiti",
    "96": "Heard and McDonald Islands",
    "97": "Honduras",
    "98": "Hong Kong S.A.R.",
    "99": "Hungary",
    "100": "Iceland",
    "101": "India",
    "102": "Indonesia",
    "103": "Iran",
    "104": "Iraq",
    "105": "Ireland",
    "106": "Israel",
    "107": "Italy",
    "108": "Jamaica",
    "109": "Japan",
    "110": "Jersey",
    "111": "Jordan",
    "112": "Kazakhstan",
    "114": "Kiribati",
    "115": "Korea North",
    "116": "Korea South",
    "117": "Kuwait",
    "118": "Kyrgyzstan",
    "119": "Laos",
    "120": "Latvin",
    "122": "Lesotho",
    "123": "Liberia",
    "124": "Libya",
    "125": "Liechtenstein",
    "126": "Lithuania",
    "127": "Luxembourg",
    "128": "Macau S.A.R.",
    "129": "Macedonia",
    "130": "Madagascar",
    "131": "Malawi",
    "132": "Malaysia",
    "133": "Maldives",
    "134": "Mali",
    "135": "Malta",
    "136": "Man (Isle of)",
    "137": "Marshall Islands",
    "138": "Martinique",
    "139": "Mauritania",
    "140": "Mauritius",
    "141": "Mayotte",
    "142": "Mexico",
    "143": "Micronesia",
    "144": "Moldova",
    "145": "Monaco",
    "146": "Mongolia",
    "147": "Montserrat",
    "148": "Morocco",
    "149": "Mozambique",
    "150": "Myanmar",
    "152": "Nauru",
    "153": "Nepal",
    "154": "Netherlands Antilles",
    "155": "Netherlands The",
    "156": "New Caledonia",
    "157": "New Zealand",
    "159": "Niger",
    "160": "Nigeria",
    "161": "Niue",
    "162": "Norfolk Island",
    "163": "Northern Mariana Islands",
    "164": "Norway",
    "165": "Oman",
    "166": "Pakistan",
    "167": "Palau",
    "168": "Palestinian Territory Occupied",
    "169": "Panama",
    "170": "Papua new Guinea",
    "171": "Paraguay",
    "172": "Peru",
    "173": "Philippines",
    "174": "Pitcairn Island",
    "175": "Poland",
    "176": "Portugal",
    "177": "Puerto Rico",
    "178": "Qatar",
    "179": "Reunion",
    "180": "Romania",
    "181": "Russia",
    "182": "Rwanda",
    "183": "Saint Helena",
    "184": "Saint Kitts And Nevis",
    "185": "Saint Lucia",
    "186": "Saint Pierre and Miquelon",
    "187": "Saint Vincent And The Grenadines",
    "188": "Samoa",
    "189": "San Marino",
    "190": "Sao Tome and Principe",
    "191": "Saudi Arabia",
    "192": "Senegal",
    "193": "Serbia",
    "194": "Seychelles",
    "195": "Sierra Leone",
    "196": "Singapore",
    "197": "Slovakia",
    "198": "Slovenia",
    "199": "Smaller Territories of the UK",
    "200": "Solomon Islands",
    "201": "Somalia",
    "202": "South Africa",
    "203": "South Georgia",
    "204": "South Sudan",
    "205": "Spain",
    "206": "Sri Lanka",
    "207": "Sudan",
    "208": "Suriname",
    "209": "Svalbard And Jan Mayen Islands",
    "210": "Swaziland",
    "211": "Sweden",
    "212": "Switzerland",
    "213": "Syria",
    "214": "Taiwan",
    "215": "Tajikistan",
    "216": "Tanzania",
    "217": "Thailand",
    "218": "Togo",
    "219": "Tokelau",
    "220": "Tonga",
    "221": "Trinidad And Tobago",
    "222": "Tunisia",
    "223": "Turkey",
    "224": "Turkmenistan",
    "225": "Turks And Caicos Islands",
    "226": "Tuvalu",
    "227": "Uganda",
    "228": "Ukraine",
    "229": "United Arab Emirates",
    "230": "United Kingdom",
    "231": "United States",
    "232": "United States Minor Outlying Islands",
    "233": "Uruguay",
    "234": "Uzbekistan",
    "235": "Vanuatu",
    "236": "Vatican City State (Holy See)",
    "237": "Venezuela",
    "238": "Vietnam",
    "239": "Virgin Islands (British)",
    "240": "Virgin Islands (US)",
    "241": "Wallis And Futuna Islands",
    "242": "Western Sahara",
    "243": "Yemen",
    "244": "Yugoslavia",
    "245": "Zambia",
    "246": "Zimbabwe"
  };

  final MPState = {
    "1": "Andaman and Nicobar Islands",
    "2": "Andhra Pradesh",
    "3": "Arunachal Pradesh",
    "4": "Assam",
    "5": "Bihar",
    "6": "Chandigarh",
    "7": "Chhattisgarh",
    "8": "Delhi-NCR",
    "9": "Goa",
    "10": "Gujarat",
    "11": "Haryana",
    "12": "Himachal Pradesh",
    "13": "Jammu and Kashmir",
    "14": "Karnataka",
    "15": "Kenmore",
    "16": "Kerala",
    "17": "Lakshadweep",
    "18": "Madhya Pradesh",
    "19": "Maharashtra",
    "20": "Manipur",
    "21": "Meghalaya",
    "22": "Mizoram",
    "23": "Nagaland",
    "24": "Narora",
    "25": "Natwar",
    "26": "Odisha",
    "27": "Pondicherry",
    "28": "Punjab",
    "29": "Rajasthan",
    "30": "Sikkim",
    "31": "Tamil Nadu",
    "32": "Telangana",
    "33": "Tripura",
    "34": "UP",
    "35": "West Bengal",
    "36": "Ladakh"
  };

  final Andhra_district = {
    " 1": "Anantapur ",
    " 2": "Chittoor ",
    "3 ": "East Godavari ",
    " 4": "Guntur ",
    " 5": " Krishna",
    " 6": "  Kurnool",
    " 7": " Prakasam ",
    "8 ": "Srikakulam ",
    " 9": "Sri Potti Sriramulu ",
    " 10": " Nellore ",
    " 11": " Vizianagaram",
    "12 ": " West Godavari",
    " 13": "YSR District Kadapa(Cuddaph) ",
  };
  final Andaman_district = {
    " 1": "Nicobar ",
    " 2": "North and Middle Andaman",
    " 3": "South Andaman ",
  };
  final Arunchal_district = {
    " 1": "Anjaw ",
    " 2": "Changlang ",
    " 3": "East Kameng ",
    " 4": "East Siang ",
    " 5": " Kamle",
    " 6": "Kra Daadi ",
    " 7": "Kurung Kumey ",
    "8 ": "Lepa Rada ",
    " 9": "Lohit ",
    " 10": "Longding ",
    " 11": "Lower Siang ",
    " 12": " Lower Dibang Velley",
    " 13": "Lower subansiri ",
    " 14": "Namsai ",
    " 15": " Pakke Kessang",
    " 16": "Papum Pare ",
    "17 ": "Shi Yomi ",
    "18 ": "Siang ",
    " 19": "Tawang ",
    " 20": "Tirap",
    "21 ": "Upper Siang ",
    " 22": "Upper Subaniri",
    " 23": "West Kameng",
    " 24": "West Siang ",
  };
  final asssam_district = {
    " 1": "Baksa ",
    " 2": " Barpeta ",
    " 3": "  Biswanath",
    " 4": " Bongigaon",
    " 5": "Cachar ",
    " 6": "Charaideo ",
    " 7 ": " Chirang",
    " 8": " Darrang",
    " 9": "Dhemaji ",
    " 10": " Dhubri ",
    " 11": " Dibrugarh ",
    " 12": "  Dima Hasso(North Cachar Hills)",
    " 13": " Goalpara ",
    " 14": " Golaghat",
    "15 ": " Hailakandi",
    "16 ": "Hojai ",
    " 17": "Jorhat",
    "18 ": "Kamrup ",
    " 19": "Kamrup Metropolitan ",
    " 20": " Karbi Anglong",
    " 21": "Karimganj ",
    " 22": " Kokrajhar ",
    " 23": " Lakhimpur",
    " 24": " Majuli",
    " 25": " Morigaon ",
    " 26": " Nagaon ",
    " 27": " Nalbari",
    "28 ": " Sivasagar ",
    "29 ": " Sonitpur",
    " 30": " South Salamara-Mankachar ",
    " 31": " Tinsukia ",
    " 32": "Udalguri ",
    " 33": "West Karbi Anglong",
  };
  final Delhi_district = {
    " 1": " Central Delhi ",
    "2 ": " East Delhi ",
    " 3": " New Delhi ",
    " 4": "  North Delhi",
    "5 ": " North East Delhi ",
    "6 ": " North West Delhi ",
    " 7": "  Shajdara ",
    " 8": "  South Delhi",
    " 9": " South East Delhi ",
    "10 ": " South West Delhi ",
    " 11": " West Delhi ",
  };
  final goa_district = {
    " 1": " North  Goa",
    " 2": " South Goa",
  };
  final gujrat_district = {
    " 1": "Ahmedabad ",
    " 2": " Amreli ",
    " 3": " Annad ",
    " 4": " Aravalli ",
    " 5": " Banaskantha (palanpur) ",
    " 6": "Bharuch ",
    " 7": " Bhavnagar ",
    "8 ": " Botad ",
    "9 ": "Chhota Udepur ",
    " 10": " Dahod ",
    " 11": "Dangs(Ahwa) ",
    " 12": " Devbhoomi Dwarka ",
    "13 ": " Gandhinagar ",
    " 14": "  Gir Somnath",
    " 15": "  Jamnagar",
    " 16": " Junagadh ",
    " 17": "  Kachchh",
    " 18": "Kheda(Nadiad) ",
    " 19": " Mahisagar ",
    "20 ": " Mehsana ",
    "21 ": " Morbi ",
    "22 ": "Narmada (Rajpipla) ",
    " 23": " Navsari ",
    " 24": "  Panchmahal (Godhra)",
    " 25": " Patan ",
    " 26": "Porbandar ",
    " 27": "  Rajkot",
    "28 ": " Sabarkantha ",
    "29 ": " Surat",
    " 30": "Surendra nagar ",
    " 31": "  Tapi (Vyara)",
    " 32": " Vadodara ",
    " 33": "Valsad",
  };
  final Haryan_district = {
    " 1": "Ambala ",
    " 2": " Bhiwani",
    " 3": "Charkhi Dadri ",
    " 4": "Faridabad ",
    "5 ": " Fatehabad ",
    " 6": "Gurugram(gurgaon)",
    " 7": "Hsar",
    " 8": " Jhajjar",
    " 9": "Jind",
    " 10": " Kaithal",
    " 11": " Karnal",
    " 12": "Kurukshetra",
    "13 ": " Mahendragarh",
    " 14": " Nuh",
    " 15": " Palwal",
    "16 ": " Panchkula",
    " 17": " Panipat",
    " 18": " Rewari",
    " 19": " Rohtak",
    " 20": " Sirsa",
    " 21": " Sonipat",
    " 22": "Yamuna Nagar",
  };
  final Himachal_district = {
    " 1": "Bilaspur",
    " 2": "Chamba",
    "3 ": "Hamirpur",
    " 4": "Kangra",
    " 5": "Kinnaur",
    "6 ": "Kullu",
    " 7": " Lahaul & Spiti",
    " 8": " Mandi",
    "9 ": "Shimla",
    " 10": " Sirmaur (Sirmour)",
    " 11": " Solan",
    " 12": " Una",
  };
  final Jamm_kas_district = {
    " 1": "Anantnag",
    " 2": "Bandipore",
    " 3": "Baramull",
    " 4": "Budgam",
    " 5": "Doda",
    "6 ": "Ganderbal",
    "7 ": "Jammu ",
    " 8": "Kathua",
    " 9": " Kishtwar",
    "10 ": " Kulgam",
    "11 ": "Poonch",
    " 12": " Pulwama",
    "13 ": "Rajouri",
    "14 ": "Ramban",
    " 15": "Reasi",
    "16": "Samba",
    " 17": "Shopian ",
    " 18": "Srinagar ",
    " 19": "Udhampur ",
  };
  final Jharkhand_district = {
    " 1": "Bokaro ",
    " 2": " Chtra",
    "3 ": "Deoghar ",
    " 4": " Dhanbad",
    " 5": "Dumka ",
    " 6": " East Singbhum",
    " 7": "Garhwa ",
    " 8": " Giridih",
    "9 ": "Godda ",
    " 10": "Gumla ",
    " 11": " Hazaribag ",
    " 12": "Jamtara ",
    " 13": " Khunti",
    " 14": " Koderma ",
    " 15": "Latehar ",
    " 16": " Pakur",
    " 17": "Palamu ",
    "18 ": " Ramgarh ",
    " 19": " Ranchi",
    " 20": "Sahibganj ",
    " 21": "Seraikela- Kharsawan ",
    " 22": "Simdega",
    " 23": "West Singhbhum ",
  };
  final karnataka_district = {
    " 1": "Bagalkot",
    "2 ": " Ballari (Bellary)",
    " 3": " Belagavi(Belgaum)",
    " 4": " Bengaluru (Bangalore) Rural ",
    " 5": "Bengaluru(Bangalore) Urban ",
    "6 ": " Bidar",
    " 7": " Chamaraj nagar",
    " 8": " Chikballpur",
    " 9": " Chikkamagaluru ( Chikmagalur)",
    " 10": " Chitradurga",
    " 11": "Dakshina Kannada ",
    " 12": "  Davangere",
    "13 ": " Dharwad",
    " 14": " Gadag",
    " 15": "Hassan ",
    "16 ": " Haveri ",
    " 17": " Kalaburagi (Gulbarga)",
    " 18": "Kolar ",
    " 19": " Koppal",
    " 20": " Mandya",
    " 21": " Mysuru (Mysore) ",
    " 22": "Raichur ",
    " 23": " Ramangara ",
    " 24": "  Shivamogga  (Shimoga)",
    " 25": "Tumakuru (Tumkur) ",
    "26 ": " Udupi",
    " 27": "Utttra Kannada (Karwar)",
    " 28": " Vijayapura (Bijapur)",
    "29 ": " Yadgir ",
  };
  final Kerala_district = {
    "1 ": "Alappuzha ",
    " 2": "Ernakulam ",
    "3 ": "Idukki ",
    " 4": " Kannur",
    " 5": " Kasaragod",
    "6 ": " Kollam",
    "7 ": "Kottayam ",
    " 8": "Kozhikode ",
    "9 ": " Malappuram",
    "10 ": "Palakkad ",
    " 11": " Pathanamthitta ",
    " 12": " Thiruvananthapuram ",
    " 13": " Thrissur",
    "14 ": "Wayanad ",
  };
  final ladakh_dsitrict = {
    "1 ": "Karagil ",
    "2 ": " Leh",
  };
  final Manipur_district = {
    " 1": " Bishnupur",
    " 2": "Chandel ",
    " 3": " Churachandpur",
    " 4": " Imphal East",
    "5 ": "Imphal West ",
    " 6": " Jirribam",
    "7 ": "Kakching ",
    " 8": " Kamjong",
    "9 ": "Kangpokpi ",
    " 10": " Noney ",
    " 11": " Pherzawl ",
    " 12": " Senapati",
    " 13": "Tamenglong ",
    "14 ": " Thoubal",
    "15 ": "Ukhrul ",
  };
  final Meghkjalaya_district = {
    " 1": "East Garo Hills ",
    "2 ": " East Jaintia Hills ",
    "3 ": " East Khasi Hills",
    "4 ": "North Garo Hills ",
    " 5": "Ri Bhoi ",
    " 6": " South Garo Hills",
    " 7": " South West Garo Hills",
    " 8": " South West Khasi",
    " 9": " West Garo Hills ",
    " 10": " West Jaintia Hills",
    " 11": "West Khasi Hills ",
  };
  final Mizoram_district = {
    "1 ": "Aizawl ",
    " 2": "Champhai ",
    " 3": " Kolasib",
    "4 ": " Lawngtlai",
    " 5": " Lunglei",
    " 6": "Mamit ",
    " 7": " Saiha",
    " 8": "Serchhip",
  };
  final mpdistrict = {
    "1": " Agar malwa",
    "2": " Alirajpur",
    "3": "anuppur",
    "4": " Ashoknagar",
    "5": "Balaghat",
    "6": "Barwani",
    "7": "Betul",
    "8": "Bhind",
    "9": "Bhopal",
    "10": "Burhanpur",
    "11": "Chhatarpur",
    "12": "Chhindwara",
    "13": "Damoh",
    "14": "Datia",
    "15": "Dewas",
    "16": " Dhar",
    "17": "Dindori",
    "18": "Guna",
    "19": "Gwalior",
    "20": "Harda",
    "21": "Hoshangabad",
    "22": "Indore",
    "23": "Jabalppur",
    "24": "Jhabua",
    "25": "Katni",
    "26": "Khandwa",
    "27": "Khargone",
    "28": "Madla",
    "29": "Mandsaur",
    "30": "Morena",
    "31": "Narsinghpur",
    "32": "Neemuch",
    "33": "Panna",
    "34": "Raisen",
    "35": "Rajgarh",
    "36": "Ratlam",
    "37": "Rewa",
    "38": "Sagar",
    "39": "Satna",
    "40": "Sehore",
    "41": "Seoni",
    "42": "Shahdol",
    "43": "Shajapur",
    "44": "Sheopur",
    "45": "Shivpuri",
    "46": "Sindhi",
    "47": "Singrauli",
    "48": "Tikamgarh",
    "49": "Ujjain",
    "50": "Umaria",
    "51": "Vidisha",
  };
  final nagaland_district = {
    " 1": " Dimapur ",
    "2 ": "Kiphire ",
    " 3": "Kohima  ",
    " 4": " Longleng",
    " 5": " Mokokchung ",
    " 6": " Mon",
    " 7": " Peren",
    " 8": "Phek ",
    " 9": "Tuensang ",
    " 10": " Wokha",
    " 11": " Zunheboto",
  };
  final odisha_dis = {
    " 1": "Angul ",
    " 2": "Balangir ",
    "3 ": "Balasore ",
    "4 ": " Bargarh ",
    " 5": "Bhadrak ",
    "6 ": " Boudh",
    "7 ": " Cuttack",
    " 8": "Deogarh ",
    "9 ": "Dhenkanal ",
    " 10": " Gagapati",
    " 11": "Ganjam ",
    "12 ": "Jagatsinghapur ",
    " 13": "Jajpur ",
    " 14": " Jharsuguda",
    "15": " Kalhandi",
    " 16 ": "Kendrapara",
    " 17": " Kendrulhar (Keonjhar)",
    "18 ": "Koraput ",
    "19 ": "Malkangiri ",
    " 20": "Mayurbhanj ",
    " 21": "Nabarangpur ",
    " 22": "Nayagarh ",
    " 23": " Nuapada",
    " 24": "Puri ",
    " 25": "  Rayagada",
    " 26": "Sambalpur ",
    " 27": " Sonepur",
    "28 ": "Sundargarh ",
  };

  final pundu_dist = {
    "1 ": "Karaikal ",
    "2 ": " Mahe",
    "3 ": "Puducherry ",
    "4 ": "Yanam ",
  };
  final Punjab_dist = {
    " 1": "Amritsar ",
    "2 ": " Baranla",
    " 3": " Bathindra",
    "4 ": "  Faridkot",
    "5 ": "Fatehgarh Sahib ",
    " 6": "Faztlka ",
    " 7": "Ferozepur ",
    " 8": " Gurdaspur",
    "9 ": "Hoshiarpur ",
    " 10": " Jalandahr",
    " 11": " Kapurthala ",
    "12 ": "Ludhiana ",
    " 13": " Mansa",
    "14 ": " Muktsar",
    "15 ": " Nawansharhr (Shahid Bhagat Singh Nagar )",
    " 16": "Pathankot ",
    " 17": "Patiala ",
    " 18": "  Rupnagar",
    "19 ": " Sahibzada Ajit Singh Nagar (Mohali) ",
    " 20": "Sangrur ",
    " 21": "Tarn Taran ",
  };
  final Sikkim_dist = {
    "1 ": "East Sikkim ",
    " 2": " North Sikkim",
    "3 ": " South Sikkim ",
    " 4": " West Sikkim",
  };
  final tamil_dist = {
    " 1": "Ariyalur ",
    " 2": " Chengalpattu",
    " 3": "Chennai ",
    "4 ": " Coimbatore",
    " 5": "Cuddalore ",
    " 6": "Dindiguli ",
    " 7": " Erode",
    " 8": " Kallakurichi ",
    " 9": " Kanchipuram",
    "10 ": " Kanyakumari",
    " 11": " Karur ",
    " 12": "Krishnagiri ",
    " 13": " Mandurai ",
    " 14": " Nagapattinam ",
    " 15": "  Namakkal",
    " 16": " Nilgiris",
    " 17": " Penambalur ",
    " 18": "  Pudukkottai",
    "19 ": " Ramanathapuram ",
    "20 ": " Ranipet",
    " 21": " Salem",
    " 22": " Sivaganga ",
    " 23": " Tenkasi ",
    "24 ": "  Thanjavur",
    " 25": "  Theni",
    " 26": "Thoothukudi (Tuticorin) ",
    " 28": " Tiruchirappalli",
    "29 ": " Tirunelveli",
    " 30": "  Tirupathur",
    " 31": "  Tiruvannamalai",
    " 32": " Tiruvarur",
    " 33": "Vellore ",
    "34 ": " Viluppuram ",
    " 35": " Virudhu nagar ",
  };
  final telagan_dist = {
    " 1": "Adilabad ",
  };
  final Chhatishgarh_district = {
    "1": "Balod",
    "2": "Baloda Bazar",
    "3": "Balrampur",
    "4": " Bastar",
    "5": "Bemetara",
    "6": "Bijapur",
    "7": "Bilaspur",
    "8": "Dantewada(south Bastar)",
    "9": "Dhamtari",
    "10": "Durg",
    "11": "Gariyabanda",
    "12": "Janjgir- Champa",
    "13": "Jashpur",
    "14": "Kabirdham(Kawardha)",
    "15": " Kanker(North Baster)",
    "16": "Korba",
    "17": "Korea(Koriya)",
    "18": "Mahasamund",
    "19": "Mungeli",
    "20": "Narayanpur",
    "21": "Raigarh",
    "22": "Rajnandgoan",
    "23": "Sukma",
    "24": "Surajpur",
    "25": "Surguja",
  };

  final Maharath_district = {
    "1": "Ahmed Nagar",
    "2": "Akola",
    "3": "Amravati",
    "4": "Aurangabad",
    "5": "Beed",
    "6": "Bhandara",
    "7": "Buldhana",
    "8": " Chandrapur",
    "9": "Dhule",
    "10": " Gadchiroli",
    "11": "Gondia",
    "12": "Hingoli",
    "13": "Jalgaon",
    "14": "Jalna",
    "15": "Kolhapur",
    "16": "Latur",
    "17": "Mumbai city",
    "18": "Mumbai Suburban",
    "19": "Nagpur",
    "20": " Nanded",
    "21": "Nandurbar",
    "22": "Nashik",
    "23": " Osmanabad",
    "24": " Palghar",
    "25": " Pune",
    "26": "Raigad",
    "27": "Ratnagiri",
    "28": " Sangli",
    "29": " Satara",
    "30": " Sindhudurg",
    "31": " Solapur",
    "32": "Thane",
    "33": "Wardha",
    "34": "Washim",
    " 35": " Yavatmal",
  };
  final rajshthandistrict = {
    "1": "Ajmer",
    "2": "Alwar",
    "3": "Banswara",
    "4": "Baran",
    "5": "Barmer",
    "6": "bharatpur",
    "7": "Bhilwara",
    "8": "Bikaner",
    "9": "Bundi",
    "10": " Chittorgar",
    "11": "Churu",
    "12": "Dausa",
    "13": " Dholpur",
    "14": "Dungapur",
    "15": "Hanumangarh",
    "16": " Jaipur",
    "17": "Jaisalmer",
    "18": "Jalor",
    "19": "Jhalawar",
    "20": "Jhunjhunu",
    "21": "Jodhpur",
    "22": "Karauli",
    "23": "Kota",
    "24": "Nagaur",
    "25": "Pali",
    "26": "Pratapgarh",
    "27": "Rajsamand",
    "28": "Sawai Mandhorpur",
    "29": " Sikar",
    "30": "Sirohi",
    "31": "Sri Ganganagar",
    "32": "Tonk",
    "33": "Udaipur",
  };

  final UPdistrict = {
    "1": "Agra",
    "2": "Aligarh",
    "3": "Ambedkar Nagar",
    "4": " Amethi",
    "5": "Amroha",
    "6": "Auraiya",
    "7": "Ayodhya",
    "8": " Azamgarh",
    "9": "Baghpat",
    "10": "Bahriach",
    "11": "Ballia",
    "12": "Balrampur",
    "13": "Banda",
    "14": "Barabanki",
    "15": "Bareilly",
    "16": "Basti",
    "17": "Bhadohi",
    "18": "Bijnor",
    "19": "Bulandshahr",
    "20": "Chandauli",
    "21": "Chhitrakoot",
    "22": "Deoria",
    "23": "Etah",
    "24": "Etawah",
    "25": "Farukkabad",
    "26": "Fatehpur",
    "27": "Firozabad",
    "28": "Gautam Buddha Nagar",
    "29": "Ghaziabad",
    "30": "Ghazipur",
    "31": "Gonda",
    "32": "Gorakpur",
    "33": "Hamipur",
    "34": "Hapur",
    "35": "Hardoi",
    "36": "Hathras",
    "37": "Jalaun",
    "38": "Jaunpur",
    "39": "Jhansi",
    "40": "Kannauj",
    "41": "Kanpur Nagar",
    "42": "Kanpur Dehat",
    "43": "Kasganj",
    "44": "Kaushambi",
    "45": "Kushi Nagar",
    "46": "Lakhimpur Kheri",
    "47": " Lalitpur",
    "48": "Lucknow",
    "49": "Maharajganj",
    "50": "Mahoba",
    "51": "Mainpuri",
    "52": "Mathura",
    "53": "Mau",
    "54": "Meerut",
    "55": "Mirzapur",
    "56": "Moradabad",
    "57": "Muzaffar Nagar",
    "58": "Pilibhit",
    "59": "pratapgarh",
    "60": "Prayagraj",
    "61": "Raebareli",
    "62": "Rampur",
    "63": "Saharanpur",
    "64": "Sambhal",
    "65": "Shravasti",
    "66": " Siddharth Nagar",
    "67": "Sitapur",
    "68": "Sonbhadra",
    "69": "sultanpur",
    "70": "Unnao",
    "71": " Varansi",
  };

  List<DropdownMenuItem<String>> Country_list = List();
  void Country_load() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in contries.keys) {
      Country_list.add(
        DropdownMenuItem<String>(
          child: Text(contries[key]),
          value: contries[key],
        ),
      );
    }
  }

  List<DropdownMenuItem<String>> StatList = List();

  //List<DropdownMenuItem<String>> statelist = List();

  void State_load() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in MPState.keys) {
      StatList.add(
        DropdownMenuItem<String>(
          child: Text(MPState[key]),
          value: MPState[key],
        ),
      );
    }
  }

  void Adnra_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Andhra_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Andhra_district[key]),
          value: Andhra_district[key],
        ),
      );
    }
  }

  void Arunchal_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Arunchal_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Arunchal_district[key]),
          value: Arunchal_district[key],
        ),
      );
    }
  }

  void Adman_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Andaman_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Andaman_district[key]),
          value: Andaman_district[key],
        ),
      );
    }
  }

  void Assam_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in asssam_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(asssam_district[key]),
          value: asssam_district[key],
        ),
      );
    }
  }

  void chaatish_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Chhatishgarh_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Chhatishgarh_district[key]),
          value: Chhatishgarh_district[key],
        ),
      );
    }
  }

  void Dehli_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Delhi_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Delhi_district[key]),
          value: Delhi_district[key],
        ),
      );
    }
  }

  void goa_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in goa_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(goa_district[key]),
          value: goa_district[key],
        ),
      );
    }
  }

  void Gujrat_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in gujrat_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(gujrat_district[key]),
          value: gujrat_district[key],
        ),
      );
    }
  }

  void himachal_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Himachal_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Himachal_district[key]),
          value: Himachal_district[key],
        ),
      );
    }
  }

  void Haryna_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Haryan_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Haryan_district[key]),
          value: Haryan_district[key],
        ),
      );
    }
  }

  void jammu__dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Jamm_kas_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Jamm_kas_district[key]),
          value: Jamm_kas_district[key],
        ),
      );
    }
  }

  void Jharkand_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Jharkhand_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Jharkhand_district[key]),
          value: Jharkhand_district[key],
        ),
      );
    }
  }

  void kernatka_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in karnataka_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(karnataka_district[key]),
          value: karnataka_district[key],
        ),
      );
    }
  }

  void kerla_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Kerala_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Kerala_district[key]),
          value: Kerala_district[key],
        ),
      );
    }
  }

  void Ladakh_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in ladakh_dsitrict.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(ladakh_dsitrict[key]),
          value: ladakh_dsitrict[key],
        ),
      );
    }
  }

  void mp_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in mpdistrict.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(mpdistrict[key]),
          value: mpdistrict[key],
        ),
      );
    }
  }

  void maharat_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Maharath_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Maharath_district[key]),
          value: Maharath_district[key],
        ),
      );
    }
  }

  void Mishoram_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Mizoram_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Mizoram_district[key]),
          value: Mizoram_district[key],
        ),
      );
    }
  }

  void Manipur_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Manipur_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Manipur_district[key]),
          value: Manipur_district[key],
        ),
      );
    }
  }

  void Maghlaya_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Meghkjalaya_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Meghkjalaya_district[key]),
          value: Meghkjalaya_district[key],
        ),
      );
    }
  }

  void naga_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in nagaland_district.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(nagaland_district[key]),
          value: nagaland_district[key],
        ),
      );
    }
  }

  void Oddisha_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in odisha_dis.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(odisha_dis[key]),
          value: odisha_dis[key],
        ),
      );
    }
  }

  void pandu_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in pundu_dist.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(pundu_dist[key]),
          value: pundu_dist[key],
        ),
      );
    }
  }

  void panjab_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Punjab_dist.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Punjab_dist[key]),
          value: Punjab_dist[key],
        ),
      );
    }
  }

  void Rajeshtahn_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in rajshthandistrict.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(rajshthandistrict[key]),
          value: rajshthandistrict[key],
        ),
      );
    }
  }

  void Sikkim_district() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in Sikkim_dist.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(Sikkim_dist[key]),
          value: Sikkim_dist[key],
        ),
      );
    }
  }

  void tamilnadu_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in tamil_dist.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(tamil_dist[key]),
          value: tamil_dist[key],
        ),
      );
    }
  }

  void telgarna_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in telagan_dist.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(telagan_dist[key]),
          value: telagan_dist[key],
        ),
      );
    }
  }

  void up_dist() {
    /// DatabaseReference df= FirebaseDatabase.instance.reference();
    ///
    for (String key in UPdistrict.keys) {
      districtlist.add(
        DropdownMenuItem<String>(
          child: Text(UPdistrict[key]),
          value: UPdistrict[key],
        ),
      );
    }
  }

  bool d_disabledropdown = false;
  bool s_disabledropdown = false;
  @override
  void Countrychange(_value) {
    if (_value == "India") {
      StatList = [];
      State_load();
    } else {
      Text("select country");
    }
    setState(() {
      Dropcountry = _value;
      s_disabledropdown = true;
    });
  }

  @override
  void StateChange(_value) {
    if (_value == 'Andaman and Nicobar Islands') {
      districtlist = [];
      Adman_dist();
    }

    if (_value == 'Andhra Pradesh ') {
      districtlist = [];
      Adnra_dist();
    }
    if (_value == 'Arunachal Pradesh') {
      districtlist = [];
      Arunchal_dist();
    }

    if (_value == 'Assam') {
      districtlist = [];
      Assam_dist();
    }
    if (_value == ' Chandigarh') {
      districtlist = [];
      chaatish_dist();
    }
    if (_value == 'Delhi-NCR') {
      districtlist = [];
      Dehli_dist();
    }
    if (_value == 'Goa') {
      districtlist = [];
      goa_dist();
    }
    if (_value == 'Gujarat ') {
      districtlist = [];
      Gujrat_dist();
    }
    if (_value == 'Jharkhand') {
      districtlist = [];
      Jharkand_dist();
    }

    if (_value == ' Jammu and Kashmir') {
      districtlist = [];
      jammu__dist();
    }
    if (_value == 'Himachal Pradesh ') {
      districtlist = [];
      himachal_dist();
    }
    if (_value == ' Haryana') {
      districtlist = [];
      Haryna_dist();
    }

    if (_value == 'Karnataka') {
      districtlist = [];
      kernatka_dist();
    }
    if (_value == 'Kerala') {
      districtlist = [];
      kerla_dist();
    }
    if (_value == 'Ladakh') {
      districtlist = [];
    }

    if (_value == "Madhya Pradesh") {
      districtlist = [];
      mp_dist();
    }
    if (_value == 'Maharashtra ') {
      districtlist = [];
      maharat_dist();
    }
    if (_value == ' Manipur') {
      districtlist = [];
      Manipur_dist();
    }

    if (_value == 'Meghalaya') {
      districtlist = [];
      Maghlaya_dist();
    }
    if (_value == ' Mizoram') {
      districtlist = [];
      Mishoram_dist();
    }
    if (_value == 'Nagaland') {
      districtlist = [];
      naga_dist();
    }

    if (_value == ' Odisha') {
      districtlist = [];
      Oddisha_dist();
    }
    if (_value == ' Pondicherry') {
      districtlist = [];
      pandu_dist();
    }
    if (_value == ' Punjab') {
      districtlist = [];
      panjab_dist();
    }
    if (_value == 'Rajasthan') {
      districtlist = [];
      Rajeshtahn_dist();
    }

    if (_value == ' Sikkim') {
      districtlist = [];
      Sikkim_district();
    }
    if (_value == ' Tamil Nadu') {
      districtlist = [];
      tamilnadu_dist();
    }
    if (_value == ' Telangana') {
      districtlist = [];
      telgarna_dist();
    }
    if (_value == 'UP') {
      districtlist = [];
      up_dist();
    } else {
      Text("Select state");
    }

    setState(() {
      _state = _value;
      d_disabledropdown = true;
    });
  }

  @override
  void DistrictValue(_value) {
    setState(() {
      district = _value;
    });
  }

  LocationData _currentPosition;
  GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(23.593750, 77.0965629);
  String _address, _dateTime;
  List data;
  Location location = Location();

  Driver_service_agrement(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'Driver Service Agreement ',
            style: TextStyle(
              color: Color(0xff3B9412),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Text(
                "SERVICES DESCRIPTION:Indian Drivers provides a technology based service which enables the hiring of drivers by commuters/ passengers for a point to point pick up and drop off Service, within city limits and outside city limits, through the Application in mobile telecommunications devices and through the Website. The Service is designed to offer you information and a means of obtaining short-term private driver solutions to coordinate point-to-point and round trip private driver services, at your request. As a User, you authorize Indian Drivers to operate your vehicle and make decisions on your behalf during a period of time designated by you.USE OF SERVICE, APPLICATION AND WEBSITE:The Application and the Website allows you to send a request for Service to a Driver. The GPS receiver, which should be installed on the mobile device (smart phone) on which you have downloaded the Application or the Website, shall detect your location and shall send your location information to the relevant Driver. Indian Drivers has sole and complete discretion to accept or reject each request for providing the Service. Indian Drivers also has sole and complete discretion over whether to use the Application/Website to receive the leads generated through the Application/Website. If Indian Drivers accepts a request, the Application/Website notifies you and provides information regarding the Driver – including his name and the ability to contact the Driver by telephone or a message. The Application/Website also allow you to view the Driver’s progress towards the pick-up point, in real time.Indian Drivers shall undertake commercially reasonable efforts to bring you into contact with a Driver in order to avail the Services, subject to the availability of Drivers in or around your location at the moment of your request for the Services.Indian Drivers itself does not provide transportation services. It is up to the User to offer transportation. Indian Drivers only acts as intermediary between the Driver and you. The provision of the Services by the Driver to you is, therefore, subject to the agreement (to be) entered into between the Driver and you. Indian Drivers shall under no circumstance be a party to such agreement. Indian Drivers disclaims any and all liability in respect of the Drivers including any claims of employment or any vicarious liability arising out of the Service or otherwise."
                "3.USE OF SERVICE, APPLICATION AND WEBSITE:"
                "User means any individual or business entity/organization that legally operates in India or in other countries, and uses and has the right to use the Services provided by Indian Drivers. Our Services are available only to those individuals or entities who can execute legally binding contracts under the applicable law. Therefore, a User must not be a minor as per Indian Law; i.e. User(s) must be at least 18 years of age to be eligible to use our Services."
                "Indian Drivers advises its Users that while accessing the Website/Application, they must follow/abide by the applicable laws. Indian Drivers may, in its sole discretion, refuse the Service to anyone at any time."
                "This Agreement applies to all Services offered on the Website/Application, collectively with any additional terms and condition that may be applicable."
                "4.REGISTRATION:"
                "To use the Services, you have to be registered and provide your name, contact number, email address and other details. Please see our Privacy Policy and practices to know more about how your personal information would be used."
                "5. REPRESENTATIONS AND WARRANTIES:"
                " The information you provide to Indian Drivers is accurate and complete. Indian Drivers service is only available for private cars for non-commercial purposes within the city limits as designated on our Website. Private cars for non-commercial purposes bear license plates with black lettering over white colored background (Commercial vehicles have license plates with black lettering over yellow colored background). You will ensure that Indian Drivers service is being utilized only for non-commercial purposes in a private car. Indian Drivers is entitled, at all times, to verify the information that you have provided and to refuse the Service or use of the Application/Website without providing reasons."
                "You will only access the Service using authorized means. You are responsible to check and ensure you download the correct Application for your device or the correct Website in your computer. Indian Drivers shall not be liable if you do not have a compatible mobile device or if you download the wrong version of the Application for your mobile device or Website for the computer. Indian Drivers reserves the right to terminate the Service and the use of the Application/ Website should you use the Service or Application with an incompatible or unauthorized device."
                " You have the legal right and authority to possess and operate the vehicle when engaging our Services and you confirm, represent and warrant that the said vehicle is in good operating condition and meets the industry safety standards and all applicable statutory requirements for a motor vehicle of its kind."
                " You will be solely responsible for any and all liability which results from or is alleged as a result of the condition of your vehicle, legal compliance, etc., including, but not limited to, personal injuries, death and property damages."
                "You will be solely responsible for the full functionality of your vehicle. If your vehicle fails to function (electrical, mechanical or other) in any way while the Services are being availed of by you, you will be responsible for all storage fees, roadside assistance, alternate transportation and repair of any kind and neither Indian Drivers/ID Car Drivers Pvt Ltd nor the Driver shall be responsible in any manner whatsoever. You have the legal right to designate the Driver as your agent and delegate actual authority to the Driver to operate your vehicle and make decisions on your behalf for the purposes of providing Services offered through the Indian Drivers platform."
                " You are named or scheduled on the insurance policy covering the vehicle you use when engaging our Services."
                " You have a valid policy of liability insurance (in coverage amounts consistent with all applicable legal requirements) for the operation of your vehicle to cover any anticipated losses related to your participation in the Services or the operation of your vehicle by the Driver. In the event of a motor vehicle accident you will be solely responsible for compliance with any applicable statutory or department of motor vehicles requirements and for all necessary contacts with your insurance provider. Other than any personal criminal liability attaching to the Driver you will be solely responsible for all consequences arising out of the use of the Service or the Driver. In any event Indian Drivers shall have no responsibility or liability on this account whatsoever."
                " You specifically authorize us to use, store or otherwise process your ‘Sensitive personal data or information’ (as such term is defined in Information Technology (Reasonable security practices and procedures and sensitive personal data or information) Rules, 2011) in order to provide the Services to you. Subject to applicable law all information provided to us by you shall be deemed to be our information to use as we desire."
                "You will obey all applicable laws related to the matters set forth herein, and will be solely responsible for any violations of the same."
                " 6. METER START AND CANCELLATION POLICY:"
                " Indian Drivers drivers will wait no more than 15 minutes from the requested trip start time, before they start the trip timer."
                " You may cancel the booking within 30 minutes prior to the time of journey, without any cancellation charges for all Services. The customer is liable for Rs100/- charge if the trip is cancelled thereafter."
                " 7. LIMITATION OF LIABILITY:"
                "The information, recommendations and/or Services provided to you on or through the Website/Application are for general information purposes only and do not constitute advice. Indian Drivers will take reasonable steps to keep the Website/Application and its contents correct and up to date but does not guarantee that the contents of the Website/Application are free of errors, defects, malware and viruses or that the Website/Application are correct, up to date and accurate."
                "Indian Drivers shall not be liable for any damages resulting from the use of, or inability to use, the Website/Application, including damages caused by malware, viruses or any incorrectness or incompleteness of the information on the Website/Application."
                "Indian Drivers shall further not be liable for damages resulting from the use of, or the inability to use, electronic means of communication with the Website/Application, including — but not limited to — damages resulting from failure or delay in delivery of electronic communications, interception or manipulation of electronic communications by third parties or by computer programs used for electronic communications and transmission of viruses."
                "Without prejudice to the foregoing, and insofar as allowed under mandatory applicable law, Indian Drivers’ aggregate liability shall in no event exceed the equivalent of the amount for the payment of the Services."
                "The quality of the Services requested through the use of the Application is entirely the responsibility of the Driver who ultimately provides such transportation services to you. Indian Drivers under no circumstance accepts liability in connection with and/or arising from the Services provided by the Driver or any acts, actions, behavior, conduct, and/or negligence on the part of the Driver."
                " We shall not be held liable for any failure or delay in performing Services where such failure arises as a result of any act or omission, which is outside our reasonable control such as unprecedented circumstances, overwhelming and unpreventable events caused directly and exclusively by forces of nature that can be neither anticipated, nor controlled, nor prevented by the exercise of prudence, diligence, and care, including but not limited to: war, riot, civil commotion; compliance with any law or governmental order, rule, regulation or direction and acts of third parties ( “Force Majeure” )."
                "If we have contracted to provide identical or similar Service to more than one User and are prevented from fully meeting our obligations to you by reason of an event of Force Majeure, we may decide at our absolute discretion which booking we will fulfill by providing the Service, and to what extent."
                "We have taken all reasonable steps to prevent internet fraud and ensure any data collected from you is stored as securely and safely as possible. However, we shall not be held liable in the unlikely event of a breach in our secure computer servers or those of third parties other than as required under applicable law."
                "In the event we have a reasonable belief that there exists an abuse of vouchers and/or discount codes or suspect an instance of fraud, we may cause the User to be blocked immediately and reserve the right to refuse future Service. Additionally, should there exist an abuse of vouchers or discount codes, Indian Drivers reserves the right to seek compensation from any and all such Users."
                "Indian Drivers does not represent or endorse the accuracy or reliability of any information, or advertisements (collectively, the “Content”) contained on, distributed through, or linked, downloaded or accessed from or contained on the Website/Application, or the quality of any products, information or other materials displayed, or obtained by you as a result of an advertisement or any other information or offer in or in connection with the Service."
                " Offers are subject to Indian Drivers’s discretion and may be withdrawn at any time and without notice."
                "8. INTELLECTUAL PROPERTY RIGHTS:"
                "Indian Drivers is the sole owner or lawful licensee of all the rights to the Website/Application and its content. Website/Application content means its design, layout, text, images, graphics, sound, video etc. The Website/Application content embodies trade secrets and intellectual property rights protected under worldwide copyright and other laws. All title, ownership and intellectual property rights in the Website/Application and its content shall remain with Indian Drivers."
                " All rights, not otherwise claimed under this Agreement or in the Website/Application, are hereby reserved. The information contained in this Website/Application is intended, solely to provide general information for the personal use of the reader, who accepts full responsibility for its use."
                " You may access the Website/Application, avail of the features, facilities and Services for your personal or internal requirements only. You are not entitled to duplicate, distribute, create derivative works of, display, or commercially exploit the Website/Application Content, features or facilities, directly or indirectly, without our prior written permission of Indian Drivers."
                "Copyright"
                "All content on this Website/Application is the copyright of Indian Drivers except the third party content and link to third party website on our Website/Application, if any."
                "Systematic retrieval of Indian Drivers content to create or compile, directly or indirectly, a collection, compilation, database or directory (whether through robots, spiders, automatic devices or manual processes) without written permission from Indian Drivers is prohibited."
                "In addition, use of the content for any purpose not expressly permitted in this Terms of Use is prohibited and may invite legal action. As a condition of your access to and use of Services, you agree that you will not use the Website/Application to infringe the intellectual property rights of others in any way. Indian Drivers reserves the right to terminate the account of a User upon any infringement of the rights of others in conjunction with use of the Service, or if Indian Drivers believes that User’s conduct is harmful to the interests of Indian Drivers, its affiliates, or other Users, or for any other reason in Indian Drivers’ sole discretion, with or without cause."
                ""
                "9. USER ACCOUNTS, OFFERS AND PROMOTIONS:"
                "Indian Drivers reserves the right to collect User data including name, contact information and other details to facilitate Services or use of its platform to avail Services. All information collected from the User are on a bona fide basis. Misuse and misrepresentation of identity or contact details will lead to automatic termination of Services or the use of the platform, without prior notice to such Users."
                "User accounts bearing contact number and email IDs are created and owned by Indian Drivers. Any promotional discounts and offers accumulated can be revoked without prior notice in the event of suspicious account activity or mala fide intent of the User."
                "In the case where the system is unable to establish unique identity of a User against a valid mobile number or e-mail ID, the account shall be indefinitely suspended. Indian Drivers reserves the full discretion to suspend a User’s account in the above event and does not have the liability to share any account information whatsoever."
                "10. LINKS TO THIRD PARTY SITES:"
                "Links to third party sites are provided by the Application/Website as a convenience to Users and Indian Drivers does not have any control over such sites i.e., content and resources provided by them."
                "Indian Drivers may allow Users access to content, products or services offered by third parties through hyperlinks (in the form of word link, banners, channels or otherwise) to such third party’s website. You are cautioned to read such sites’ terms and conditions and/or privacy policies before using such sites in order to be aware of the terms and conditions of your use of such sites. The Users acknowledge that Indian Drivers has no control over such third party’s site, does not monitor such sites, and Indian Drivers shall not be responsible or liable to anyone for such third party site, or any content, products or services made available on such a site."
                "11. TERMINATION:"
                "Indian Drivers reserves the right to deny access to particular Users to any/all of its Services without any prior notice/explanation in order to protect the interests of Indian Drivers and/or other Users to the Website/Application. Indian Drivers reserves the right to limit, deny or create different access to the Website/Application and its features with respect to different Users."
                "We reserve the right to terminate your account or your access to the Website/Application immediately, with or without notice to you, and without liability: (i) if you have violated any of the Terms of Use; (ii) if you have furnished us with false or misleading information; (iii) pursuant to requests by law enforcement or other government agencies; (iv) in case of unexpected technical or security issues or problems; (v) in case of discontinuance or material modification to the Services (or any part thereof); and/or (vi) in case of interference with use of our Website/Application by others."
                "In the event of termination by you or us, your account will be disabled and you will not be granted access to your account or any information or content contained in your account. You will not and not attempt to create another account for accessing and using the Website/Application without the written consent of Indian Drivers."
                "This Terms of Use shall remain in full force and effect while you have an account with us. Even after termination of your account with us, certain provisions of this Terms of Use will remain in effect, including but not limited to, Intellectual Property Rights, Prohibited Uses and Indemnification. You agree that we will not be liable to you or any third party for taking any of these actions."
                "Notwithstanding the termination of this Agreement, you shall continue to be bound by the terms of this Agreement in respect of your prior use of this Website/Application and all matters connected with, relating to or arising from such use."
                "Terms & Conditions for use of Services:"
                "The following terms & conditions shall apply to Users utilizing the Services offered by Indian Drivers:"
                "The User shall pay the driver fare (as displayed in the Indian Drivers App) or as agreed to in the terms of use as listed on the Application/Website, parking charges, additional night surcharge (where applicable), one way trips, toll charges and any fee or levy presently payable or hereinafter imposed by the law or required to be paid for availing of the Services."
                "The User agrees and accepts that the use of the Services provided by Indian Drivers is at the sole risk of the User, and further acknowledges that Indian Drivers disclaims all representations and warranties of any kind, whether express or implied. All Services are provided “AS IS”."
                "The Indian Drivers or the Driver has the right to refuse the Service in the following circumstances:"
                "if the User is found to be in an intoxicated state or is found misbehaving with other passengers or the Driver, or is causing a nuisance;"
                "if the User is misusing, soiling or damaging any of the devices (technical/non-technical) of the Driver; and"
                "if the User asks the Driver to break any traffic/RTO/city police and/or government rules for any purpose The Driver has the right to refuse such a request by the User."
                "Without prejudice to the above, Indian Drivers makes no representation or warranty that:"
                "11. the Services will meet the User’s requirements; and"
                "11. the Services will be uninterrupted, timely, secure, or error-free."
                "The information on this Website/Application is provided “AS IS” with no guarantee of completeness, accuracy, timeliness or of the results obtained from the use of this information, and without warranty of any kind, express or implied, including, but not limited to warranties of performance, merchantability and fitness for a particular purpose. Nothing herein shall to any extent substitute for the independent investigations and the sound technical and business judgment of the Users. In no event shall Indian Drivers be liable for any direct, indirect, incidental, punitive, or consequential damages of any kind whatsoever with respect to the Service. Users of this site must hereby acknowledge that any reliance upon any content shall be at their sole risk."
                "If any User misses his/her train or flight or bus, Indian Drivers will not be liable for any compensation."
                "Indian Drivers is hereby authorized to use the location based information provided by any of the telecommunication companies when the User uses the mobile phone to make a booking. The location based information will be used only to facilitate and improve the probability of locating a Driver for the User."
                "Indian Drivers shall be entitled to disclose to any government body the particulars of the User in the possession, in its absolute discretion."
                "Indian Drivers shall be entitled at any time without giving any reason to terminate the booking of Drivers done by the User."
                "If the User has any complaints in respect of the Services or the use of the Driver, the User has to inform Indian Drivers of the same in writing within 24 hours of using the Driver or the Services."
                "Indian Drivers shall not be liable for any conduct of the Drivers. However, Indian Drivers encourages you to notify it of any complaints that you may have against any Driver or the Services."
                "INSURANCE AND DAMAGE TO PROPERTY:"
                "We do not procure insurance for, nor are we responsible for, damage or loss of any personal belongings or intellectual property whilst providing the Services."
                "INDEMNITY:"
                "The User shall defend, indemnify and hold, Indian Drivers, its a ffiliates, its licensors, and each of their officers, directors, other users, employees, attorneys and agents, harmless, from and against any and all claims, costs, damages, losses, liabilities and expenses (including attorneys’ fees and costs) arising out of or in connection with the:"
                "11. violation or breach of the Terms of Use or any applicable law or regulation, whether or not referenced herein;"
                "11. violation of any rights of any third party, including the Driver via the Application and or the Website; and"
                "11. use or misuse of the Application/Website or Service."
                "MISCELLANEOUS"
                "The information contained in this Website/Application is for general information purposes only. The information is provided by Indian Drivers and while we endeavor to keep the information up to date and correct, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the Website/Application or the information, products, services, or related graphics contained on the Website/Application for any purpose. Any reliance you place on such information is, therefore, strictly at your own risk."
                "n no event will we be liable for any loss or damage, including without limitation, indirect or consequential loss or damage, or any loss or damage whatsoever arising from loss of data or profits arising out of, or in connection with, the use of this Website/Application or Service."
                "Every effort is made to keep the Website/Application up and running smoothly. However, Indian Drivers takes no responsibility for, and will not be liable for, the Website/Application being unavailable due to technical issues beyond our control."
                "The above mentioned Terms of Use and the Privacy Policy constitute the entire agreement between the User and Indian Drivers with respect to access to and use of the Website/Application and the Services offered by Indian Drivers, superseding any prior written or oral agreements in relation to the same subject matter herein."
                "JURISDICTION"
                "The courts of Maharashtra, India shall have the sole and exclusive jurisdiction in respect of any matters arising from the use of the Services offered by Indian Drivers or the Terms of Use or any arrangement between Indian Drivers and the User."),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 30, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((20)),
                      child: Container(
                        width: 80,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: //uploading
                              //   ? null
                              () {
                            //   updateProfielData();
                          },
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 80,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((20)),
                      child: Container(
                        width: 60,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  final rate = FirebaseDatabase.instance.reference().child("tbl_cities");
  Widget build(BuildContext context) {
    //if (loading) {
    //return Loading();
    //} else {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: const Color(0xff0d9408)),
        ),
        title: Text(
          S.of(context).add_farm_equipment,
          style: TextStyle(
              fontSize: 18.0,
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => d_home(
                      currentId: v_uid,
                    )));
          },
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Scaffold(
            key: _scafoldKey,
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 10),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        Transform.translate(
                          offset: Offset(38.5, -9.5),
                          child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      const AssetImage('assets/locaiton.png'),
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
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
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
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
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
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2a2e43),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(135.0, 70.0),
                          child: Text(
                            S.of(context).Add_photo,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2a2e43),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(250.0, 70.0),
                          child: Text(
                            S.of(context).Bank_details,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
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
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
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
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
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
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
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
                    height: 45,
                  ),
                  //  TextField(
                  //   controller: name,
                  //   decoration: InputDecoration(
                  //    icon: Icon(
                  //      Icons.person,
                  //    size: 30,
                  //    color: Colors.green.withOpacity(.9),
                  //   ),
                  //  hintText: "Enter name",
                  //  labelText: "Name",
                  //  errorText:
                  //      _displaynameValid ? null : "Display username",
                  //  focusColor: Colors.green,
                  //  ),
                  // ),

                  //  SizedBox(
                  //  height: 5,
                  //),
                  // TextField(
                  //controller: mobile,
                  //keyboardType: TextInputType.number,
                  //decoration: InputDecoration(
                  //hintText: "Enter mobile number",
                  //  icon: Icon(
                  //   Icons.phone_android,
                  //  size: 25,
                  //  color: Colors.green.withOpacity(.9),
                  // ),
                  // labelText: "Mobile",
                  // errorText:
                  //     _mobileValid ? null : "Display Mobile number",
                  // focusColor: Colors.green,
                  // ),
                  // ),
                  //  SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/locaiton.png',
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        child: Text(
                          S.of(context).Add_Current_Location,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Satelite_GoogleMapPage()));
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      /// for state
                      Expanded(
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              hintText: S.of(context).Select_Vehicle_name,
                              errorText: _vehicle_name
                                  ? null
                                  : S.of(context).please_Select_vehicle_name,
                              icon: Icon(
                                Icons.time_to_leave_rounded,
                                size: 20,
                                color: const Color(0xff3B9412),
                              ),
                              labelText: S.of(context).Vehicle_Name),
                          value: vehicle_name,
                          // .isNotEmpty ? vehicle_name : null,
                          isExpanded: true,
                          onChanged: (_value) => valueChange(_value),
                          items: statelist,
                        )),
                      ),
                      // Text("$_mycountry"),
                      SizedBox(
                        width: 20,
                      ),

                      /// for State
                      Expanded(
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              hintText: S.of(context).Company,
                              icon: Icon(
                                Icons.commute_rounded,
                                size: 20,
                                color: const Color(0xff3B9412),
                              ),
                              errorText: _company
                                  ? null
                                  : S.of(context).Please_Select_Company_Name,
                              labelText: S.of(context).Company),
                          value: company
                          //  (company?.isEmpty ?? true)
                          // company.isNotEmpty ? company : null
                          ,
                          isExpanded: true,
                          onChanged: (_value) =>
                              //  disabledropdown ? null :
                              secondvalue(_value),
                          items: vehclilist,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    cursorColor: const Color(0xff3B9412),
                    controller: Authory,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_balance,
                        size: 25,
                        color: const Color(0xff3B9412),
                      ),
                      hintText: S.of(context).Enter_Registration_Authority,
                      hoverColor: Colors.green,
                      labelText: S.of(context).Registration,
                      errorText: _Authority
                          ? null
                          : S.of(context).Display_Registration,
                      fillColor: Colors.green,
                      focusColor: Colors.green,
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: Rc,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.confirmation_num_rounded,
                              size: 20,
                              color: const Color(0xff3B9412),
                            ),
                            hintText: S.of(context).Enter_RC_no,
                            labelText: S.of(context).RC,
                            errorText: _Rc ? null : S.of(context).Display_RC,
                            focusColor: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                        width: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: DateTimeField(
                            format: dateFormat,
                            autocorrect: true,
                            decoration: InputDecoration(
                                errorText:
                                    _datad ? null : S.of(context).Select_Date,
                                icon: Icon(
                                  Icons.date_range,
                                  size: 20,
                                  color: const Color(0xff3B9412),
                                ),
                                hintText: S.of(context).Date,
                                labelText:
                                    // _date != null ?_date :
                                    S.of(context).Date),
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
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now());
                              //.then(
                              //  (DateTime dt) => _datetime.value = dt);
                            },
                            onChanged: (value) {
                              setState(() {
                                _date = (dateFormat.format(value));
                                //  print("Data: $_date");
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: Engine,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.engineering_sharp,
                              size: 20,
                              color: const Color(0xff3B9412),
                            ),
                            hintText: S.of(context).Enter_Engine_Size,
                            labelText: S.of(context).Engine_Size,
                            errorText: _engine
                                ? null
                                : S.of(context).Display_Engine_Size,
                            focusColor: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                        width: 30,
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              hintText: S.of(context).Select_Fuel_type,
                              errorText: _fuelt
                                  ? null
                                  : S.of(context).Please_Select_Fuel_type,
                              icon: Icon(
                                Icons.battery_full,
                                size: 20,
                                color: const Color(0xff3B9412),
                              ),
                              labelText: S.of(context).Fuel),
                          value: Fuel_type,
                          // .isNotEmpty ? vehicle_name : null,
                          isExpanded: true,
                          onChanged: (_value) {
                            Fuel_type = _value;
                          },
                          items: t_fuellist,
                        )),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: village,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_searching_sharp,
                              size: 20,
                              color: const Color(0xff3B9412),
                            ),
                            hintText: S.of(context).Enter_village,
                            labelText: S.of(context).Village,
                            errorText: _vilageValid
                                ? null
                                : S.of(context).Display_Village,
                            focusColor: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: pincode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.my_location,
                              size: 30,
                              color: const Color(0xff3B9412),
                            ),
                            hintText: S.of(context).Enter_pincode,
                            labelText: S.of(context).Pincode,
                            errorText: _pincodeValid
                                ? null
                                : S.of(context).Display_pincode,
                            focusColor: Colors.green,
                          ),
                        ),
                      ),
                      // Expanded(child: Countryload()),
                    ],
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
                            title: Text(S.of(context).I_accept_all,
                                style: TextStyle(fontSize: 14)),
                            activeColor: const Color(0xff179C18),
                            onChanged: (val) {
                              setState(() => _isRadio = !_isRadio);
                              Driver_service_agrement(context);
                            },
                          ),
                        ),
                        //Expanded(
                        //flex: 10,
                        // child: MaterialButton(
                        // onPressed: () {
                        // Driver_service_agrement(context);
                        //     },
                        //   child: Text("Service Terms & conditions",
                        //     style: TextStyle(
                        //       fontSize: 14, color: Color(0xff179C18))),
                        //   ),
                        // ),
                      ],
                    ),

                    //
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //======================================================== City

                  SizedBox(
                    height: 10,
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
                                  width: 95,
                                  height: 35,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular((20)),
                                    child: Container(
                                      width: 50,
                                      height: 45,
                                      child: RaisedButton(
                                        color: Colors.orange.withBlue(50),
                                        onPressed: registationData,
                                        child: Text(
                                          S.of(context).Save,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
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
                            width: 95,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular((20)),
                              child: Container(
                                width: 60,
                                height: 45,
                                child: RaisedButton(
                                  color: const Color(0xff0d9408),
                                  onPressed: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (
                                    context,
                                  ) =>
                                              add_page_3(
                                                ve_id: ve_uid,
                                              ))),
                                  child: Text(
                                    S.of(context).Next,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
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

                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //}
  }

//// Calling api
}

const String _svg_xoomhb =
    '<svg viewBox="6.7 9.0 18.6 14.7" ><path transform="translate(-0.27, -1.01)" d="M 6.999998092651367 10 L 16.31982612609863 24.73828125 L 25.6396484375 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fmod1f =
    '<svg viewBox="18.5 229.5 382.1 596.0" ><path transform="translate(11.16, 270.66)" d="M 19.05419921875 23 L 384.0691528320313 23" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.16, 206.49)" d="M 19.05419921875 23 L 384.0691528320313 23" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.16, 329.03)" d="M 19.05419921875 23 L 384.0691528320313 23" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(18.5, 412.5)" d="M 0 1.583251953125 L 377 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(18.5, 825.5)" d="M 0 0 L 134 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(259.5, 783.5)" d="M 0 0 L 139 2" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(253.5, 823.5)" d="M 0 0 L 147.119873046875 0.26763916015625" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(22.5, 776.5)" d="M 0 0 L 137 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_54ll6o =
    '<svg viewBox="6.3 10.0 19.0 15.6" ><path transform="translate(-0.66, -0.05)" d="M 6.999998092651367 10 L 16.49633979797363 25.63720703125 L 25.99267578125 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3dk63k =
    '<svg viewBox="18.5 37.8 376.0 630.7" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 38.34, 37.89)" d="M 3.120842218399048 15.47452545166016 L 18.12174987792969 0.4736208915710449 C 18.85275840759277 -0.2573871612548828 18.85275650024414 -0.2573843002319336 18.12174606323242 0.4736270904541016 C 17.39073944091797 1.204629898071289 16.20553779602051 2.389833927154541 15.47452926635742 3.120841503143311 L 0.4736242294311523 18.12174224853516 C -0.2573847770690918 18.85275077819824 -0.2573871612548828 18.85275459289551 0.4736220836639404 18.12174415588379 C 1.204633712768555 17.39073371887207 2.389832496643066 16.20553398132324 3.120842218399048 15.47452545166016 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 25.09, 51.04)" d="M 0.5482549667358398 0.5482544898986816 L 15.54916381835938 15.54915904998779 C 16.2801685333252 16.28016471862793 17.46536445617676 17.46535873413086 18.19637870788574 18.19637489318848 C 18.92738914489746 18.9273853302002 18.92738723754883 18.92738151550293 18.19637489318848 18.19637107849121 L 3.195473194122314 3.195473432540894 C 2.464465856552124 2.46446681022644 1.279265761375427 1.279266357421875 0.5482550859451294 0.5482555627822876 C -0.1827515065670013 -0.1827512979507446 -0.1827519237995148 -0.1827520430088043 0.5482549667358398 0.5482544898986816 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(18.5, 465.5)" d="M 0 0 L 375.95458984375 0.261810302734375" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(18.5, 599.5)" d="M 0 1 L 141 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(253.66, 667.85)" d="M 0 0 L 140.8441162109375 0.65472412109375" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_oz21e8 =
    '<svg viewBox="18.5 537.5 380.0 132.0" ><path transform="translate(18.62, 537.5)" d="M 0 0.54779052734375 L 140.880126953125 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(245.5, 538.5)" d="M 0 0 L 149 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(258.5, 598.5)" d="M 0 1 L 140 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(18.5, 668.5)" d="M 0 1 L 139 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jrdh1l =
    '<svg viewBox="45.0 42.9 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 45.0, 42.94)" d="M 4.20775791099004e-07 -4.797473707185418e-08 L 6.222759566298919e-06 4.415016405800998e-07 C 6.505496457975823e-06 4.653539349419589e-07 6.754034529876662e-06 7.138925752769865e-07 6.777886483178008e-06 9.9662952379731e-07 C 6.80174161971081e-06 1.279365733353188e-06 6.591872988792602e-06 1.489232545281993e-06 6.309136097115697e-06 1.465380137233296e-06 L 5.071539135315106e-07 9.759048680280102e-07 C 2.244172065957173e-07 9.520521757622191e-07 -2.412254218597809e-08 7.035131375232595e-07 -4.79748507586919e-08 4.207768142805435e-07 C -7.182758565704717e-08 1.380397236516728e-07 1.380392973260314e-07 -7.182750039191887e-08 4.20775791099004e-07 -4.797473707185418e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 45.0, 42.94)" d="M 8.64104038100777e-07 1.474036480431096e-06 L 6.666084573225817e-06 9.845628028415376e-07 C 6.948821464902721e-06 9.60709485298139e-07 7.158686457842123e-06 1.170576751974295e-06 7.134836778277531e-06 1.453312734156498e-06 C 7.110983915481484e-06 1.736049625833402e-06 6.862444934085943e-06 1.984589061976294e-06 6.579707132914336e-06 2.00844101527764e-06 L 7.777259725116892e-07 2.497916057109251e-06 C 4.949895355821354e-07 2.521769374652649e-06 2.851226668099116e-07 2.311902107976493e-06 3.089753022322839e-07 2.029165216299589e-06 C 3.32827994498075e-07 1.746429461491061e-06 5.813676011712232e-07 1.497889797974494e-06 8.64104038100777e-07 1.474036480431096e-06 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j6tf5o =
    '<svg viewBox="45.0 42.9 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 45.0, 42.94)" d="M 5.111551217851229e-07 4.240882844896987e-08 L 6.313114226941252e-06 5.319093361322302e-07 C 6.595848844881402e-06 5.55762994736142e-07 6.844386916782241e-06 8.043015213843319e-07 6.86824023432564e-06 1.087037048819184e-06 C 6.892095825605793e-06 1.369772121506685e-06 6.68222992317169e-06 1.579637114446086e-06 6.399493940989487e-06 1.555783342155337e-06 L 5.975375074740441e-07 1.066283971340454e-06 C 3.14802036882611e-07 1.042430085362867e-06 6.626234494433447e-08 7.93890990280488e-07 4.24088568706793e-08 5.111560312798247e-07 C 1.855494247138267e-08 2.284200490976218e-07 2.284198217239464e-07 1.855494247138267e-08 5.111551217851229e-07 4.240882844896987e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 45.0, 42.94)" d="M 5.119212573845289e-07 -3.433598649849046e-08 L 6.313876838248689e-06 -5.238338189883507e-07 C 6.59661191093619e-06 -5.476881597132888e-07 6.806475539633539e-06 -3.378230246653402e-07 6.782624041079544e-06 -5.508825395850181e-08 C 6.758769814041443e-06 2.276471349205167e-07 6.510231287393253e-06 4.761862726354593e-07 6.2274948504637e-06 5.000397322874051e-07 L 4.255388432738982e-07 9.895392167891259e-07 C 1.428036711104141e-07 1.013393557514064e-06 -6.706117972044012e-08 8.035285645746626e-07 -4.320741098240433e-08 5.207927529227163e-07 C -1.935351789938977e-08 2.380581634042755e-07 2.291860283776259e-07 -1.048145392701372e-08 5.119212573845289e-07 -3.433598649849046e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3l4kua =
    '<svg viewBox="1.8 34.0 409.1 9.8" ><path transform="translate(2.12, 34.0)" d="M -0.04563090205192566 0 L 408.7761535644531 0 L 408.7761535644531 9.747811317443848 C 408.7761535644531 9.747811317443848 194.5473022460938 10.07676219940186 92.34188079833984 8.599824905395508 C -9.863560676574707 7.122886657714844 -0.04563090205192566 8.599824905395508 -0.04563090205192566 8.599824905395508 L -0.04563090205192566 0 Z" fill="#000000" fill-opacity="0.26" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pk9al0 =
    '<svg viewBox="0.0 0.0 23.4 41.8" ><path transform="translate(0.0, -0.1)" d="M 11.68280029296875 0.1000000536441803 C 18.15327644348145 0.1000000536441803 23.3656005859375 7.82693338394165 23.3656005859375 17.38737678527832 C 23.3656005859375 22.23308563232422 21.5682487487793 27.34071731567383 16.80525970458984 34.2818603515625 L 11.68280029296875 41.87782669067383 L 6.470474720001221 34.2818603515625 C 1.797353863716125 27.20975303649902 -1.111205918391533e-07 22.10211944580078 -1.111205918391533e-07 17.38737678527832 C -1.111205918391533e-07 7.82693338394165 5.212326526641846 0.1000000536441803 11.68280029296875 0.1000000536441803 L 11.68280029296875 0.1000000536441803 Z" fill="#d8772d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_fb6sww =
    '<svg viewBox="7.2 11.2 25.5 16.1" ><path transform="translate(0.2, 1.24)" d="M 6.999998092651367 10 L 19.74188232421875 26.060546875 L 32.48376083374023 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1aze0o =
    '<svg viewBox="18.6 724.5 380.0 6.5" ><path transform="translate(18.61, 729.5)" d="M 0 1.48779296875 L 140 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(258.61, 724.5)" d="M 0 1.48779296875 L 140 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tpn5kt =
    '<svg viewBox="7.1 10.3 25.5 16.1" ><path transform="translate(0.08, 0.27)" d="M 6.999998092651367 10 L 19.74188232421875 26.060546875 L 32.48376083374023 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bferj5 =
    '<svg viewBox="31.6 836.0 90.0 24.0" ><path transform="translate(31.56, 836.04)" d="M 9.579207420349121 0 L 80.42078399658203 0 C 85.71124267578125 0 90 5.37258243560791 90 11.99999904632568 C 90 18.62741661071777 85.71124267578125 23.99999809265137 80.42078399658203 23.99999809265137 L 9.579207420349121 23.99999809265137 C 4.28875732421875 23.99999809265137 0 18.62741661071777 0 11.99999904632568 C 0 5.37258243560791 4.28875732421875 0 9.579207420349121 0 Z" fill="#d6681e" fill-opacity="0.89" stroke="#b95a1a" stroke-width="1" stroke-opacity="0.89" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cyk4xr =
    '<svg viewBox="258.5 834.0 90.0 24.0" ><path transform="translate(258.5, 834.04)" d="M 9.579208374023438 0 L 80.42079162597656 0 C 85.71124267578125 0 90 5.372583389282227 90 12 C 90 18.62741661071777 85.71124267578125 24 80.42079162597656 24 L 9.579208374023438 24 C 4.28875732421875 24 -7.269894020112133e-09 18.62741661071777 -7.269894020112133e-09 12 C -7.269894020112133e-09 5.372583389282227 4.28875732421875 0 9.579208374023438 0 Z" fill="#d6681e" fill-opacity="0.79" stroke="#b95a1a" stroke-width="1" stroke-opacity="0.79" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cydq3p =
    '<svg viewBox="42.3 42.9 340.4 776.3" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 45.0, 42.94)" d="M 5.111551217851229e-07 4.240882844896987e-08 L 6.313114226941252e-06 5.319093361322302e-07 C 6.595848844881402e-06 5.55762994736142e-07 6.844386916782241e-06 8.043015213843319e-07 6.86824023432564e-06 1.087037048819184e-06 C 6.892095825605793e-06 1.369772121506685e-06 6.68222992317169e-06 1.579637114446086e-06 6.399493940989487e-06 1.555783342155337e-06 L 5.975375074740441e-07 1.066283971340454e-06 C 3.14802036882611e-07 1.042430085362867e-06 6.626234494433447e-08 7.93890990280488e-07 4.24088568706793e-08 5.111560312798247e-07 C 1.855494247138267e-08 2.284200490976218e-07 2.284198217239464e-07 1.855494247138267e-08 5.111551217851229e-07 4.240882844896987e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 45.0, 42.94)" d="M 5.119212573845289e-07 -3.433598649849046e-08 L 6.313876838248689e-06 -5.238338189883507e-07 C 6.59661191093619e-06 -5.476881597132888e-07 6.806475539633539e-06 -3.378230246653402e-07 6.782624041079544e-06 -5.508825395850181e-08 C 6.758769814041443e-06 2.276471349205167e-07 6.510231287393253e-06 4.761862726354593e-07 6.2274948504637e-06 5.000397322874051e-07 L 4.255388432738982e-07 9.895392167891259e-07 C 1.428036711104141e-07 1.013393557514064e-06 -6.706117972044012e-08 8.035285645746626e-07 -4.320741098240433e-08 5.207927529227163e-07 C -1.935351789938977e-08 2.380581634042755e-07 2.291860283776259e-07 -1.048145392701372e-08 5.119212573845289e-07 -3.433598649849046e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(257.94, 777.25)" d="M 13.27134990692139 0 L 111.4176025390625 0 C 118.7471694946289 0 124.68896484375 9.397866249084473 124.68896484375 20.99072265625 C 124.68896484375 32.58357620239258 118.7471694946289 41.9814453125 111.4176025390625 41.9814453125 L 13.27134990692139 41.9814453125 C 5.941785335540771 41.9814453125 0 32.58357620239258 0 20.99072265625 C 0 9.397866249084473 5.941785335540771 0 13.27134990692139 0 Z" fill="#d6681e" stroke="#b95a1a" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(42.25, 776.66)" d="M 12.31002521514893 0 L 103.3469467163086 0 C 110.1455917358398 0 115.656982421875 9.030709266662598 115.656982421875 20.170654296875 C 115.656982421875 31.31059646606445 110.1455917358398 40.34130859375 103.3469467163086 40.34130859375 L 12.31002521514893 40.34130859375 C 5.511385440826416 40.34130859375 0 31.31059646606445 0 20.170654296875 C 0 9.030709266662598 5.511385440826416 0 12.31002521514893 0 Z" fill="#d6681e" stroke="#f5f5f5" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_1aek0 =
    '<svg viewBox="23.0 341.1 359.6 367.1" ><path transform="translate(4.66, 49.98)" d="M 19.05419921875 291.158935546875 L 376.9649658203125 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(4.31, 9.45)" d="M 19.05420112609863 450.71044921875 L 159.8538818359375 450.71044921875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(3.95, 327.55)" d="M 19.05420112609863 291.158935546875 L 365.78076171875 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(10.95, 413.45)" d="M 19.05419921875 294.77880859375 L 371.678955078125 294.77880859375" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7y7vtf =
    '<svg viewBox="23.7 400.3 357.9 134.1" ><path transform="translate(4.66, 109.19)" d="M 19.05420303344727 291.158935546875 L 376.9649353027344 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(220.95, 243.29)" d="M 19.05420112609863 291.158935546875 L 160.67919921875 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(4.95, 238.52)" d="M 19.05420303344727 291.158935546875 L 159.05419921875 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bp6h5i =
    '<svg viewBox="-2.6 0.0 18.0 14.4" ><path transform="translate(-9.62, -10.0)" d="M 6.999998092651367 10 L 16.01172065734863 24.43310546875 L 25.02343940734863 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
