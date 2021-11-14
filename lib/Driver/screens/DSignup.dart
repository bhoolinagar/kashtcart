import 'package:adobe_xd/pinned.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/screens/d_home.dart';
import 'package:kisan/owner/constants.dart';
import 'package:kisan/owner/loading.dart';

class DSignup extends StatefulWidget {
  @override
  DSignupState createState() => DSignupState();
}

class DSignupState extends State<DSignup> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final DateTime timestamp = DateTime.now();
  bool loading = false;
  String name = " ";
  String email = " ";
  String password = " ";
  String error = " ";
  bool _isHidden = true;
  bool _isRadio = false;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(2.0, -13.7),
                  child: SvgPicture.string(
                    _svg_tqwa0y,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(7.0, 20.0),
                  child: SizedBox(
                    width: 397.0,
                    height: 855.0,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(78.0, 20.0, 200.0, 200.0),
                          size: Size(396.6, 855.0),
                          pinLeft: true,
                          pinTop: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              color: const Color(0xffffffff),
                              border: Border.all(
                                  width: 5.0, color: const Color(0xffec8951)),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(62.9, 5.3, 219.0, 219.0),
                          size: Size(396.6, 855.0),
                          pinTop: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Transform.rotate(
                            angle: 0.0,
                            child:
                                // Adobe XD layer: 'ram1' (shape)
                                Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(107.0),
                                image: DecorationImage(
                                  image:
                                      const AssetImage('assets/farmer (2).png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-15.6, 286.1),
                  child: SvgPicture.string(
                    _svg_gzhn3r,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(-2.2, 738.3),
                  child: Transform.rotate(
                    angle: -0.3316,
                    child:
                        // Adobe XD layer: 'TC' (shape)
                        Container(
                      width: 93.0,
                      height: 93.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(107.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/TC.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(02.7, 749.4),
                  child: Transform.rotate(
                    angle: -0.4712,
                    child:
                        // Adobe XD layer: '48e5ff19-ab9c-4a2e-…' (shape)
                        Container(
                      width: 42.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/farmer (2).png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(34.0, 770.0),
                  child: Transform.rotate(
                    angle: -0.192,
                    child: Container(
                      width: 13.0,
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.0),
                        color: const Color(0xc2e78200),
                        border: Border.all(
                            width: 1.0, color: const Color(0xc2c77000)),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(187.2, 679.1),
                  child: Transform.rotate(
                    angle: -0.2618,
                    child:
                        // Adobe XD layer: '48e5ff19-ab9c-4a2e-…' (shape)
                        Container(
                      width: 30.0,
                      height: 31.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/farmer (2).png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(170.9, 670.3),
                  child: Transform.rotate(
                    angle: 0.1473,
                    child:
                        // Adobe XD layer: 'TC' (shape)
                        Container(
                      width: 80.0,
                      height: 81.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/TC.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(299.4, 683.7),
                  child: Transform.rotate(
                    angle: -0.5411,
                    child:
                        // Adobe XD layer: '48e5ff19-ab9c-4a2e-…' (shape)
                        Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/farmer (2).png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(297.5, 677.0),
                  child: Transform.rotate(
                    angle: -0.3491,
                    child:
                        // Adobe XD layer: 'TC' (shape)
                        Container(
                      width: 63.3,
                      height: 63.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/TC.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(82.2, 143.1),
                  child: Transform.rotate(
                    angle: 0.0,
                    child:
                        // Adobe XD layer: '48e5ff19-ab9c-4a2e-…' (shape)
                        Container(
                      width: 239.0,
                      height: 229.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/KC logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(90.3, 208.4),
                  child: Transform.rotate(
                    angle: 0.1396,
                    child:
                        // Adobe XD layer: 'TC' (shape)
                        Container(
                      width: 64.0,
                      height: 64.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                          image: const AssetImage('assets/TC.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(50, 230),
                  child: Pinned.fromSize(
                    bounds: Rect.fromLTWH(-10.0, 90.0, 340.0, 352.0),
                    size: Size(387.1, 855.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: "Enter name",
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person,
                                    size: 25, color: Color(0xff33a509)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0))),
                            validator: (val) =>
                                val.isEmpty ? 'Enter name' : null,
                            onChanged: (val) {
                              setState(() => name = val);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: "Enter Email",
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email,
                                    size: 25, color: Color(0xff33a509)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0))),
                            validator: (val) =>
                                val.isEmpty ? 'Enter Email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(
                            height: 15,
                            width: 230,
                          ),
                          TextFormField(
                            cursorWidth: 1,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Enter Password",
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                prefixIcon: Icon(Icons.lock,
                                    size: 25, color: Color(0xff33a509)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _toggleVisibility();
                                  },
                                  icon: _isHidden
                                      ? Icon(Icons.visibility_off,
                                          color: Color(0xff33a509))
                                      : Icon(
                                          Icons.visibility,
                                          color: Colors.orange,
                                        ),
                                )),
                            obscureText: _isHidden,
                            validator: (val) => val.length < 6
                                ? 'Enter a Password 6+ chars long more'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child: RadioListTile(
                                  groupValue: _isRadio ? false : true,
                                  value: false,
                                  title: Text("I accept all",
                                      style: TextStyle(fontSize: 12)),
                                  activeColor: const Color(0xff179C18),
                                  onChanged: (val) {
                                    setState(() => _isRadio = !_isRadio);
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                      fontFamily: 'Constantia',
                                      fontSize: 14,
                                      color: const Color(0xffde911e),
                                    ),
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.registerUser(
                                    name, email, password);
                                var fuser =
                                    await FirebaseAuth.instance.currentUser;

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    Navigator.of(context).pop();
                                  });
                                } else if (result != null) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(fuser.uid)
                                      .set({
                                    'user': name,
                                    'email': email,
                                    "uid": fuser.uid,
                                    "password": password,
                                    "photourl": fuser.photoURL,
                                    "timestamp": timestamp,
                                    "country": "",
                                    "state": " ",
                                    "district": " ",
                                    "block": " ",
                                    "village": " ",
                                    " pincode": " "
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => d_home(
                                                currentId: fuser.uid,
                                              )));
                                }
                              }
                            },
                            child: Container(
                              height: 45,
                              width: 180,
                              padding: const EdgeInsets.only(top: 7, left: 35),
                              decoration: BoxDecoration(
                                  //color: Color(0xf2ffdbc9),
                                  color: const Color(0xff179C18),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

const String _svg_8wskbi =
    '<svg viewBox="2.0 461.0 334.2 63.0" ><path transform="translate(2.0, 461.0)" d="M 27.39023590087891 0 L 366.7619934082031 0 C 381.88916015625 0 394.1521911621094 14.10302925109863 394.1521911621094 31.50000190734863 C 394.1521911621094 48.89696884155273 381.88916015625 63.00000381469727 366.7619934082031 63.00000381469727 L 27.39023590087891 63.00000381469727 C 12.26302528381348 63.00000381469727 0 48.89696884155273 0 31.50000190734863 C 0 14.10302925109863 12.26302528381348 0 27.39023590087891 0 Z" fill="#edf8f8" stroke="#16b24e" stroke-width="3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_9zpcqe =
    '<svg viewBox="0.0 557.0 396.2 63.0" ><path transform="translate(0.0, 557.0)" d="M 29.49586296081543 0 L 366.6563110351563 0 C 382.9464416503906 0 396.1521911621094 14.10303115844727 396.1521911621094 31.5 C 396.1521911621094 48.89697647094727 382.9464416503906 63 366.6563110351563 63 L 29.49586296081543 63 C 13.20574855804443 63 3.691920724691045e-08 48.89697647094727 3.691920724691045e-08 31.5 C 3.691920724691045e-08 14.10303115844727 13.20574855804443 0 29.49586296081543 0 Z" fill="#edf8f8" stroke="#10ae49" stroke-width="3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tqwa0y =
    '<svg viewBox="-4.0 -13.7 422.1 277.8" ><path transform="matrix(1.0, 0.0, 0.0, 1.0, -3.98, 36.0)" d="M 209.5616455078125 -1.002640942715516e-06 C 325.2993469238281 -1.003241209218686e-06 419.123291015625 84.16679382324219 419.123291015625 187.9917755126953 C 419.123291015625 229.4177551269531 410.3714599609375 240.8754119873047 349.9303588867188 212.1978454589844 C 311.7449951171875 190.8340301513672 279.1202087402344 139.6355285644531 209.5616455078125 139.6355285644531 C 165.2926025390625 139.6355285644531 124.2295761108398 161.8999481201172 90.37828063964844 183.598388671875 C 79.13037872314453 190.8082275390625 68.65968322753906 197.9706420898438 59.14273452758789 204.221923828125 C 19.56803894042969 227.2097015380859 -2.706673774000024e-09 238.8662872314453 -2.446512326059747e-09 187.9917755126953 C -1.915574365796147e-09 84.16679382324219 93.82395172119141 -1.002040789899183e-06 209.5616455078125 -1.002640942715516e-06 Z" fill="#db622c" fill-opacity="0.35" stroke="#707070" stroke-width="1" stroke-opacity="0.35" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.999848, 0.017452, -0.017452, 0.999848, 1.72, 85.37)" d="M 208.2680969238281 0.2345596849918365 C 323.2217102050781 0.2687667906284332 416.446533203125 57.20131683349609 416.4916381835938 127.3969573974609 C 416.5366516113281 197.5925903320313 310.6508178710938 63.27973937988281 195.6972198486328 63.24553298950195 C 80.74362182617188 63.21132659912109 0.252927839756012 197.4687347412109 0.2078466564416885 127.2730941772461 C 0.1627654880285263 57.07744598388672 93.31452941894531 0.2003525942564011 208.2680969238281 0.2345596849918365 Z" fill="#e69a29" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.999848, 0.017452, -0.017452, 0.999848, 0.69, -13.97)" d="M 208.01220703125 0.2346483767032623 C 322.8260192871094 0.2846802175045013 415.9353332519531 82.23459625244141 415.9776611328125 183.2748260498047 C 416.0199584960938 284.3151245117188 309.7108459472656 108.2356109619141 194.8969879150391 108.1855697631836 C 80.08315277099609 108.1355514526367 0.2422065585851669 284.1339416503906 0.1999230235815048 183.0936584472656 C 0.1576395183801651 82.05339813232422 93.19837188720703 0.1846165210008621 208.01220703125 0.2346483767032623 Z" fill="#42952f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gzhn3r =
    '<svg viewBox="-22.6 266.1 404.2 746.5" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="200.0" height="200.0"><image xlink:href="null" x="0" y="0" width="200.0" height="200.0" /></pattern></defs> <path transform="translate(-3.0, 735.29)" d="M 205.9433441162109 -38.77314376831055 C 228.8558959960938 -26.89355087280273 284.3083801269531 -22.27482986450195 298.4892883300781 -53.41745758056641 C 299.5435791015625 -52.23590469360352 302.3474426269531 -57.9144172668457 305.171142578125 -58.4920654296875 C 307.7184448242188 -59.01313781738281 310.2857666015625 -54.43266677856445 311.3511047363281 -53.41745758056641 C 358.0180053710938 -8.945097923278809 386.0945129394531 -57.6602783203125 401.0369873046875 -73.61334228515625 C 404.001220703125 -71.67409515380859 409.4495849609375 -70.38930511474609 411.7602844238281 -65.31208038330078 C 428.7101135253906 -28.06901741027832 422.4836120605469 93.50188446044922 422.4836120605469 110.7284393310547 C 422.4836120605469 154.1189270019531 321.6254272460938 118.3579788208008 205.9433441162109 118.3579788208008 C 90.26129913330078 118.3579788208008 -1.763322353363037 154.1189880371094 -1.763322353363037 110.7284393310547 C -1.763322353363037 101.4426193237305 -10.72576236724854 85.77468872070313 -1.763322353363037 71.50113677978516 C 7.199118614196777 57.22759246826172 20.40210151672363 60.72926330566406 30.59543037414551 39.79241943359375 C 63.67165374755859 52.8912353515625 95.73136901855469 24.51073837280273 108.5831069946289 0.1333682537078857 C 109.399528503418 -1.415141105651855 112.0255661010742 -6.178606986999512 114.1587982177734 -7.028399467468262 C 116.6832275390625 -8.034225463867188 113.7904052734375 -5.063655853271484 114.1587982177734 -7.028399467468262 C 176.5489807128906 33.4133415222168 171.4871826171875 -38.77314376831055 205.9433441162109 -38.77314376831055 Z" fill="#f2c8b5" stroke="#d1ad9c" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.99863, 0.052336, -0.052336, 0.99863, -9.33, 657.29)" d="M 212.6894226074219 42.84008407592773 C 235.7101440429688 57.44742584228516 291.4244079589844 63.12667846679688 305.6722717285156 24.83318328857422 C 307.7782287597656 27.72161102294922 316.4411010742188 22.32150268554688 318.5948181152344 24.83318328857422 C 365.4820556640625 79.51713562011719 393.6911010742188 19.61615371704102 408.7041015625 0 C 411.682373046875 2.384521484375 417.1564331054688 3.964332580566406 419.47802734375 10.20736694335938 C 436.5079040527344 56.00205230712891 430.251953125 205.4876251220703 430.251953125 226.669677734375 C 430.251953125 280.0233154296875 328.9176635742188 236.0510711669922 212.6894226074219 236.0510711669922 C 96.46120452880859 236.0510711669922 4.002113342285156 280.0234069824219 4.002113342285156 226.669677734375 C 4.002113342285156 215.2516784667969 -5.002641201019287 195.9861450195313 4.002113342285156 178.4351501464844 C 13.00686836242676 160.8841552734375 26.27218627929688 165.1898651123047 36.51363754272461 139.4455871582031 C 69.74602508544922 155.5520935058594 101.9570922851563 120.6549835205078 114.869514465332 90.68016815185547 C 116.7551879882813 86.30297088623047 124.7986145019531 86.14982604980469 125.4537353515625 81.87393951416016 C 188.1384735107422 131.6017608642578 178.0705871582031 42.84008407592773 212.6894226074219 42.84008407592773 Z" fill="#e69a29" stroke="#c68523" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-16.83, 779.51)" d="M 214.6213226318359 -40.22648620605469 C 238.47314453125 -28.84244537353516 296.1987915039063 -24.4163932800293 310.9610595703125 -54.25992584228516 C 313.1430358886719 -52.00886917114258 322.1186828613281 -56.21737289428711 324.35009765625 -54.25992584228516 C 372.9300842285156 -11.64270782470703 402.1575622558594 -58.32575225830078 417.7125549316406 -73.61334228515625 C 420.7983093261719 -71.75498962402344 426.4700317382813 -70.52378845214844 428.8754272460938 -65.65837097167969 C 446.5201110839844 -29.96887969970703 440.038330078125 86.53073120117188 440.038330078125 103.0386962890625 C 440.038330078125 144.6191711425781 335.045654296875 110.3499755859375 214.6213226318359 110.3499755859375 C 94.19702911376953 110.3499755859375 -1.600031733512878 144.6192321777344 -1.600031733512878 103.0386962890625 C -1.600031733512878 94.14022827148438 -10.92987728118896 79.12588500976563 -1.600031733512878 65.44774627685547 C 7.729813575744629 51.76961135864258 21.47403717041016 55.12521362304688 32.08522415161133 35.06174468994141 C 66.51737213134766 47.61414337158203 99.89132690429688 20.41753387451172 113.2699127197266 -2.942945957183838 C 115.2236633300781 -6.354255676269531 123.5574722290039 -6.473611831665039 124.2362442016602 -9.805963516235352 C 189.1840362548828 28.94877243041992 178.752685546875 -40.22648620605469 214.6213226318359 -40.22648620605469 Z" fill="#74eeee" stroke="#f5f5f5" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-13.26, 812.51)" d="M 216.4265899658203 -48.12061309814453 C 240.4737854003906 -39.42825698852539 298.6723327636719 -36.0487174987793 313.5554809570313 -58.83592987060547 C 315.7553405761719 -57.11711883544922 324.8045043945313 -60.33054351806641 327.0542602539063 -58.83592987060547 C 376.0321960449219 -26.29529190063477 405.4990844726563 -61.94041442871094 421.1814880371094 -73.61334228515625 C 424.2925720214844 -72.19438934326172 430.0107116699219 -71.25429534912109 432.4358215332031 -67.53926849365234 C 450.2250671386719 -40.28835296630859 443.690185546875 48.66562652587891 443.690185546875 61.27037811279297 C 443.690185546875 93.0194091796875 337.83740234375 66.85294342041016 216.4265899658203 66.85294342041016 C 95.01575469970703 66.85294342041016 -1.566063165664673 93.01944732666016 -1.566063165664673 61.27037811279297 C -1.566063165664673 54.47589874267578 -10.97233963012695 43.01160430908203 -1.566063165664673 32.56758117675781 C 7.840212821960449 22.12356376647949 21.6970272064209 24.68575096130371 32.39514541625977 9.366168975830078 C 67.10935974121094 18.95063209533691 100.756706237793 -1.815503120422363 114.2448959350586 -19.65253829956055 C 116.2146453857422 -22.25726318359375 124.6167221069336 -22.3484001159668 125.3010635375977 -24.89283561706543 C 190.7809143066406 4.698572158813477 180.2640991210938 -48.12061309814453 216.4265899658203 -48.12061309814453 Z" fill="#36940e" stroke="#c68523" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_za8mb7 =
    '<svg viewBox="8.5 376.0 394.2 63.0" ><path transform="translate(8.47, 376.0)" d="M 27.39023590087891 0 L 366.7619934082031 0 C 381.88916015625 0 394.1521911621094 14.10302925109863 394.1521911621094 31.50000190734863 C 394.1521911621094 48.89696884155273 381.88916015625 63.00000381469727 366.7619934082031 63.00000381469727 L 27.39023590087891 63.00000381469727 C 12.26302528381348 63.00000381469727 0 48.89696884155273 0 31.50000190734863 C 0 14.10302925109863 12.26302528381348 0 27.39023590087891 0 Z" fill="#edf8f8" fill-opacity="0.95" stroke="#16b24e" stroke-width="3" stroke-opacity="0.95" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
