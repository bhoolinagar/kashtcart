import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/Drivereds/d_calculator.dart';
import 'package:kisan/Driver/screens/d_earn.dart';
import 'package:kisan/Driver/screens/settings.dart';
import 'package:kisan/farmer/v_book_1.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/loading.dart';
import 'package:kisan/owner/wrapper.dart';

import './add_page_1.dart';
import './d_home.dart';
import './d_profile.dart';
import './d_service.dart';

class d_drawer extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<d_drawer> {
  String name;
  String photo;
  bool loading = false;
  User_d user;
  // String u_uid;

  final u_uid = (FirebaseAuth.instance.currentUser).uid;
  final user_ref = FirebaseFirestore.instance.collection("users");

  String email;

  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });

    final DocumentSnapshot doc = await user_ref.doc(u_uid).get();
    Map _docdata = doc.data();
    //final user = Provider.of<User_d>(context);
    final user = User_d.fromDocument(doc, _docdata);
    name = user.name;
    email = user.email;

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  final AuthService _auth = AuthService();
  Widget build(BuildContext context) {
    //

    // bool loading = false;
    return loading
        ? Loading()
        : Scaffold(
            // backgroundColor: const Color(0xff444c44),

            //  const Color(0xffffffff),
            body: Stack(
              children: <Widget>[
                Container(
                    height: 233,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 70, top: 160),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3.0, color: const Color(0xff49ce18)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(150, 45),
                            bottomRight: Radius.elliptical(150, 45)),
                        color: Color(0xff3B9412)
                        //Color(0xffe78100)
                        ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '$name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$email',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 160, top: 15),
                  child: Container(
                    width: 145.0,
                    height: 145.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffe78100),
                          blurRadius: .5,
                          offset: Offset(-6, -6),
                        )
                      ],
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black45,
                      border: Border.all(width: 4.0, color: Color(0xff3B9412)),
                    ),
                    child: photo == null
                        ? Container(
                            width: 155.0,
                            height: 155.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff148e15),
                                  blurRadius: .6,
                                  offset: Offset(4, 4),
                                )
                              ],

                              borderRadius: BorderRadius.circular(150),
                              color: const Color(0xffffffff),
                              border: Border.all(
                                  width: 4.0, color: const Color(0xffe78100)),
                              image: DecorationImage(
                                  image: AssetImage("assets/farmer (2).png"),
                                  fit: BoxFit.cover),

                              //CircleAvatar(km
                              // backgroundColor: Colors.green,
                              //  radius: 82.0,
                              //  backgroundImage: NetworkImage(
                              //    photo,
                              //   ),
                            ))
                        : Container(
                            width: 145.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(108),
                                color: const Color(0xffffffff),
                                border:
                                    Border.all(width: 2.0, color: Colors.green),
                                image: DecorationImage(
                                    image: NetworkImage(photo),
                                    fit: BoxFit.cover)),
                            child: null
                            //CircleAvatar(
                            // backgroundColor: Colors.green,
                            //  radius: 82.0,
                            //  backgroundImage: NetworkImage(
                            //    photo,
                            //   ),
                            ),
                  ),

                  //IconButton(
                  //   icon: (photo) == null
                  //   ? Image.asset('assets/farmer (2).png')
                  //      : Image.network(photo),
                  // Image.asset('assets/farmer (2).png'),
                  ////

                  //  iconSize: 52,
                  //   onPressed: () => Navigator.push(context,
                  //      MaterialPageRoute(builder: (context) => d_profile()))),
                ),
                Transform.translate(
                    offset: Offset(255.0, 128.5),
                    child: Container(
                      child: PageLink(
                        links: [
                          PageLinkInfo(
                            transition: LinkTransition.PushDown,
                            ease: Curves.easeOut,
                            duration: 0.3,
                            pageBuilder: () => d_profile(),
                          ),
                        ],
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xffffffff),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage('assets/edit.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),

                Transform.translate(
                  offset: Offset(20, 240.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => d_home(currentId: u_uid),
                      ),
                    ],
                    child: Container(
                      width: 301.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xff3B9412),
                        border: Border.all(
                            width: 3.0, color: const Color(0xff4dce18)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(10.0, 233.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () => d_home(
                          currentId: u_uid,
                        ),
                      ),
                    ],
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 2.0, color: const Color(0xffe78100)),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-5.8, 230.2),
                  child: Transform.rotate(
                    angle: -0.0349,
                    child:
                        // Adobe XD layer: 'earn' (shape)
                        PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.SlideLeft,
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => d_home(
                            currentId: u_uid,
                          ),
                        ),
                      ],
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/home.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(107.5, 245.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => d_home(
                          currentId: u_uid,
                        ),
                      ),
                    ],
                    child: Text(
                      S.of(context).home,
                      style: TextStyle(
                        fontFamily: 'Myanmar Text',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                /// for adding farm equipment in flutter
                Transform.translate(
                  offset: Offset(25, 300.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => add_page_1(),
                      ),
                    ],
                    child: Container(
                      width: 301.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xff3B9412),
                        border: Border.all(
                            width: 3.0, color: const Color(0xff4ab318)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(10.0, 293.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.Fade,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () => add_page_1(),
                      ),
                    ],
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 2.0, color: const Color(0xffe78100)),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(11.8, 295.2),
                  child: Transform.rotate(
                    angle: -0.0349,
                    child:
                        // Adobe XD layer: 'earn' (shape)
                        PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.Fade,
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => add_page_1(),
                        ),
                      ],
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/TC.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(100.5, 309.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.Fade,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () => add_page_1(),
                      ),
                    ],
                    child: Text(
                      S.of(context).add_farm_equipment,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Myanmar Text',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                // Work details in of owner
                Transform.translate(
                  offset: Offset(25, 360.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => d_service(),
                      ),
                    ],
                    child: Container(
                      width: 301.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xff3B9412),
                        border: Border.all(
                            width: 3.0, color: const Color(0xff4bbf19)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(10.0, 353.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => d_service(),
                      ),
                    ],
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      padding: const EdgeInsets.only(
                          bottom: 5, top: 5, left: 6, right: 6),
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/work.png'),
                      ),
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        // image: const AssetImage('assets/work.png'),
                        // fit: BoxFit.fill,
                        //),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 2.0, color: const Color(0xffe78100)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(107.5, 369.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.PushLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => d_service(),
                      ),
                    ],
                    child: Text(
                      S.of(context).Work,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Myanmar Text',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

//// Analytics in your flutter drawer
                Transform.translate(
                  offset: Offset(25, 420.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.PushLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => d_Calcultor(),
                      ),
                    ],
                    child: Container(
                      width: 301.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xff3B9412),
                        border: Border.all(
                            width: 3.0, color: const Color(0xff4dc218)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(10.0, 410.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                          transition: LinkTransition.PushLeft,
                          ease: Curves.easeOut,
                          duration: 0.6,
                          pageBuilder: () => v_book_1()
                          //d_Calcultor(),
                          ),
                    ],
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 2.0, color: const Color(0xffe78100)),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(14.8, 415.2),
                  child: Transform.rotate(
                    angle: -0.0349,
                    child:
                        // Adobe XD layer: 'earn' (shape)
                        PageLink(
                      links: [
                        PageLinkInfo(
                            transition: LinkTransition.PushLeft,
                            ease: Curves.fastLinearToSlowEaseIn,
                            duration: 0.6,
                            pageBuilder: () => v_book_1()
                            //d_Calcultor(),
                            ),
                      ],
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/anlytics.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(107.5, 425.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.fastLinearToSlowEaseIn,
                        duration: 0.3,
                        pageBuilder: () => d_service(),
                      ),
                    ],
                    child: Text(
                      "Calculator",
                      //   S.of(context).My_Earning,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Myanmar Text',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(25.0, 480.0),
                  child: Container(
                    width: 301.0,
                    height: 47.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: const Color(0xff3B9412),
                      border: Border.all(
                          width: 3.0, color: const Color(0xff49ce18)),
                    ),
                    child: PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.SlideLeft,
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => d_earn(),
                        ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 70),
                        child: Text(
                          S.of(context).My_Earning,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Myanmar Text',
                            fontSize: 17,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(9.0, 469.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 2.0, color: const Color(0xffe78200)),
                    ),
                  ),
                ),

                Transform.translate(
                    offset: Offset(11.8, 470.2),
                    child: Transform.rotate(
                      angle: -0.0349,
                      child: PageLink(
                        links: [
                          PageLinkInfo(
                            transition: LinkTransition.SlideLeft,
                            ease: Curves.easeOut,
                            duration: 0.3,
                            pageBuilder: () => d_earn(),
                          ),
                        ],
                        child:
                            // Adobe XD layer: 'earn' (shape)
                            Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/earn.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )),

                Transform.translate(
                  offset: Offset(25.0, 550.0),
                  child: Container(
                    width: 301.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: const Color(0xff3B9412),
                      border: Border.all(
                          width: 4.0, color: const Color(0xff52c21d)),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(20.77, 542.5, 58.0, 58.0),
                  size: Size(527.7, 873.5),
                  fixedWidth: true,
                  fixedHeight: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 3.0, color: const Color(0xffe78200)),
                    ),
                  ),
                ),

                Pinned.fromSize(
                  bounds: Rect.fromLTWH(29.0, 547.5, 46.0, 46.0),
                  size: Size(527.7, 873.5),
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'senttings' (shape)
                      PageLink(
                    links: [
                      PageLinkInfo(
                          transition: LinkTransition.SlideLeft,
                          ease: Curves.easeOut,
                          duration: 0.6,
                          pageBuilder: () => settings()),
                    ],
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/senttings.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(107.5, 559.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.7,
                        pageBuilder: () => settings(),
                      ),
                    ],
                    child: Text(
                      S.of(context).Setting,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Myanmar Text',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                // add About Kashtcart in your app
                Transform.translate(
                  offset: Offset(25, 615.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => null,
                      ),
                    ],
                    child: Container(
                      width: 301.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xff3B9412),
                        border: Border.all(
                            width: 4.0, color: const Color(0xff54c21c)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(14.0, 609.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () => null,
                      ),
                    ],
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/KC1.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 2.0, color: const Color(0xffe78100)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(107.5, 628.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                          transition: LinkTransition.SlideLeft,
                          ease: Curves.easeOut,
                          duration: 0.6,
                          pageBuilder: () => null),
                    ],
                    child: Text(
                      S.of(context).About_us,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Myanmar Text',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                /// logout to owner in our app //////
                Transform.translate(
                  offset: Offset(25, 680.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: ()
                            //=> MyApp()

                            async {
                          await _auth.signOut();
                          setState(() {
                            loading = true;
                          });
                          Navigator.of(context).push((MaterialPageRoute(
                              builder: (context) => Wrapper())));
                        },
                      ),
                    ],
                    child: Container(
                      width: 301.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xff3B9412),
                        border: Border.all(
                            width: 3.0, color: const Color(0xff4ac11a)),
                      ),
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(14.0, 673.0),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () async {
                          await _auth.signOut();
                          // loading =false;

                          setState(() {
                            loading = true;
                          });
                          Navigator.of(context).push((MaterialPageRoute(
                              builder: (context) => Wrapper())));
                        },
                      ),
                    ],
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 2.0, color: const Color(0xffe78100)),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(18.8, 680.2),
                  child: Transform.rotate(
                    angle: -3.2000,
                    child:
                        // Adobe XD layer: 'earn' (shape)
                        PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.SlideLeft,
                          ease: Curves.easeOut,
                          duration: 0.6,
                          pageBuilder: () async {
                            await _auth.signOut();
                            Navigator.of(context).push((MaterialPageRoute(
                                builder: (context) => Wrapper())));
                          },
                        ),
                      ],
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/logout.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //   loading
                //     ? Loading():
                Transform.translate(
                  offset: Offset(107.5, 689.5),
                  child: PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.SlideLeft,
                        ease: Curves.easeOut,
                        duration: 0.6,
                        pageBuilder: () async {
                          await _auth.signOut();
                          Navigator.of(context).push((MaterialPageRoute(
                              builder: (context) => Wrapper())));

                          setState(() {
                            loading = true;
                          });
                        },
                      ),
                    ],
                    child: Text(
                      S.of(context).Logout,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Myanmar Text',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

const String _svg_sujagl =
    '<svg viewBox="78.3 -38.0 142.1 57.8" ><path transform="translate(66.0, -32.35)" d="M 15.81730937957764 -3.797441005706787 L 152.6233673095703 -3.797441005706787 C 156.7708282470703 -3.797441005706787 152.6233673095703 -7.955748558044434 152.6233673095703 -3.797441005706787 L 152.6233673095703 35.9561882019043 C 152.6233673095703 40.114501953125 83.56753540039063 52.15094375610352 79.42008209228516 52.15094375610352 L 15.81730937957764 40.22174835205078 C 11.66984844207764 40.22174835205078 12.3816614151001 40.114501953125 12.3816614151001 35.9561882019043 L 12.3816614151001 0.05872446298599243 C 12.3816614151001 -4.099583148956299 11.66984844207764 -3.797441005706787 15.81730937957764 -3.797441005706787 Z" fill="#de701c" fill-opacity="0.88" stroke="#85c185" stroke-width="5" stroke-opacity="0.88" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_d2dxj =
    '<svg viewBox="356.9 -37.0 166.4 64.0" ><path transform="translate(344.58, -31.35)" d="M 16.41065979003906 -3.599071979522705 L 176.5282897949219 -3.599071979522705 C 181.3824462890625 -3.599071979522705 176.5282897949219 -8.203709602355957 176.5282897949219 -3.599071979522705 L 176.5282897949219 40.42149353027344 C 176.5282897949219 45.02613067626953 95.70543670654297 58.3544921875 90.85125732421875 58.3544921875 L 16.41065979003906 45.1448974609375 C 11.55647850036621 45.1448974609375 12.38958168029785 45.02613067626953 12.38958168029785 40.42149353027344 L 12.38958168029785 0.6709929704666138 C 12.38958168029785 -3.933644771575928 11.55647850036621 -3.599071979522705 16.41065979003906 -3.599071979522705 Z" fill="#de701c" fill-opacity="0.88" stroke="#85c185" stroke-width="5" stroke-opacity="0.88" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
