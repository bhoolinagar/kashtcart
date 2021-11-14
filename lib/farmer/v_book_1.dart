import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/farmer/order_book.dart';
import 'package:kisan/generated/l10n.dart';

class v_book_1 extends StatefulWidget {
  @override
  _v_book_1 createState() => _v_book_1();
}

class _v_book_1 extends State<v_book_1> {
  /// CollectionReference v_ref = FirebaseFirestore.instance.collection("Vehicle");
  CollectionReference tractor_ref =
      FirebaseFirestore.instance.collection("users");
  final uid = (FirebaseAuth.instance.currentUser).uid;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: const Color(0xff3B9412)),
        ),
        title:
            //Container(
            //height: 60,
            //width: 260,
            // decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(8),
            // border:
            //   Border.all(width: 1.5, color: const Color(0xff3B9412)),
            // color: Colors.white,

            //image: DecorationImage(
            //image: const AssetImage('assets/KC.png'),
            // fit: BoxFit.cover,
            //),
            //),
            //child:
            Padding(
          padding: const EdgeInsets.only(top: 0, left: 0),
          child: Text(S.of(context).My_Service_list),
          // ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu_open_sharp, color: Colors.white, size: 27),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => d_drawer()));
          },
        ),
      ),
      drawer: null,
      body: StreamBuilder(
          stream: tractor_ref.doc(uid).collection('f_Order').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // Vehicle ve_Ref = Vehicle.fromDocument(snapshot.data.);
              List rev = snapshot.data.docs.toList();
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    //    Vehicle veh = Vehicle.fromDocument(snapshot.data);
                    return Container(
                        height: 90,
                        width: 100,
                        //  decoration:
                        //    BoxDecoration(color: Colors.tealAccent),
                        child: Card(
                            elevation: 4.4,
                            color: Color(0xd0e5e5e0),
                            //Colors.green.withOpacity(.8),
                            child: ListTile(
                              // leading: rev[index]['d_name'] != null
                              // ? Container(
                              // height: 45,
                              // width: 45,
                              // child: CircleAvatar(
                              // backgroundColor: Colors.orange,
                              // backgroundImage: NetworkImage(
                              // '${rev[index]['']}'

                              ///  '${UserList[index]['thumbnailUrl']}',
                              //)
                              //),
                              // )
                              leading: Image.asset('assets/TC.png'),
                              title: Text('${rev[index]['d_name']}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (_) => Order_detail(
                                                  d_uid: rev[index]['d_uid'],
                                                  v_service_id: rev[index]
                                                      ['v_uid'],
                                                  d_name: rev[index]['d_name'],
                                                  v_name: rev[index]
                                                      ["vehicle_name"],
                                                  d_mobile: rev[index]
                                                      ['d_mobile'],
                                                )));
                                  },
                                  iconSize: 25,
                                  icon: Icon(Icons.delete)
                                  //Image.asset(
                                  // 'assets/edit.png',
                                  //      )
                                  ),
                              subtitle: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text('${rev[index]['vehicle_name']}'),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      //  Container(
                                      //  height: 5,
                                      // width: 5,
                                      // child: Image.asset(
                                      //    'assets/rupees-symbol-png-27187 (1).png'),
                                      //),
                                      rev[index]['d_mobile'] != null
                                          ? Text(
                                              'Mo: ${rev[index]['d_mobile']}')
                                          : Text("not added"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Order_detail(
                                                      d_uid: rev[index]
                                                          ['d_uid'],
                                                      v_service_id: rev[index]
                                                          ['v_uid'],
                                                      d_name: rev[index]
                                                          ['d_name'],
                                                      v_name: rev[index]
                                                          ["vehicle_name"],
                                                      d_mobile: rev[index]
                                                          ['d_mobile'],
                                                    )));
                                      },
                                      child: Text(S.of(context).View_More)),
                                  SizedBox(
                                    height: 1,
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => Order_detail(
                                              d_uid: rev[index]["d_uid"],
                                              v_service_id: rev[index]['v_uid'],
                                              d_name: rev[index]['d_name'],
                                              v_name: rev[index]
                                                  ["vehicle_name"],
                                              d_mobile: rev[index]['d_mobile'],
                                            )));
                              },
                            )));
                    //Text('${rev[index]['vehicle_name']}');
                  },
                  itemCount: snapshot.data.docs.length,
                  // controller: null,
                ),
              );
            }
            // print("Value of Uid : ${u_uid}");
            return CircularProgressIndicator();
            //Text(" no Data");
          }),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 20, bottom: 20),
        decoration: BoxDecoration(
            color: Color(0xff3B9412),
            //Colors.orange,
            borderRadius: BorderRadius.circular(100)),
        child: MaterialButton(
          // color: Colors.orange,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Order_detail()));
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}
