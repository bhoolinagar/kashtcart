import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './d_analytics.dart';
import './d_earn.dart';
import './d_service.dart';

class d_analytics_1 extends StatelessWidget {
  d_analytics_1({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromSize(
            bounds: Rect.fromLTWH(0.0, -4.0, 428.0, 100.0),
            size: Size(48.0, 748.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff3B9412),
                border: Border.all(width: 2.0, color: Color(0xffe78100)),
              ),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(35.0, 75.0, 56.0, 29.0),
            size: Size(418.0, 748.0),
            pinLeft: true,
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => d_earn(),
                ),
              ],
              child: Text(
                'Work',
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 15,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(174.0, 77.0, 94.0, 30.0),
            size: Size(418.0, 748.0),
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => d_earn(),
                ),
              ],
              child: Text(
                'Earning',
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 15,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(122.0, 94.0, 75.0, 6.0),
            size: Size(418.0, 748.0),
            pinLeft: true,
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff3B9412),
                border: Border.all(width: 1.0, color: Color(0xff3B9412)),
              ),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(176.6, 32.1, 45.0, 45.0),
            size: Size(418.0, 748.0),
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: SvgPicture.string(
              _svg_ftz8hk,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(33.3, 32.0, 45.0, 45.0),
            size: Size(418.0, 748.0),
            pinLeft: true,
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: SvgPicture.string(
              _svg_6vbq1d,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(37.0, 43.0, 34.0, 34.0),
            size: Size(418.0, 748.0),
            pinLeft: true,
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => d_service(),
                ),
              ],
              child:

                  // Adobe XD layer: 'work' (shape)
                  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29.0),
                  image: DecorationImage(
                    image: const AssetImage('assets/work.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(177.0, 40.0, 39.0, 39.0),
            size: Size(418.0, 748.0),
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'earn' (shape)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => d_earn(),
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/earn.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromSize(
              bounds: Rect.fromLTWH(329.2, 32.1, 45.0, 45.0),
              size: Size(418.0, 748.0),
              pinRight: true,
              pinTop: true,
              fixedWidth: true,
              fixedHeight: true,
              child: PageLink(
                links: [
                  PageLinkInfo(
                    transition: LinkTransition.Fade,
                    ease: Curves.easeOut,
                    duration: 0.3,
                    pageBuilder: () => d_analytics(),
                  ),
                ],
                child: SvgPicture.string(
                  _svg_lvij37,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              )),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(333.0, 37.0, 33.0, 33.0),
            size: Size(418.0, 748.0),
            pinRight: true,
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'anlytics' (shape)
                Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/anlytics.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(319.0, 77.0, 84.0, 30.0),
            size: Size(418.0, 748.0),
            pinRight: true,
            pinTop: true,
            fixedWidth: true,
            fixedHeight: true,
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => d_analytics(),
                ),
              ],
              child: Text(
                'Analytics',
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 15,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 110, right: 5),
            child: Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //  color: Colors.greenAccent.withOpacity(.3)
              ),
              child: ListTile(
                  title: Text("1.  Ram Gopal Nagar"),
                  subtitle: Text(" Send Remainder"),
                  trailing: Text("500"),
                  leading: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70)),
                    child: Image.asset('assets/farmer (2).png'),
                  )),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 190, right: 5),
            child: Container(
              width: 400,
              height: 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 200, right: 5),
            child: Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //  color: Colors.greenAccent.withOpacity(.3)
              ),
              child: ListTile(
                  title: Text("Total"),
                  //  subtitle: Text(" Send Remainder"),
                  trailing: Row(
                    children: [
                      Text("300"),
                    ],
                  ),
                  leading: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70)),
                    child: Image.asset('assets/farmer (2).png'),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_v9rkw =
    '<svg viewBox="10.0 23.6 414.0 84.1" ><path transform="translate(10.0, 23.62)" d="M 0 0 L 414 0 L 414 84.11572265625 L 0 84.11572265625 L 0 0 Z" fill="#ec8951" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yy7493 =
    '<svg viewBox="4.0 1.0 412.0 383.0" ><path transform="translate(4.0, 1.0)" d="M 0 0 L 412 0 L 412 383.0009765625 L 0 383.0009765625 L 0 0 Z" fill="#0e8a16" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gyhxte =
    '<svg viewBox="8.3 114.2 393.2 156.7" ><path transform="translate(11.59, 546.06)" d="M -3.295898199081421 -308.8001098632813 C -3.295898199081421 -308.8001098632813 25.46931457519531 -357.6838989257813 49.93947982788086 -357.6838989257813 C 74.40966796875 -357.6838989257813 71.14263916015625 -386.7752075195313 94.99812316894531 -386.7752075195313 C 118.8536224365234 -386.7752075195313 113.0567855834961 -275.1772766113281 137.0831604003906 -275.1772766113281 C 161.1096038818359 -275.1772766113281 160.9636688232422 -336.1511535644531 185.0217437744141 -336.1511535644531 C 209.0798797607422 -336.1511535644531 211.8047790527344 -431.8382873535156 235.9035797119141 -431.8382873535156 C 260.0024719238281 -431.8382873535156 256.1759033203125 -372.0507202148438 280.4717712402344 -372.0507202148438 C 304.767578125 -372.0507202148438 307.8238525390625 -336.1511535644531 332.6018371582031 -336.1511535644531 C 357.3800659179688 -336.1511535644531 389.8692321777344 -379.4129638671875 389.8692321777344 -379.4129638671875" fill="none" stroke="#f4f4f4" stroke-width="10" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ndpv16 =
    '<svg viewBox="135.0 257.3 99.3 4.1" ><path transform="translate(135.0, 257.27)" d="M 0 0 L 99.286865234375 0 L 99.286865234375 4.13037109375 L 0 4.13037109375 L 0 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
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
const String _svg_p1szt1 =
    '<svg viewBox="24.0 61.9 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 24.0, 61.94)" d="M 4.994546998204896e-07 3.070613630029584e-08 L 6.301419944065856e-06 5.201892463446711e-07 C 6.584155926248059e-06 5.440421091407188e-07 6.832693543401547e-06 7.925804652586521e-07 6.856546406197594e-06 1.075315935850085e-06 C 6.880400178488344e-06 1.35805180434545e-06 6.67053382130689e-06 1.567917252032203e-06 6.38779920336674e-06 1.54406461660983e-06 L 5.858340728082112e-07 1.054582412507443e-06 C 3.030982611562649e-07 1.030729777085071e-06 5.455903107076665e-08 7.821911367500434e-07 3.070621801271045e-08 4.99455779845448e-07 C 6.853159817410415e-09 2.167191013313641e-07 2.167190302770905e-07 6.853298373243888e-09 4.994546998204896e-07 3.070613630029584e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 24.0, 61.94)" d="M 5.149904609424993e-07 1.030411667102271e-07 L 6.316955023066839e-06 -3.864397513098083e-07 C 6.599689641006989e-06 -4.102930688532069e-07 6.809555543441093e-06 -2.004270100997019e-07 6.785702680645045e-06 8.230857417856896e-08 C 6.761850727343699e-06 3.650438884506002e-07 6.513312200695509e-06 6.135834951237484e-07 6.230575309018604e-06 6.374356189553509e-07 L 4.286110311113589e-07 1.126918164118251e-06 C 1.458754752547975e-07 1.150771367974812e-06 -6.399015006763875e-08 9.409047265762638e-07 -4.013732990415519e-08 6.581694265150873e-07 C -1.628427881428252e-08 3.754341264539107e-07 2.322549050859379e-07 1.268948608412757e-07 5.149904609424993e-07 1.030411667102271e-07 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_8yzg0t =
    '<svg viewBox="267.0 239.5 1.0 5.0" ><path transform="translate(267.0, 219.0)" d="M 0 20.5 C 0 20.5 0 31.82183837890625 0 20.5 Z" fill="#ffffff" stroke="#1e9e2a" stroke-width="3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ftz8hk =
    '<svg viewBox="158.6 69.1 85.0 85.0" ><path transform="translate(158.63, 69.08)" d="M 42.5 0 C 65.97210693359375 0 85 19.02790451049805 85 42.5 C 85 65.97210693359375 65.97210693359375 85 42.5 85 C 19.02790069580078 85 0 65.97210693359375 0 42.5 C 0 19.02790451049805 19.02790069580078 0 42.5 0 Z" fill="#ffffff" stroke="#e97939" stroke-width="5" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_6vbq1d =
    '<svg viewBox="20.3 69.0 85.0 85.0" ><path transform="translate(20.35, 69.0)" d="M 42.5 0 C 65.97210693359375 0 85 19.02790451049805 85 42.5 C 85 65.97210693359375 65.97210693359375 85 42.5 85 C 19.02790260314941 85 0 65.97210693359375 0 42.5 C 0 19.02790451049805 19.02790260314941 0 42.5 0 Z" fill="#ffffff" stroke="#e97939" stroke-width="5" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_8hg0wn =
    '<svg viewBox="31.0 98.9 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 31.0, 98.94)" d="M 4.432108084984065e-07 -2.55347103461645e-08 L 6.245148142625112e-06 4.639526594019117e-07 C 6.527882760565262e-06 4.878056643065065e-07 6.776418558729347e-06 7.363431677731569e-07 6.800271876272745e-06 1.019077444652794e-06 C 6.824126103310846e-06 1.301811948906106e-06 6.614261110371444e-06 1.511676032350806e-06 6.331527401925996e-06 1.487822942181083e-06 L 5.295909204505733e-07 9.983367590393755e-07 C 2.468564730406797e-07 9.744838962433278e-07 -1.681776495843224e-09 7.259459380293265e-07 -2.553478495315176e-08 4.432120874753309e-07 C -4.938804920584516e-08 1.604767874141544e-07 1.604765458296242e-07 -4.938776143603718e-08 4.432108084984065e-07 -2.55347103461645e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_h3kdrg =
    '<svg viewBox="31.0 98.9 1.0 1.0" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 31.0, 98.94)" d="M 6.699251002828532e-07 9.59588078330853e-07 L 6.471861979662208e-06 4.701028046838474e-07 C 6.754594778612955e-06 4.46249373453611e-07 6.964459771552356e-06 6.561140253324993e-07 6.940607363503659e-06 9.388484158989741e-07 C 6.916754045960261e-06 1.221582124344422e-06 6.668216883554123e-06 1.470120878366288e-06 6.38548090137192e-06 1.49397351378866e-06 L 5.835449883306865e-07 1.983460151677718e-06 C 3.008107967161777e-07 2.007313469221117e-06 9.094641484352906e-08 1.79744824890804e-06 1.147994623806881e-07 1.514714085715241e-06 C 1.386526804481036e-07 1.231980149896117e-06 3.871908802466351e-07 9.834418506216025e-07 6.699251002828532e-07 9.59588078330853e-07 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lvij37 =
    '<svg viewBox="309.2 69.1 85.0 85.0" ><path transform="translate(309.17, 69.08)" d="M 42.5 0 C 65.97210693359375 0 85 19.02790260314941 85 42.5 C 85 65.97210693359375 65.97210693359375 85 42.5 85 C 19.02790069580078 85 0 65.97210693359375 0 42.5 C 0 19.02790260314941 19.02790069580078 0 42.5 0 Z" fill="#ffffff" stroke="#e97939" stroke-width="5" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
