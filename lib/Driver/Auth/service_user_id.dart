import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer_details {
  String d_name;
  String d_mobile;
  String d_uid;
  String uid;
  String f_name;
  String mobile;
  String pincode;
  String village;
  String Aadhar_no;
  String bank_name;
  String Account_no;
  String service_uid;
  String vehicle;

  String crop;
  // String fuel_type;
  String r_date;
  String engine_size;
  String company;
  String rate;
  String v_avatar_f;
  String f_address;
  String s_s_date;
  String s_e_date;
  String s_s_time;
  String s_e_time;
  String d_address;
  GeoPoint d_geoPoints;
  GeoPoint f_geoPoints;
  String land;
  String amount;
  // final bool showTermsText;
  Farmer_details({
    this.amount,
    this.land,
    this.d_mobile,
    this.d_name,
    this.d_uid,
    this.uid,
    this.crop,
    this.d_address,
    this.d_geoPoints,
    this.f_geoPoints,
    this.f_address,
    this.v_avatar_f,
    this.f_name,
    this.service_uid,
    this.mobile,
    this.s_s_time,
    this.s_e_time,
    this.s_s_date,
    this.s_e_date,
    this.village,
    this.pincode,
    this.Aadhar_no,
    this.Account_no,
    this.bank_name,
    this.rate,
    this.company,
    this.engine_size,
    this.r_date,
    this.vehicle,
  });

  factory Farmer_details.fromDocument(DocumentSnapshot doc, docdata) {
    return Farmer_details(
        amount: doc['amount'],
        land: doc['land'],
        d_uid: doc['d_uid'],
        uid: doc["f_uid"],
        d_mobile: docdata["d_mobile"],
        d_name: docdata['d_name'],
        f_name: docdata['f_name'],
        mobile: docdata['f_mobile'],
        crop: docdata["crop"],
        service_uid: docdata["v_uid"],
        s_s_date: docdata["s_s_date"],
        s_e_date: docdata["s_e_date"],
        village: docdata["village"],
        pincode: docdata['pincode'],
        Aadhar_no: docdata['Aadhar_no'],
        bank_name: docdata['Bank_name'],
        Account_no: docdata['Account_no'],
        s_e_time: docdata['s_e_time'],
        s_s_time: docdata['s_s_time'],
        rate: docdata['rate'],
        vehicle: docdata['vehicle_name'],
        r_date: docdata['r_date'],
        company: docdata['company'],
        engine_size: docdata['engine_size'],
        f_geoPoints: docdata["f_coords"],
        f_address: docdata["f_address"],
        d_geoPoints: docdata["d_coords"],
        d_address: docdata["d_address"],
        v_avatar_f: docdata['v_avatar_ff']);
  }
}
