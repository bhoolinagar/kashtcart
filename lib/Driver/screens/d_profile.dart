import "dart:async";
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/locator.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/Drivereds/Add_d_page.dart';
import 'package:kisan/Driver/screens/add_page_1.dart';
import 'package:kisan/Driver/screens/d_earn.dart';
import 'package:kisan/Driver/screens/settings.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/loading.dart';
import 'package:kisan/owner/user-controller.dart';

class d_profile extends StatefulWidget {
  String profileId;
  d_profile({this.profileId});
  @override
  D_Profile createState() => D_Profile();
}

class D_Profile extends State<d_profile> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();

  String Dropcountry = "";

  String Dropdistrict = "";
  TextEditingController block = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController pincode = TextEditingController();
  String photoUrl;

  // ignore: non_constant_identifier_names
  String DropState = "";
  bool loading = false;
  bool _displaynameValid = true;
  bool _mobileValid = true;
  bool _contryValid = true;
  bool _districtValid = true;
  bool _stateValid = true;
  bool _blockValid = true;
  bool _vilageValid = true;
  bool _pincodeValid = true;
  bool _photoUrlValid = true;
  var controller;
  User_d user;
  String v_uid;

  bool uploading = false;
  File Image_f;

  bool get wantKeepAlive => true;

  FirebaseAuth Auth = FirebaseAuth.instance;

  final user_ref = FirebaseFirestore.instance.collection("users");
  final uid = (FirebaseAuth.instance.currentUser).uid;

  pickImage_1(ImageSource imageSource) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      Image_f = File(pickedFile.path);
      //imageFile_b = File(pickedFile.path);
    });
  }

  uploadImageAndSaveItemInfo_f(File ImageFe) async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl_f = await uploadItemImage(ImageFe);

    saveItemInfo_f(imageDownloadUrl_f);
  }

  saveItemInfo_f(String ImageFe) async {
    final uid = (await FirebaseAuth.instance.currentUser).uid;

    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "thumbnailUrl": ImageFe,
      //"avatarUrl":
      //   Provid`  er.of<LandingUtils>(context, listen: false).userAvatarUrl
      //  'avatarUrl': avatar.text ,
    });

    setState(() {
      Image_f = null;
      uploading = false;
    });
    SnackBar snackbar = SnackBar(
      content: Text("Profile Updated"),
    );
    _scafoldKey.currentState.showSnackBar(snackbar);
  }

  Future<String> uploadItemImage(mfileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("users");

    final uid = (await FirebaseAuth.instance.currentUser).uid;

    UploadTask uploadTask =
        storageReference.child('$uid.jpg').putFile(mfileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });

    final DocumentSnapshot doc = await user_ref.doc(uid).get();
    Map _docdata = doc.data();
    //final user = Provider.of<User_d>(context);
    final user = User_d.fromDocument(doc, _docdata);
    name.text = user.name;
    mobile.text = user.mobile;
    Dropcountry = user.country;
    DropState = user.state;
    Dropdistrict = user.district;
    block.text = user.block;
    village.text = user.village;
    pincode.text = user.pincode;
    photoUrl = user.avatarUrl;
    v_uid = user.uid;
    setState(() {
      loading = false;
    });
  }

  String holder = ' ';

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
    "206": "Shri Lanka",
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
    "14": "Jharkhand",
    "15": "Karnataka",
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
    "17 ": " Shi Yomi ",
    "18 ": " Siang ",
    " 19": " Tawang ",
    " 20": " Tirap",
    "21 ": " Upper Siang ",
    " 22": " Upper Subaniri",
    " 23": " West Kameng",
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
    " 1": "Bagalkot ",
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

  List<DropdownMenuItem<String>> statelist = List();
  List<DropdownMenuItem<String>> districtlist = List();

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
      DropState = _value;
      d_disabledropdown = true;
    });
  }

  @override
  void DistrictValue(_value) {
    setState(() {
      Dropdistrict = _value;
    });
  }

  final AuthService _auth = AuthService();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  User_d currentUser = locator.get<UserController>().currentUser;

  @override
  void initState() {
    super.initState();
    Country_load();
    getUser();
    State_load();
    //DistrictValue(Dropdistrict);
    mp_dist();
  }

  @override
  int get hashCode => super.hashCode;

  Widget build(BuildContext context) {
    if (Image_f != null) {
      return updatPRofileScreen(Image_f);
    }
    if (Dropcountry != null && DropState != null && Dropdistrict != null) {
      return UpdateUserData(Dropcountry, DropState, Dropdistrict);
    } else {
      return HomeScreen();
    }
  }

  UpdateUserData(String c_drop, String s_drop, String d_drop) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color(0xfffffff),
            body: Scaffold(
              key: _scafoldKey,
              body: ListView(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Container(
                              height: 180,
                              width: 480,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.elliptical(200, 40),
                                      bottomLeft: Radius.elliptical(200, 40)),
                                  color: Color(0xff3B9412)),
                              child: photoUrl == null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Color(0xffffffff),
                                      child: Container(
                                        width: 190.0,
                                        height: 190.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: const AssetImage(
                                                'assets/farmer (2).png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 100, top: 110),
                                          child: MaterialButton(
                                            // heroTag: photoUrl,
                                            onPressed: () => takeImage(context),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  const Color(0xff3B9412),
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
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(photoUrl),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 100, top: 140),
                                        child: MaterialButton(
                                          onPressed: () => takeImage(context),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                const Color(0xff3B9412),
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
                                    )),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 140,
                              width: 330,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 10,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${name.text}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        MaterialButton(
                                          onPressed: () =>
                                              update_farmer(context),
                                          child: Container(
                                              width: 25.0,
                                              height: 25.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: const AssetImage(
                                                      'assets/edit.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Flexible(
                                    flex: 10,
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 66,
                                            width: 80,
                                            child: Image.asset(
                                                'assets/phone.png')),
                                        Text(
                                          "${mobile.text}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 10,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                  'assets/locaiton.png')),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Text(
                                            "${village.text}, ${Dropdistrict} ,${DropState} ,${pincode.text} ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 5, right: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Add_d_page()));
                                },
                                child: Card(
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 70,
                                                width: 140,
                                                child: Image.asset(
                                                    'assets/TC.png')),
                                            Text(S.of(context).My_vehicle,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(S.of(context).Edit_delete,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ))),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => add_page_1()));
                                },
                                child: Card(
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 80,
                                                width: 90,
                                                child: //Image.asset('assets/SV1.png', alignment: AlignmentDirectional.bottomEnd,)

                                                    Icon(
                                                  Icons.add_sharp,
                                                  color: Color(0xfffc850d),
                                                  size: 70,
                                                )),
                                            Text(S.of(context).Add_vehicle,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(height: 10),
                                            Text(S.of(context).New_Equipment,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => d_earn()));
                                },
                                child: Card(
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 70,
                                                width: 90,
                                                child: Image.asset(
                                                    'assets/earn.png')),
                                            Text(S.of(context).My_Earning,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(height: 10),
                                            Text(S.of(context).Total_Earning,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ))),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileHomePage() //image_d()

                                          ));
                                },
                                child: Card(
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 70,
                                                width: 90,
                                                child: Image.asset(
                                                    'assets/share.png')),
                                            Text(S.of(context).Share,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(height: 10),
                                            Text(S.of(context).Refers_Farmer,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Setisa',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ))),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ));
  }

  HomeScreen() {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: Stack(
              children: [
                Scaffold(
                  key: _scafoldKey,
                  body: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 10),
                    child: ListView(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage('assets/TC2.png'),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.orange.withOpacity(.90),
                                borderRadius: BorderRadius.circular(0)),
                            width: 200.0,
                            height: 200.0,
                            child: photoUrl == null
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Color(0xffffffff),
                                    child: Container(
                                      width: 190.0,
                                      height: 190.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: const AssetImage(
                                              'assets/farmer (2).png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 100, top: 110),
                                        child: MaterialButton(
                                          // heroTag: photoUrl,
                                          onPressed: () => takeImage(context),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                const Color(0xff3B9412),
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
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(photoUrl),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 100, top: 140),
                                      child: MaterialButton(
                                        onPressed: () => takeImage(context),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              const Color(0xff3B9412),
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
                                  )),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 90, bottom: 30),
                          child: Text(S.of(context).Driver_Profile,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal,
                                  color: const Color(0xff0d9408),
                                  fontWeight: FontWeight.bold)),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person_rounded,
                              size: 30,
                              color: const Color(0xff3B9412),
                            ),
                            hintText: S.of(context).Enter_name,
                            labelText: S.of(context).Name,
                            errorText: _displaynameValid
                                ? null
                                : S.of(context).Display_username,
                            focusColor: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: mobile,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.stay_primary_portrait,
                              size: 30,
                              color: const Color(0xff3B9412),
                            ),
                            hintText: S.of(context).Enter_mobile_number,
                            labelText: "Mobile",
                            errorText: _mobileValid
                                ? null
                                : S.of(context).Pleas_enter_Mobile_number,
                            focusColor: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 0,
                          width: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.location_on_outlined,
                                      size: 30,
                                      color: Color(0xff0d9408),
                                    ),
                                    hintText: S.of(context).Select_Country,
                                    labelText: S.of(context).Country),

                                value: Dropcountry,
                                //.isNotEmpty ? Dropcountry : null, //
                                isExpanded: true,
                                onChanged: (_value) => s_disabledropdown
                                    ? null
                                    : Countrychange(_value),
                                //(String _value) {
                                //if (_value == "India") {
                                //StatList = [];
                                //State_load();
                                //   } else {
                                //   //});
                                //},
                                items: Country_list,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.location_on,
                                            size: 30,
                                            color: const Color(0xff0d9408),
                                          ),
                                          hintText: S.of(context).Select_State,
                                          labelText: "State"),
                                      value: DropState,
                                      isExpanded: true,
                                      onChanged: (_value) => d_disabledropdown
                                          ? null
                                          : StateChange(_value),
                                      items: StatList)),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Expanded(
                          child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.add_location_alt,
                                  size: 30,
                                  color: Color(0xff3B9412),
                                ),
                                hintText: S.of(context).Select_district,
                                labelText: S.of(context).District),
                            value: //Dropdistrict.isEmpty
                                //? null:
                                Dropdistrict, // null : district,
                            isExpanded: true,
                            onChanged: (_value) =>
                                //  d_disabledropdown ? null :
                                DistrictValue(_value),
                            items: districtlist,
                          )),
                        )
                        // Text("$_mycountry"),
                        //SizedBox(
                        //width: 20,
                        //),
                        ,

                        // Text("$_mycountry"),
                        //SizedBox(
                        //width: 20,
                        //),,

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: block,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_city,
                              size: 30,
                              color: const Color(0xff3B9412),
                            ),
                            labelText: S.of(context).Block,
                            hintText: S.of(context).Enter_block_name,
                            errorText:
                                _blockValid ? null : S.of(context).Enter_block,
                            focusColor: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: village,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_searching_sharp,
                              size: 30,
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

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: pincode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.keyboard_outlined,
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

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 100, top: 30, right: 100),
                          child: Container(
                            width: 30,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular((20)),
                              child: Container(
                                width: 40,
                                height: 45,
                                child: RaisedButton(
                                  color: const Color(0xff0d9408),
                                  onPressed: uploading
                                      ? null
                                      : () {
                                          //  uploadImageAndSaveItemInfo();
                                          // updateProfielData(photoUrl);
                                        },
                                  child: Text(
                                    S.of(context).Save,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
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
                ),

                //  Transform.translate(
                //  offset: Offset(118.4, -266),
                //  child: SizedBox(
                //    width: 119.0,
                //   child: Avatar(
                //    avatarUrl: currentUser?.avatarUrl,
                //  onTap: () async {
                // TODO open the gallery select an image
                //   File image = await ImagePicker.pickImage(
                //      source: ImageSource.gallery);

                // //TODO upload the image

                //  locator.get<UserController>().uploadProfilePicture(image);
                // TODO setState to  update the current user
                //    setState(() {});
                //  },
                // )),
                // ),
              ],
            ),
          );
  }

  updatPRofileScreen(File ImageFe) {
    return loading
        ? Loading()
        : Scaffold(
            key: _scafoldKey,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(color: const Color(0xff0d9408)
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
                  Route route = MaterialPageRoute(
                      builder: (c) => d_profile(profileId: null //user.name,
                          ));
                  Navigator.pushReplacement(context, route);
                },
              ),
              title: Text(
                'Update Farmer profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
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
                                aspectRatio: 11 / 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        blurRadius: 1,
                                        offset: Offset(-1, 8),
                                      )
                                    ],
                                    color:
                                        Colors.deepPurpleAccent.withOpacity(.5),
                                    image: DecorationImage(
                                      image: FileImage(ImageFe),
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
                  SizedBox(
                    height: 5,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: MaterialButton(
                          onPressed: () {
                            //saveItemInfo_r(Image_file_r);
                            uploadImageAndSaveItemInfo_f(ImageFe);
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
                        padding: const EdgeInsets.only(top: 20, left: 30),
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

  Future updateProfielData() async {
    setState(() async {
      name.text.trim().length < 30 || name.text.isEmpty
          ? _displaynameValid = true
          : _displaynameValid = false;
      mobile.text.trim().length == 10 || mobile.text.isEmpty
          ? _mobileValid = true
          : _mobileValid = false;
      Dropcountry.length <= 40 || Dropcountry.isEmpty
          ? _contryValid = true
          : _contryValid = false;
      DropState.length <= 50 || DropState.isEmpty
          ? _stateValid = true
          : _stateValid = false;
      Dropdistrict.length < 53 || Dropdistrict.isEmpty
          ? _districtValid = true
          : _districtValid = false;
      block.text.trim().length < 53 || block.text.isEmpty
          ? _blockValid = true
          : _blockValid = false;
      village.text.trim().length < 53 || village.text.isEmpty
          ? _vilageValid = true
          : _vilageValid = false;
      pincode.text.trim().length == 6 || pincode.text.isEmpty
          ? _pincodeValid = true
          : _pincodeValid = false;
      loading = true;
      Image_f = null;
      uploading = false;
      var fuser = await FirebaseAuth.instance.currentUser;
      if (_contryValid &&
          _districtValid &&
          _stateValid &&
          _blockValid &&
          _pincodeValid &&
          _vilageValid) {
        FirebaseFirestore.instance.collection("users").doc(fuser.uid).update({
          "user": name.text,
          "mobile": mobile.text,
          "country": Dropcountry,
          "state": DropState,
          "district": Dropdistrict,
          "block": block.text,
          "village": village.text,
          "pincode": pincode.text,
          // "thumbnailUrl": photoUrl,
          //"avatarUrl":
          //   Provider.of<LandingUtils>(context, listen: false).userAvatarUrl
          //  'avatarUrl': avatar.text ,
        });
        SnackBar snackbar = SnackBar(
          content: Text("Profile Updated"),
        );
        _scafoldKey.currentState.showSnackBar(snackbar);
      }
    });
  }

  takeImage(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Select_Image,
            style: TextStyle(
              color: Color(0xff3B9412),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                S.of(context).Take_Picture,
                style: TextStyle(
                  color: Color(0xff3B9412),
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
                  color: Color(0xff3B9412),
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
                  color: Color(0xff3B9412),
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

  update_farmer(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Driver_Profile,
            style: TextStyle(
              color: Color(0xff3B9412),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_name,
                labelText: S.of(context).Name,
                errorText:
                    _displaynameValid ? null : S.of(context).Display_username,
                focusColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: mobile,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.stay_primary_portrait,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_mobile_number,
                labelText: S.of(context).Mobile,
                errorText: _mobileValid
                    ? null
                    : S.of(context).Pleas_enter_Mobile_number,
                focusColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 0,
              width: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.location_on_outlined,
                          size: 30,
                          color: Color(0xff0d9408),
                        ),
                        hintText: S.of(context).Select_Country,
                        labelText: S.of(context).Country),

                    value: null, //Dropcountry,
                    //.isNotEmpty ? Dropcountry : null, //
                    isExpanded: true,
                    onChanged: (_value) =>
                        s_disabledropdown ? null : Countrychange(_value),
                    //(String _value) {
                    //if (_value == "India") {
                    //StatList = [];
                    //State_load();
                    //   } else {
                    //   //});
                    //},
                    items: Country_list,
                  )),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.location_on,
                                size: 20,
                                color: const Color(0xff0d9408),
                              ),
                              hintText: S.of(context).Select_State,
                              labelText: S.of(context).State),
                          value: null, //DropState,
                          isExpanded: true,
                          onChanged: (_value) =>
                              d_disabledropdown ? null : StateChange(_value),
                          items: StatList)),
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),

            Expanded(
              child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.add_location_alt,
                      size: 20,
                      color: Color(0xff3B9412),
                    ),
                    hintText: S.of(context).Select_district,
                    labelText: S.of(context).District),
                value: //Dropdistrict.isEmpty
                    null,
                // Dropdistrict, // null : district,
                isExpanded: true,
                onChanged: (_value) =>
                    //  d_disabledropdown ? null :
                    DistrictValue(_value),
                items: districtlist,
              )),
            )
            // Text("$_mycountry"),
            //SizedBox(
            //width: 20,
            //),
            ,

            // Text("$_mycountry"),
            //SizedBox(
            //width: 20,
            //),,

            SizedBox(
              height: 5,
            ),
            TextField(
              controller: block,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.location_city,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_block_name,
                labelText: S.of(context).Block,
                errorText: _blockValid ? null : S.of(context).Enter_block,
                focusColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: village,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.location_searching_sharp,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_village,
                labelText: S.of(context).Village,
                errorText: _vilageValid ? null : S.of(context).Display_Village,
                focusColor: Colors.green,
              ),
            ),

            SizedBox(
              height: 5,
            ),
            TextField(
              controller: pincode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.keyboard_outlined,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_pincode,
                labelText: S.of(context).Pincode,
                errorText: _pincodeValid ? null : S.of(context).Display_pincode,
                focusColor: Colors.green,
              ),
            ),

            SizedBox(
              height: 10,
            ),
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
                        width: 40,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: uploading
                              ? null
                              : () {
                                  updateProfielData();
                                },
                          child: Text(
                            S.of(context).Save,
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
                            S.of(context).Cancel,
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
}

const String _svg_t96b8v =
    '<svg viewBox="16.2 271.9 373.0 1.0" ><path transform="translate(-2.83, -19.23)" d="M 19.05420112609863 291.158935546875 L 392.0111083984375 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_8n4dk8 =
    '<svg viewBox="23.3 398.9 355.1 105.3" ><path transform="translate(5.52, 21.89)" d="M 19.05420303344727 482.29638671875 L 159.0542144775391 482.29638671875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.86, -240.19)" d="M 7.4013671875 639.21728515625 L 147.4013671875 639.21728515625" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(219.25, -34.52)" d="M 19.05420112609863 482.29638671875 L 159.05419921875 482.29638671875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(5.95, -35.52)" d="M 19.05420112609863 482.29638671875 L 159.05419921875 482.29638671875" fill="#090808" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(218.8, -83.43)" d="M 19.05420684814453 482.29638671875 L 159.05419921875 482.29638671875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w9ep25 =
    '<svg viewBox="19.2 334.4 373.0 1.0" ><path transform="translate(0.17, -44.67)" d="M 19.05420112609863 379.038330078125 L 392.0111083984375 379.038330078125" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1y0ak0 =
    '<svg viewBox="238.2 504.3 140.0 1.0" ><path transform="translate(219.17, 22.03)" d="M 159.0532379150391 482.29638671875 L 19.05421447753906 482.29638671875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3i8pp2 =
    '<svg viewBox="-259.0 413.7 416.0 71.0" ><path transform="translate(-259.0, 413.74)" d="M 0 0 C 0 0 200.2496490478516 0 304.2496337890625 0 C 310.0736389160156 0 315.5957946777344 0 320.9256591796875 0 C 409.0934143066406 0 416 0 416 0 L 416 71.0234375 L 0 71.0234375 L 0 0 Z" fill="#ef8325" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_d4b4b =
    '<svg viewBox="-86.6 381.8 70.0 70.0" ><path transform="translate(-86.63, 381.83)" d="M 35 0 C 54.32997131347656 0 70 15.67003726959229 70 35 C 70 54.32997131347656 54.32997131347656 70 35 70 C 15.67003536224365 70 0 54.32997131347656 0 35 C 0 15.67003726959229 15.67003536224365 0 35 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_no3pl5 =
    '<svg viewBox="-166.4 381.8 70.0 70.0" ><path transform="translate(-166.36, 381.83)" d="M 35 0 C 54.32997131347656 0 70 15.67003726959229 70 35 C 70 54.32997131347656 54.32997131347656 70 35 70 C 15.67003536224365 70 0 54.32997131347656 0 35 C 0 15.67003726959229 15.67003536224365 0 35 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_dyglzn =
    '<svg viewBox="-251.4 381.8 70.0 70.0" ><path transform="translate(-251.41, 381.83)" d="M 35 0 C 54.32997131347656 0 70 15.67003536224365 70 35 C 70 54.3299560546875 54.32997131347656 70 35 70 C 15.67003440856934 70 0 54.3299560546875 0 35 C 0 15.67003536224365 15.67003440856934 0 35 0 Z" fill="#ffffff" stroke="#228f0d" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_ob1oc1 =
    '<svg viewBox="83.4 381.7 70.0 70.0" ><path transform="translate(83.43, 381.71)" d="M 35 0 C 54.32997512817383 0 70 15.67003726959229 70 35 C 70 54.32997131347656 54.32997512817383 70 35 70 C 15.67003536224365 70 0 54.32997131347656 0 35 C 0 15.67003726959229 15.67003536224365 0 35 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_wm59s6 =
    '<svg viewBox="-2.6 381.8 70.0 70.0" ><path transform="translate(-2.57, 381.83)" d="M 35 0 C 54.32997512817383 0 70 15.67003726959229 70 35 C 70 54.3299674987793 54.32997512817383 70 35 70 C 15.67003536224365 70 0 54.3299674987793 0 35 C 0 15.67003726959229 15.67003536224365 0 35 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_b7v3m8 =
    '<svg viewBox="-295.3 363.8 121.4 87.8" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="200.0" height="200.0"><image xlink:href="null" x="0" y="0" width="200.0" height="200.0" /></pattern></defs><path transform="translate(-295.31, 320.16)" d="M 51.89164733886719 62.91320419311523 C 82.23438262939453 32.57046890258789 108.9401397705078 47.20396423339844 108.9401397705078 47.20396423339844 L 121.3709487915039 131.4964294433594 L 0 131.4964294433594 C 0 131.4964294433594 21.54891014099121 93.25594329833984 51.89164733886719 62.91320419311523 Z" fill="url(#image)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
