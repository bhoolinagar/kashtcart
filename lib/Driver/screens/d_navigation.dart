import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/farmer/v_details.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/configMap.dart';
import 'package:kisan/owner/loading.dart';

class Home extends StatefulWidget {
  @override
  _dHome createState() => _dHome();
}

class _dHome extends State<Home> {
  /// CollectionReference v_ref = FirebaseFirestore.instance.collection("Vehicle");
  CollectionReference tractor_ref =
      FirebaseFirestore.instance.collection("1_vehicle");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 790,
          width: 30,
          decoration: BoxDecoration(
            color: const Color(0xff3B9412),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(right: 40),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.5, color: const Color(0xff3B9412)),
            // color: Colors.white,

            image: DecorationImage(
              image: const AssetImage('assets/KC.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          MaterialButton(
              child: Container(
                padding: const EdgeInsets.only(left: 40),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1.5, color: const Color(0xff3B9412)),
                  // color: Colors.white,

                  //image: Icon(Icons.search),
                  //   DecorationImage(image:
                  //const AssetImage('assets/share.png'),fit: BoxFit.cover,
                  //  ),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => D_sr()
                        // Satelite_GoogleMapPage() //GoogleMapPage()
                        //d_search()
                        ));
              }),
          MaterialButton(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1.5, color: const Color(0xff3B9412)),
                  // color: Colors.white,

                  image: DecorationImage(
                    image: const AssetImage('assets/notification.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  child: null,
                ),
              ),
              onPressed: null),
        ],
        centerTitle: true,
        leading: Transform.translate(
          offset: Offset(10.0, 3.0),
          child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.SlideRight,
                  ease: Curves.easeOut,
                  duration: 0.6,
                  pageBuilder: () => d_drawer(),
                ),
              ],
              child: IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: null,
                //() {
                //Navigator.of(context).push(
                //  MaterialPageRoute(builder: (context) => d_drawer()));
                // },
              )
              //Image.asset('asets/manu.png'),
              ),
        ),

        //IconButton(
        //icon: Icon(Icons.menu_open_sharp, color: Colors.white, size: 37),
        //onPressed: () {
        //Navigator.of(context).push(MaterialPageRoute(
        //settings: SlideRight,
        //  builder: (context) => d_drawer()));
        // },
        //),
      ),
      body: Container(
        child: Column(
          children: [
            //  Container(
            //  alignment: Alignment.center,
            //  height: 162,
            // width: double.infinity,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //   end: Alignment.bottomCenter,
            // colors: [Color(0xff3B9412), Color(0xfffB9412)]),
            // color: Color(0xc2d55e0a),
            //Color(0xff3B9412),
            // ),
            /// child: Expanded(
            // flex: 7,
            // child: StreamBuilder(
            //   stream: tractor_ref.snapshots(),
            // builder: (context, AsyncSnapshot snapshot) {
            //  if (snapshot.hasData) {
            // Vehicle ve_Ref = Vehicle.fromDocument(snapshot.data.);
            //  List rev = snapshot.data.docs.toList();
            //return Padding(
            // padding:
            //   const EdgeInsets.only(top: 5, left: 10, right: 5),
            // child: ListView.builder(
            /// scrollDirection: Axis.horizontal,
            ///   itemBuilder: (context, index) {
            //    Vehicle veh = Vehicle.fromDocument(snapshot.data);
            //  return Card(
            // color: Color(0xffefd1a0),
            ///  child: Container(
            // height: 220,
            // width: 260,
            // child: Column(
            // children: [
            //  Row(
            //  children: [
            //  Expanded(
            //  child: Container(
            //  height: 80,
            // width: 50,
            //  child: Image.network(
            //    '${rev[index]['v_url']}'),
            // '${UserList[index]['thumbnailUrl']}',

            //decoration: BoxDecoration(
            //color: Color(0xfffdfcfc),
            //borderRadius:
            //  BorderRadius.circular(3),
            //boxShadow: [
            //BoxShadow(
            //color: Colors.grey
            //  .withOpacity(1),
            //      blurRadius: 1,
            //    offset: Offset(-4, 10),
            //  )
            //   ],
            //  image: DecorationImage(
            //  fit: BoxFit.fill,
            //image: rev[index]['v_url'] !=
            //      null
            //       ? NetworkImage(
            //         '${rev[index]['v_url']}')
            //   : Image.asset(
            //     'assets/TC.png'),
            // ),
            // ),
            //),
            // ),
            //        SizedBox(
            //        width: 5,
            //     ),
            //   Expanded(
            //   child: Container(
            //   height: 140,
            // width: 100,
            //     child: Row(
            //     children: [
            //     Expanded(
            //       child: Column(
            //   children: [
            //   Expanded(
            //     flex: 16,
            //   child: Column(
            //   children: [
            //   Row(
            //   children: [
            //   Text(
            //   S
            //     .of(context)
            //   .Vehicle,
            ///               style: TextStyle(
            ///                color: const Color(
            //                 0xff3B9412),
            //           fontSize:
            //             14,
            //       fontWeight:
            //         FontWeight.bold),
            //        ),
            //      SizedBox(
            //      width: 5,
            //    height: 0,
            //    ),
            //  Flexible(
            //  flex: 28,
            //     child: rev[index]['v_name'] !=
            //           null
            //     ? Text(
            //       "${rev[index]['v_name']}",
            //     style:
            //       TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            //)
            // : Text(S
            //   .of(context)
            // .loading),
            //      ),
            //  ],
            //  ),
            //    ],
            //  )),
            //             Expanded(
            //               flex: 8,
            ///             child: Column(
            ///            children: [
            //           Row(
            //          children: [
            //            Text(
            //            S
            //               .of(context)
            //              .rate,
            //         style: TextStyle(
            //            color: const Color(
            //               0xff3B9412),
            //          fontSize:
            //             14,
            //       fontWeight:
            //         FontWeight.bold),
            //  ),
            //SizedBox(
            //width: 15,
            //    height: 0,
            // ),
            //Expanded(
            //child: rev[index]['v_rate'] !=
            //      null
            //     ? Text(
            //       "${rev[index]['v_rate']}",
            //     style:
            //       TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            //            )
            //        : Text(
            //          "Loading"),
            //      ),
            //  ],
            //     ),
            // ],
            //     )),
            //       Expanded(
            //       flex: 10,
            //     child: Row(
            //      children: [
            //       Container(
            //       height: 20,
            //     width: 110,
            //    child:
            //      MaterialButton(
            //  onPressed: () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => DetailPage(
            //       v_use: rev[index]['v_use'],
            //     description: rev[index]['description'],
            //   v_rate: rev[index]['v_rate'],
            // v_name: rev[index]['v_name'],
            ///  vehicle: null,
            // v_url: rev[index]['v_url'],
            //review: rev[index]['review'])
            //  BookEquipment()
            // ));
            //      },
            //    child: Text(
            //    S
            //      .of(context)
            //    .View_More,
            //"${rev[index]['description']}",
            ///style: TextStyle(
            // color: const Color(
            //   0xff3B9412),
            //          fontSize:
            //            14,
            //      fontWeight:
            //         FontWeight
            //            .w300),
            //             ),
            //         ),
            //     ),
            //       ],
            //   ),
            //     ),
            //   Expanded(
            //     flex: 8,
            //   child: Container(
            ///    height: 15,
            //   width: 100,
            // decoration: BoxDecoration(
            //    borderRadius:
            //      BorderRadius
            //        .circular(
            //          80),
            // color: Color(
            //   0xff3B9412)),
            //  child:
            //    MaterialButton(
            //         onPressed: () {
            ///         Navigator.of(context).pushReplacement(MaterialPageRoute(
            //          builder: (context) => D_sr(
            //              v_name:
            //                rev[index]['v_name'],
            //           v_review:
            //             rev[index]['review'],
            //       v_rate:
            //         rev[index]['v_rate'],
            //          )
            //DetailPage(
            //   v_use: rev[index]
            //     ['v_use'],
            // description:
            //   rev[index]
            //     [
            //   'description'],
            //v_rate: rev[index]
            //  [
            // 'v_rate'],
            //    v_name: rev[index]
            //      [
            //    'v_name'],
            //     vehicle: null,
            //    v_url: rev[index]
            //      ['v_url'],
            // review: rev[index]
            //   ['review']
            // )
            //   //  BookEquipment()
            //  ));
            //},
            //  child: Text(
            // S
            ///   .of(
            //    context)
            //            .Book,
            //      style: TextStyle(
            //        fontWeight:
            //          FontWeight
            //            .bold,
            //       color: Colors
            //         .white,
            //       fontSize:
            //         13)),
            //  ),
            //     )/),
            //    ],
            //       )),
            //   ],
            // )/,
            //        ),
            //     ),
            //      ],
            //    ),
            //   ],
            //     ),
            //         ),
            //      );
            //Text('${rev[index]['vehicle_name']}');
            //  },
            //           itemCount: snapshot.data.docs.length,
            // controller: null,
            //       ),
            //   );
            //}

            //         return Loading();
            //Text(" no Data");
            //     }),
            // ),
            //    ),
            //for farm amchinary srip

            // Container(
            //   alignment: Alignment.center,
            //   height: 22,
            /// width: double.infinity,
            //       decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //   end: Alignment.bottomCenter,
            // colors: [Color(0xff3B9412), Color(0xfffB9412)]),
            //       color: Color(0xff3B9412),
            //    ),
            //   child: Text(
            //   "Farm Machinary",
            //  style: TextStyle(
            //    fontSize: 14,
            //   fontWeight: FontWeight.bold,
            // color: Colors.white),
            //       )),
            Expanded(
              flex: 17,
              child: StreamBuilder(
                  stream: tractor_ref.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      //   Vehicle ve_Ref = Vehicle.fromDocument(snapshot.data.);
                      List rev = snapshot.data.docs.toList();
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 5),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            //    Vehicle veh = Vehicle.fromDocument(snapshot.data);
                            return Card(
                              // color: Color(0xffefd1a0),
                              child: Container(
                                height: 210,
                                width: 250,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            height: 150,
                                            width: 120,
                                            //  child: Image.network(
                                            //    '${rev[index]['v_url']}'),
                                            // '${UserList[index]['thumbnailUrl']}',

                                            decoration: BoxDecoration(
                                              color: Color(0xfffdfcfc),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(1),
                                                  blurRadius: 1,
                                                  offset: Offset(-4, 10),
                                                )
                                              ],
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: rev[index]['v_url'] !=
                                                        null
                                                    ? NetworkImage(
                                                        '${rev[index]['v_url']}')
                                                    : Image.asset(
                                                        'assets/TC.png'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            height: 200,
                                            width: 170,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                  children: [
                                                    Expanded(
                                                        child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .Vehicle,
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff3B9412),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                              height: 0,
                                                            ),
                                                            Flexible(
                                                              flex: 38,
                                                              child: rev[index][
                                                                          'v_name'] !=
                                                                      null
                                                                  ? Text(
                                                                      "${rev[index]['v_name']}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  : Text(S
                                                                      .of(context)
                                                                      .loading),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                                    Expanded(
                                                        child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .rate,
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff3B9412),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                              height: 4,
                                                            ),
                                                            Expanded(
                                                              child: rev[index][
                                                                          'v_rate'] !=
                                                                      null
                                                                  ? Text(
                                                                      "${rev[index]['v_rate']}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  : Text(
                                                                      "Loading"),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .Company,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff3B9412),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Expanded(
                                                            child: rev[index][
                                                                        'company'] !=
                                                                    null
                                                                ? Text(
                                                                    "${rev[index]['company']}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                : Text(
                                                                    "Loading"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .Review,
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff3B9412),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Expanded(
                                                              child: rev[index][
                                                                          'review'] !=
                                                                      null
                                                                  ? Text(
                                                                      "${rev[index]['review']}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  : Text(S
                                                                      .of(context)
                                                                      .loading),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          MaterialButton(
                                                            onPressed: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => DetailPage(
                                                                      v_use: rev[index]['v_use'],
                                                                      description: rev[index]['description'],
                                                                      v_rate: rev[index]['v_rate'],
                                                                      v_name: rev[index]['v_name'],
                                                                      //  vehicle: null,
                                                                      v_url: rev[index]['v_url'],
                                                                      review: rev[index]['review'])
                                                                  //  BookEquipment()
                                                                  ));
                                                            },
                                                            child: Text(
                                                              S
                                                                  .of(context)
                                                                  .View_More,
                                                              //"${rev[index]['description']}",
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xffe30b12),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      height: 3,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(80),
                                                          color: Color(
                                                              0xff3B9412)),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                              builder: (context) => D_sr(
                                                                    v_name: rev[
                                                                            index]
                                                                        [
                                                                        'v_name'],
                                                                    v_review: rev[
                                                                            index]
                                                                        [
                                                                        'review'],
                                                                    v_rate: rev[
                                                                            index]
                                                                        [
                                                                        'v_rate'],
                                                                  )
                                                              //DetailPage(
                                                              //   v_use: rev[index]
                                                              //     ['v_use'],
                                                              // description:
                                                              //   rev[index]
                                                              //     [
                                                              //   'description'],
                                                              //v_rate: rev[index]
                                                              //  [
                                                              // 'v_rate'],
                                                              //    v_name: rev[index]
                                                              //      [
                                                              //    'v_name'],
                                                              //     vehicle: null,
                                                              //    v_url: rev[index]
                                                              //      ['v_url'],
                                                              // review: rev[index]
                                                              //   ['review']
                                                              // )
                                                              //  BookEquipment()
                                                              ));
                                                        },
                                                        child: Text(
                                                            S.of(context).Book,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18)),
                                                      ),
                                                    )),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                            //Text('${rev[index]['vehicle_name']}');
                          },
                          itemCount: snapshot.data.docs.length,
                          // controller: null,
                        ),
                      );
                    }

                    return Loading();
                    //Text(" no Data");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

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
const String _svg_ws264w =
    '<svg viewBox="-170.3 383.8 121.4 87.8" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="200.0" height="200.0"><image xlink:href="null" x="0" y="0" width="200.0" height="200.0" /></pattern></defs><path transform="translate(-170.31, 340.16)" d="M 51.89164733886719 62.91320419311523 C 82.23438262939453 32.57046890258789 108.9401397705078 47.20396423339844 108.9401397705078 47.20396423339844 L 121.3709487915039 131.4964294433594 L 0 131.4964294433594 C 0 131.4964294433594 21.54891014099121 93.25594329833984 51.89164733886719 62.91320419311523 Z" fill="url(#image)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_iwtvoa =
    '<svg viewBox="6.5 17.2 132.6 92.8" ><defs><filter id="shadow"><feDropShadow dx="1" dy="700" stdDeviation="0"/><feOffset dx ="0" dy="20" result="offsetblur"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 6.46, 126.1)" d="M 39.68932342529297 4.406400916888431e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L 7.179817179160664e-15 73.90861511230469 L 39.68932342529297 4.406400916888431e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_3s2w7y =
    '<svg viewBox="3.5 117.2 405.6 420.8" ><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 9.73, 453.36)" d="M 38.2030143737793 2.46993248878731e-14 L 122.290657043457 9.173808097839355 L 91.77928161621094 82.81132507324219 L 4.64411766421674e-14 72.74575805664063 L 38.2030143737793 2.46993248878731e-14 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="400" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 141.46, 126.1)" d="M 39.68932342529297 -4.406400916888431e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -1.02568845886282e-14 73.90861511230469 L 39.68932342529297 -4.406400916888431e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="400" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 272.46, 131.1)" d="M 39.68932342529297 -3.304800010039965e-14 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -6.359265869969322e-14 73.90861511230469 L 39.68932342529297 -3.304800010039965e-14 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="400" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 3.46, 298.93)" d="M 39.68932342529297 -4.715784783070748e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -1.028025592170884e-14 73.90861511230469 L 39.68932342529297 -4.715784783070748e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="400" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 129.46, 298.93)" d="M 39.68932342529297 -4.715784783070748e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -1.028025592170884e-14 73.90861511230469 L 39.68932342529297 -4.715784783070748e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 276.46, 312.37)" d="M 39.68932342529297 -4.715784783070748e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -1.028025592170884e-14 73.90861511230469 L 39.68932342529297 -4.715784783070748e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 137.46, 454.08)" d="M 39.68932342529297 -3.827606363370623e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -1.022474477047758e-14 73.90861511230469 L 39.68932342529297 -3.827606363370623e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 270.46, 454.08)" d="M 39.68932342529297 -3.827606363370623e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L -1.022474477047758e-14 73.90861511230469 L 39.68932342529297 -3.827606363370623e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_7loh0w =
    '<svg viewBox="2.7 665.0 393.3 93.2" ><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 2.73, 609.58)" d="M 38.2030143737793 8.192988862755317e-15 L 122.290657043457 9.173808097839355 L 91.77928161621094 82.81132507324219 L 0 72.74575805664063 L 38.2030143737793 8.192988862755317e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 130.46, 610.3)" d="M 39.68932342529297 8.192988862755317e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L 0 73.90861511230469 L 39.68932342529297 8.192988862755317e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="40" stdDeviation="0"/></filter></defs><path transform="matrix(0.997564, -0.069756, 0.069756, 0.997564, 263.46, 610.3)" d="M 39.68932342529297 8.192988862755317e-15 L 127.048454284668 9.320453643798828 L 95.35000610351563 84.13508605957031 L 0 73.90861511230469 L 39.68932342529297 8.192988862755317e-15 Z" fill="#ffffff" stroke="#dcdcdc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
