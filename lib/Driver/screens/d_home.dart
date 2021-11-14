import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/Drivereds/Add_d_page.dart';
import 'package:kisan/Driver/Drivereds/agri_news.dart';
import 'package:kisan/Driver/Drivereds/d_search.dart';
import 'package:kisan/Driver/screens/d_navigation.dart';
import 'package:kisan/generated/l10n.dart';

import 'd_profile.dart';

//import 'd_service.dart';

class d_home extends StatefulWidget {
  final String currentId;
  d_home({Key key, @required this.currentId, String userId}) : super(key: key);

  _d_Home createState() => _d_Home(u_id: currentId);
}

class _d_Home extends State<d_home> {
  //User currentUser= locator.get<UserController>().currentUser;
  String u_id;
  _d_Home({Key key, this.u_id});
  User currentUser;
  int _currentIndex = 0;
  bool loading = false;
  User_d user;
  String name;
  //M_HelperFunction helperfunction = new M_HelperFunction();

  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });
    //final uid = (await FirebaseAuth.instance.currentUser).uid;
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(u_id).get();
    Map _docdata = doc.data();
    user = User_d.fromDocument(doc, _docdata);

    name = user.name;

    setState(() {
      loading = false;
    });
  }

  List<Widget> _widgetOpetions = <Widget>[
    Home(),
    //add_page_1(),

    Add_d_page(),
    Agri_news(),
    //   d_service(),
    //d_message(),

    Satelite_GoogleMapPage(),
    d_profile(
      profileId: null,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xffffffff),
      backgroundColor: Colors.black45,
      body: Center(child: _widgetOpetions.elementAt(_currentIndex)),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          unselectedItemIconColor: Color(0xffffffff),
          unselectedItemLabelColor: Color(0xffffffff),
          barBackgroundColor: Color(0xff3B9412),
          selectedItemBorderColor: Color(0xffffffff),
          selectedItemBackgroundColor: Color(0xfffc850d),
        ),
        //showUnselectedLabels: true,
        //selectedFontSize: 14,
        //iconSize: 35,
        // currentIndex: _currentIndex,
        selectedIndex: _currentIndex,
        items: [
          FFNavigationBarItem(
            iconData: Icons.home_outlined,

            label: S.of(context).home,
            //Container(
            //height: 40,
            //width: 40,
            //decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(98),
            //border:
            //  Border.all(width: 1.5, color: const Color(0xff0d9408)),
            //color: Colors.white,
            //image: DecorationImage(
            // alignment: Alignment.bottomLeft,
            //image: const AssetImage('assets/home1.png'),
            //fit: BoxFit.cover,
            //),
            //),
            //),
            //title: Text(
            //"Home",
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            //),
            //backgroundColor: Color(0xffe78100)
          ),
          FFNavigationBarItem(
            iconData: Icons.directions_car_outlined,
            label: S.of(context).List,
          ),
          FFNavigationBarItem(
            iconData: Icons.menu_book_sharp,
            label: S.of(context).News,
          ),
          FFNavigationBarItem(
            iconData: Icons.location_on,
            label: S.of(context).Location,
          ),
          FFNavigationBarItem(
            iconData: Icons.person_sharp,
            label: S.of(context).Profile,
          )
        ],
        onSelectTab: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

const String _svg_3i8pp2 =
    '<svg viewBox="-259.0 413.7 416.0 71.0" ><path transform="translate(-259.0, 413.74)" d="M 0 0 C 0 0 200.2496490478516 0 304.2496337890625 0 C 310.0736389160156 0 315.5957946777344 0 320.9256591796875 0 C 409.0934143066406 0 416 0 416 0 L 416 71.0234375 L 0 71.0234375 L 0 0 Z" fill="#ef8325" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_d4b4b =
    '<svg viewBox="-86.6 331.8 70.0 70.0" ><path transform="translate(-86.63, 381.83)" d="M 35 0 C 54.32997131347656 0 70 15.67003726959229 70 35 C 70 54.32997131347656 54.32997131347656 70 35 70 C 15.67003536224365 70 0 54.32997131347656 0 35 C 0 15.67003726959229 15.67003536224365 0 35 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
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
