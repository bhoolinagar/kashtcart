import 'package:cloud_firestore/cloud_firestore.dart';

class User_d {
  String uid;
  String name;
  String email;
  String mobile;
  String avatarUrl;
  String country;
  String state;
  String district;
  String block;
  String pincode;
  String village;
  String Aadhar_no;
  String bank_name;
  String Account_no;
  String IFCS_no;
  String branch_name;
  String vehicle;
  String registration;
  String rc;
  String fuel_type;
  String r_date;
  String engine_size;
  String company;
  String customer;
  String v_avatar_f;
  String address;
  String addar_url;
  GeoPoint geoPoints;
  final bool showTermsText;
  User_d(
      {this.uid,
      this.addar_url,
      this.address,
      this.v_avatar_f,
      this.name,
      this.email,
      this.mobile,
      this.avatarUrl,
      this.country,
      this.state,
      this.district,
      this.block,
      this.village,
      this.pincode,
      this.Aadhar_no,
      this.Account_no,
      this.bank_name,
      this.IFCS_no,
      this.branch_name,
      this.customer,
      this.company,
      this.engine_size,
      this.fuel_type,
      this.r_date,
      this.rc,
      this.registration,
      this.vehicle,
      this.geoPoints,
      this.showTermsText = false});

  factory User_d.fromDocument(DocumentSnapshot doc, docdata) {
    return User_d(
        addar_url: docdata['addar_url'],
        uid: docdata["uid"],
        email: docdata["email"],
        avatarUrl: docdata["thumbnailUrl"],
        name: docdata['user'],
        mobile: docdata['mobile'],
        country: docdata["country"],
        state: docdata["state"],
        district: docdata["district"],
        block: docdata["block"],
        village: docdata["village"],
        pincode: docdata['pincode'],
        Aadhar_no: docdata['Aadhar_no'],
        bank_name: docdata['Bank_name'],
        Account_no: docdata['Account_no'],
        IFCS_no: docdata['ifcs_no'],
        branch_name: docdata['branch_name'],
        customer: docdata['customer'],
        vehicle: docdata['vehicle_name'],
        r_date: docdata['r_date'],
        rc: docdata['rc'],
        company: docdata['company'],
        registration: docdata['registration'],
        engine_size: docdata['engine_size'],
        fuel_type: docdata['fuel_type'],
        geoPoints: docdata["coords"],
        address: docdata["address"],
        v_avatar_f: docdata['v_avatar_ff']);
  }
}

class Vehicle {
  String address;
  GeoPoint geoPoints;
  String v_uid;
  String v_name;
  String v_date;
  String v_Rc;
  String avatarUrl_f;
  String location;
  String avatar_b;
  String avatar_l;
  String AvatarUrl_r;
  String Rate;
  String v_review;
  String v_company_name;
  String uid;
  String village;
  String pincode;
  String Authority;
  String Engine_size;
  String description;
  String v_use;
  String Fuel_type;

  String d_mobile;
  String d_name;
  Vehicle(
      {this.description,
      this.address,
      this.geoPoints,
      this.v_use,
      this.v_uid,
      this.Authority,
      this.Engine_size,
      this.Fuel_type,
      this.uid,
      this.v_name,
      this.v_date,
      this.v_Rc,
      this.avatar_b,
      this.avatarUrl_f,
      this.location,
      this.avatar_l,
      this.AvatarUrl_r,
      this.Rate,
      this.v_company_name,
      this.v_review,
      this.village,
      this.pincode,
      this.d_mobile,
      this.d_name});

  factory Vehicle.fromDocument(DocumentSnapshot doc, docdata) {
    return Vehicle(
        d_mobile: doc["d_mobile"],
        d_name: doc['d_name'],
        address: doc["address"],
        geoPoints: doc['coords'],
        uid: doc["uid"],
        v_uid: docdata["v_uid"],
        v_name: docdata["vehicle_name"],
        v_company_name: docdata["company"],
        avatarUrl_f: docdata["v_avatar_f"],
        avatar_l: docdata['v_avatar_l'],
        avatar_b: docdata['v_avatar_b'],
        AvatarUrl_r: docdata["v_avatar_r"],
        v_date: docdata["r_date"],
        Rate: docdata["rate"],
        v_Rc: docdata["rc"],
        v_review: docdata['v_review'],
        village: docdata['village'],
        pincode: docdata['pincode'],
        Authority: docdata['registration'],
        Engine_size: docdata['engine_size'],
        Fuel_type: docdata['fuel_type'],
        description: docdata['description'],
        v_use: docdata['v_use']);
  }
}

class agri_news {
  String n_agri;
  String n_date;
  String n_link;
  String n_url;

  agri_news({
    this.n_agri,
    this.n_date,
    this.n_link,
    this.n_url,
  });

  factory agri_news.fromDocument(DocumentSnapshot doc, docdata) {
    return agri_news(
        n_agri: docdata["description"],
        n_url: docdata["n_url"],
        n_date: docdata["n_date"],
        n_link: docdata['n_link']);
  }
}
