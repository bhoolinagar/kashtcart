import 'package:adobe_xd/page_link.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/Driver/screens/d_service.dart';
import 'package:kisan/generated/l10n.dart';

class d_earn extends StatelessWidget {
  d_earn({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xff3B9412),
          // flexibleSpace: Container(
          // height: 1290,
          // decoration: BoxDecoration(
          // color: const Color(0xff3B9412),
          // ),
          //),
          title: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => d_service()));
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 80),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(width: 1.5, color: const Color(0xffc67a08)),
                    // color: Colors.white,

                    image: DecorationImage(
                      image: const AssetImage('assets/work.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Text(S.of(context).Work,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500))
            ],
          ),
          actions: [
            MaterialButton(
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                            width: 1.5, color: const Color(0xffd59412)),
                        color: Colors.white,
                        image: DecorationImage(
                          image: const AssetImage(
                            'assets/earn.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 0),
                        child: null,
                      ),
                    ),
                    Text(S.of(context).My_Earning,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                onPressed: null // () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (_) => d_earn()));
                //}
                ),
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
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => d_drawer()));
                  },
                )),
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
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
            child: Card(
              // width: 400,
              // height: 100,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              color: Color(0xddffffff),
              child: ListTile(
                  title: Text(
                    "Mr. Ram Gopal Nagar",
                    style: TextStyle(fontSize: 15, color: Colors.black38),
                  ),
                  subtitle: Text("View details"),
                  trailing: Column(
                    children: [
                      Text(
                        S.of(context).Amount,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff060c05)),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     width: 2.0, color: const Color(0xff3B9412)),
                              //borderRadius: BorderRadius.circular(70)),
                              child: Image.asset(
                                  'assets/rupees-symbol-png-27187 (1).png'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ": 50,590",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff3B9412)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  leading: Container(
                    height: 100,
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0, color: const Color(0xff3B9412)),
                        borderRadius: BorderRadius.circular(70)),
                    child: Image.asset('assets/farmer (2).png'),
                  )),
            ),
          ),
          Card(
            // width: 400,
            // height: 100,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            color: Color(0xddffffff),
            child: ListTile(
                title: Text(
                  "Mr. Shyam-lal Nagar",
                  style: TextStyle(fontSize: 15, color: Colors.black38),
                ),
                subtitle: Text("View details"),
                trailing: Column(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff060c05)),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     width: 2.0, color: const Color(0xff3B9412)),
                            //borderRadius: BorderRadius.circular(70)),
                            child: Image.asset(
                                'assets/rupees-symbol-png-27187 (1).png'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": 1,50,590",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff3B9412)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                leading: Container(
                  height: 100,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.0, color: const Color(0xff3B9412)),
                      borderRadius: BorderRadius.circular(70)),
                  child: Image.asset('assets/farmer (2).png'),
                )),
          ),
          Card(
            // width: 400,
            // height: 100,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            color: Color(0xddffffff),
            child: ListTile(
                title: Text(
                  "Mr. Shyam-lal Nagar",
                  style: TextStyle(fontSize: 15, color: Colors.black38),
                ),
                subtitle: Text("View details"),
                trailing: Column(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff060c05)),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     width: 2.0, color: const Color(0xff3B9412)),
                            //borderRadius: BorderRadius.circular(70)),
                            child: Image.asset(
                                'assets/rupees-symbol-png-27187 (1).png'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": 1,50,590",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff3B9412)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                leading: Container(
                  height: 100,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.0, color: const Color(0xff3B9412)),
                      borderRadius: BorderRadius.circular(70)),
                  child: Image.asset('assets/farmer (2).png'),
                )),
          ),
        ]));
  }
}

const String _svg_qiqdp2 =
    '<svg viewBox="-259.0 413.7 416.0 82.0" ><path transform="translate(-259.0, 413.74)" d="M 0 0 C 0 0 200.2496490478516 0 304.2496337890625 0 C 310.0736389160156 0 315.5957946777344 0 320.9256591796875 0 C 409.0934143066406 0 416 0 416 0 L 416 82.0234375 L 0 82.0234375 L 0 0 Z" fill="#ef8325" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lhmrwm =
    '<svg viewBox="-91.6 381.8 75.0 75.0" ><path transform="translate(-91.63, 381.83)" d="M 37.5 0 C 58.2106819152832 0 75 16.78932571411133 75 37.5 C 75 58.2106819152832 58.2106819152832 75 37.5 75 C 16.7893238067627 75 0 58.2106819152832 0 37.5 C 0 16.78932571411133 16.7893238067627 0 37.5 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_sv3sxy =
    '<svg viewBox="-173.4 381.8 75.0 75.0" ><path transform="translate(-173.36, 381.83)" d="M 37.5 0 C 58.2106819152832 0 75 16.78932571411133 75 37.5 C 75 58.2106819152832 58.2106819152832 75 37.5 75 C 16.7893238067627 75 0 58.2106819152832 0 37.5 C 0 16.78932571411133 16.7893238067627 0 37.5 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_z92j34 =
    '<svg viewBox="-254.4 381.8 75.0 75.0" ><path transform="translate(-254.41, 381.83)" d="M 37.49999618530273 0 C 58.21067428588867 0 74.99999237060547 16.78932571411133 74.99999237060547 37.5 C 74.99999237060547 58.2106819152832 58.21067428588867 75 37.49999618530273 75 C 16.78931999206543 75 0 58.2106819152832 0 37.5 C 0 16.78932571411133 16.78931999206543 0 37.49999618530273 0 Z" fill="#ffffff" stroke="#228f0d" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_eio66e =
    '<svg viewBox="77.4 381.7 75.0 75.0" ><path transform="translate(77.43, 381.71)" d="M 37.5 0 C 58.21068572998047 0 75 16.78932571411133 75 37.5 C 75 58.2106819152832 58.21068572998047 75 37.5 75 C 16.7893238067627 75 0 58.2106819152832 0 37.5 C 0 16.78932571411133 16.7893238067627 0 37.5 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_8awb57 =
    '<svg viewBox="-7.6 381.8 75.0 75.0" ><path transform="translate(-7.57, 381.83)" d="M 37.5 0 C 58.21068572998047 0 75 16.78932571411133 75 37.5 C 75 58.21067810058594 58.21068572998047 75 37.5 75 C 16.7893238067627 75 0 58.21067810058594 0 37.5 C 0 16.78932571411133 16.7893238067627 0 37.5 0 Z" fill="#ffffff" stroke="#1a9f10" stroke-width="3" stroke-linecap="butt" stroke-linejoin="round" /></svg>';
const String _svg_d6o1lc =
    '<svg viewBox="-297.3 369.8 121.4 87.8" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="200.0" height="200.0"><image xlink:href="null" x="0" y="0" width="200.0" height="200.0" /></pattern></defs><path transform="translate(-297.31, 326.16)" d="M 51.89164733886719 62.91320419311523 C 82.23438262939453 32.57046890258789 108.9401397705078 47.20396423339844 108.9401397705078 47.20396423339844 L 121.3709487915039 131.4964294433594 L 0 131.4964294433594 C 0 131.4964294433594 21.54891014099121 93.25594329833984 51.89164733886719 62.91320419311523 Z" fill="url(#image)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
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
