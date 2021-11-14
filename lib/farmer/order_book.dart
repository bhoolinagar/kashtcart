import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kisan/farmer/v_book_2.dart';
import 'package:kisan/generated/l10n.dart';

class Order_detail extends StatelessWidget {
  String v_name;
  String v_service_id;
  String d_uid;
  String f_uid;

  String d_name;
  String d_mobile;
  Order_detail(
      {Key key,
      this.d_uid,
      this.v_name,
      this.f_uid,
      this.d_name,
      this.d_mobile,
      this.v_service_id});
  _callNumver(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  final uid = FirebaseAuth.instance.currentUser;
  Future GetUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0d9408),
        title: Text(S.of(context).Service_detials),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(uid.uid)
              .collection("f_Order")
              .doc(v_service_id)
              //FirebaseFirestore.instance.collection("users").doc(f_uid).collection("f_Order").doc(v_service_id)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15, right: 20),
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
                        child: Text("${snapshot.data['v_uid']}", //"$v_rate",
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
                        child: Text("${snapshot.data['d_name']}",
                            //  "${snapshot.data['v_Driver']}", //"$v_Driver",
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
                        child: Text("${snapshot.data['vehicle_name']}",
                            //"${snapshot.data['vehicle_name']}", //"$vehicle_name",
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
                        child: Text("${snapshot.data['rate']}", //"$v_rate",
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
                        child: Text("${snapshot.data['f_name']}", //"$v_Driver",
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
                        flex: 10,
                        child: MaterialButton(
                          splashColor: Color(0xffdeb8a3),
                          // color: Color(0xff3da009),
                          onPressed: () {
                            _callNumver("${snapshot.data['d_mobile']}");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 5, right: 20),
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.5, color: const Color(0xff3B9412)),
                                // color: Color(0xff3da009),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(S.of(context).Call,
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
                        child: Text("${snapshot.data['land']}", //"$v_rate",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)))
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 0),
                  child: Text(
                    S.of(context).Time_of_Service,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0),
                  child: Text(
                    S.of(context).From,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, right: 20),
                  child: Row(children: [
                    Flexible(
                        flex: 5,
                        child: Icon(
                          Icons.date_range,
                        )
                        // Image.asset('assets/info.png', width: 25, height: 25,),
                        ),
                    SizedBox(width: 20),
                    Flexible(
                        flex: 10,
                        child: Text(S.of(context).Start_date,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 18,
                        child: Text(
                            "${snapshot.data['s_s_date']} at ${snapshot.data["s_s_time"]}", //"$v_rate",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)))
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0),
                  child: Text(
                    "To ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, right: 20),
                  child: Row(children: [
                    Flexible(
                        flex: 5,
                        child: Icon(
                          Icons.date_range,
                        )
                        // Image.asset('assets/info.png', width: 25, height: 25,),
                        ),
                    SizedBox(width: 20),
                    Flexible(
                        flex: 10,
                        child: Text(S.of(context).End_date,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 18,
                        child: Text(
                            "${snapshot.data['s_e_date']} at   ${snapshot.data["s_e_time"]}", //"$v_rate",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)))
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => v_book_2(
                              ve_uid: snapshot.data["v_uid"],
                              d_uid: snapshot.data['d_uid'],
                            )));
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    padding: const EdgeInsets.only(left: 16, top: 10),
                    decoration: BoxDecoration(
                        color: Color(0xff359510),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      S.of(context).Go_for_work,
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                )
              ]);
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
              ),
            );
          }),
    );
  }
}
