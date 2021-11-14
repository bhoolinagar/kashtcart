import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/Drivereds/edit_d_veehicle.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/main.dart';

class Add_d_page extends StatefulWidget {
  @override
  Add_d_item createState() => Add_d_item();
}

final userRef = FirebaseFirestore.instance.collection('users');
final v_ref = FirebaseFirestore.instance.collection("Driver");

final AuthService auth = AuthService();

final uid = (FirebaseAuth.instance.currentUser).uid;
final ve_reff = v_ref.doc(uid).collection("driver");
final fuser = FirebaseAuth.instance.currentUser;

//final storage = firebase_storage.FirebaseStorage.instance().ref();
class Add_d_item extends State<Add_d_page> {
  String u_uid;

  //String v_uid;
  //Vehicle vehicle;
  User_d user;
  bool loading = true;

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
  FirebaseAuth Auth = FirebaseAuth.instance;
  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });
    final User wt = Auth.currentUser;
    //final uid = (await Auth.currentUser).uid;
    final uid = wt.uid;
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map _docdata = doc.data();
    user = User_d.fromDocument(doc, _docdata);

    u_uid = user.uid;
    //v_name = user.v_name;
    setState(() {
      loading = false;
    });
  }

  String UseId = '';
  fetInfo() async {
    User get_user = await FirebaseAuth.instance.currentUser;
    UseId = get_user.uid;
  }

  final profilList = FirebaseFirestore.instance.collection('users');
  Future getUserList() async {
    List itemList = [];

    //.document(v_uid)
    //.collection('vehicleinfo')
    ;
    try {
      //userRef
      //.document(UseId)
      //.collection('vehicleinfo')
      v_ref.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data);
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      return Text("NO data");
    }
  }

  List UserList = [];

  fetchDataLisr() async {
    dynamic res = await getUserList();
    if (res == null) {
      print("Unable to retrive data");
    } else {
      UserList = res;
    }
  }

  //Vehicle vehicle;

  String v_name, Avatar_photo_f, company;

  @override
  void initState() {
    super.initState();
    fetchDataLisr();
    getUser();
    getUserList();
    fetInfo();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description,
                    color: Colors.green,
                    playSound: true,
                    icon: '@drawable/kc')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new  message event was pushilid");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    int _counter = 0;
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How are you",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                playSound: true,
                icon: '@drawable/kc')));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return //loading ? Loading() :
        Scaffold(
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
          child: Text(S.of(context).My_vehicle),
          // ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 27),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => d_drawer()));
          },
        ),
      ),
      drawer: null,
      body: StreamBuilder(
          stream: ve_reff.snapshots(),
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
                        height: 100,
                        width: 100,
                        //  decoration:
                        //    BoxDecoration(color: Colors.tealAccent),
                        child: Card(
                            color: Color(0xffc8e5a5),
                            //Colors.green.withOpacity(.8),
                            child: ListTile(
                              leading: rev[index]['v_avatar_f'] != null
                                  ? Container(
                                      height: 45,
                                      width: 45,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          backgroundImage: NetworkImage(
                                              '${rev[index]['v_avatar_f']}'

                                              ///  '${UserList[index]['thumbnailUrl']}',
                                              )),
                                    )
                                  : Image.asset('assets/TC.png'),
                              title: Row(
                                children: [
                                  Text('${rev[index]['vehicle_name']}'),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  //Image.asset('assets/edit.png',)),

                                  Expanded(
                                    flex: 20,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      EditVehicle_data(
                                                          Ve_Id: rev[index]
                                                              ['v_uid'])));
                                        },
                                        iconSize: 3,
                                        icon: Image.asset(
                                          'assets/edit.png',
                                        )),
                                  ),
                                  Expanded(
                                    flex: 15,
                                    child: IconButton(
                                      onPressed: () {
                                        ve_reff
                                            .doc(rev[index]['v_uid'])
                                            .delete();
                                        FirebaseFirestore.instance
                                            .collection('Drivers')
                                            .doc(uid)
                                            .delete();

                                        FirebaseFirestore.instance
                                            .collection(
                                                '${rev[index]['vehicle_name']}')
                                            .doc(uid)
                                            .delete();

                                        //Navigator.of(context).pushReplacement(
                                        ///MaterialPageRoute(
                                        // builder: (_) => EditVehicle_data(
                                        //Ve_Id: rev[index]['v_uid'])));
                                      },
                                      iconSize: 20,
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xfff69a3c),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text('${rev[index]['company']}'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset(
                                        'assets/rupees-symbol-png-27187 (1).png'),
                                  ),
                                  rev[index]['rate'] != null
                                      ? Text(': ${rev[index]['rate']}')
                                      : Text(": 00/hr"),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => EditVehicle_data(
                                              Ve_Id: rev[index]['v_uid'],
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
            if (snapshot.hasData && !snapshot.data.exists) {
              return Center(
                  child: Text("No Vehicle Found please add",
                      style: TextStyle(fontSize: 25, color: Colors.black38)));
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text("Something went wrong",
                      style: TextStyle(fontSize: 25, color: Colors.black38)));
            }
            // print("Value of Uid : ${u_uid}");
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xff318b12)),
                semanticsLabel: S.of(context).loading,
                strokeWidth: 9.5,
                backgroundColor: Color(0xffe07607),
              ),
            );
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
          onPressed: showNotification,
          //   () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => add_page_1()));},
          child: Icon(
            Icons.add,
            size: 30,
            color: Color(0xffffffff),
          ),
        ),
      ),
      // bottomSheet: Text("Bottom"),
    );
  }
}
