import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kisan/Driver/Drivereds/d_book_1.dart';
import 'package:kisan/generated/l10n.dart';

class d_Order_detail extends StatelessWidget {
  String v_name;
  String v_service_id;
  String d_uid;
  String f_uid;

  String f_name;
  String f_mobile;
  d_Order_detail(
      {Key key,
      this.d_uid,
      this.v_name,
      this.f_uid,
      this.f_name,
      this.f_mobile,
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
        title: Text("Driver Order Details"),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Drivers")
              .doc(uid.uid)
              .collection("d_Order")
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
                        child: Text(S.of(context).Farmer_Name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 15,
                        child: Text("${snapshot.data['f_name']}",
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
                        child: Text(S.of(context).Driver_name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 15,
                        child: Text("${snapshot.data['d_name']}", //"$v_Driver",
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
                        child: Text(S.of(context).Farmer_Mobile,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 10,
                        child: MaterialButton(
                          splashColor: Color(0xffdeb8a3),
                          // color: Color(0xff3da009),
                          onPressed: () {
                            _callNumver("${snapshot.data['f_mobile']}");
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
                        child: Text(
                            "${snapshot.data['land']} acre", //"$v_rate",
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
                        color: Color(0xff4f9008)),
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
                        child: Text(S.of(context).Date,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 18,
                        child: Text(
                            "${snapshot.data['s_s_date']} :     ${snapshot.data["s_s_time"]}", //"$v_rate",
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
                    S.of(context).End_date,
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
                            "${snapshot.data['s_e_date']} :    ${snapshot.data["s_e_time"]}", //"$v_rate",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)))
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        //update status of farmer side
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(f_uid)
                            .collection("f_Order")
                            .doc(snapshot.data['v_uid'])
                            .update({
                          "Status": "Accepted",
                          //"block": block
                        });
                        FirebaseFirestore.instance
                            .collection("Drivers")
                            .doc(d_uid)
                            .collection("d_Order")
                            .doc(snapshot.data['v_uid'])
                            .update({
                          "Status": "Pending",
                          //"block": block
                        });

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => d_book_work(
                                  ve_id: snapshot.data["v_uid"],
                                  f_uid: snapshot.data['d_uid'],
                                )));
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        padding: const EdgeInsets.only(left: 12, top: 10),
                        decoration: BoxDecoration(
                            color: Color(0xff359510),
                            borderRadius: BorderRadius.circular(20)),
                        child: snapshot.data['Status'] == 'Request'
                            ? Text(
                                S.of(context).Accept_Order,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              )
                            : Text(
                                "${snapshot.data['Status']}",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    snapshot.data['Status'] == "Canceled"
                        ? MaterialButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(f_uid)
                                  .collection("f_Order")
                                  .doc(snapshot.data['v_uid'])
                                  .update({
                                "Status": "Cancel",
                                //"block": block
                              });
                              FirebaseFirestore.instance
                                  .collection("Drivers")
                                  .doc(f_uid)
                                  .collection("d_Order")
                                  .doc(snapshot.data['v_uid'])
                                  .update({
                                "Status": "Canceled",
                                //"block": block
                              });
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                height: 40,
                                width: 80,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xff359510),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  S.of(context).Cancel,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                          )
                        : Container()
                  ],
                )
              ]);
            }
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation(Color(0xffeaa669)),
                backgroundColor: Color(0xff84db2f),
              ),
            );
          }),
    );
  }
}
