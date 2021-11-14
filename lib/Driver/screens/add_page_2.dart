import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/locator.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/screens/add_page_1.dart';
import 'package:kisan/generated/l10n.dart';
import 'package:kisan/owner/loading.dart';
import 'package:kisan/owner/user-controller.dart';

class add_page_2 extends StatefulWidget {
  String profileId;
  add_page_2({this.profileId});
  @override
  Add_page_1 createState() => Add_page_1();
}

getUid() async {
  return (await FirebaseAuth.instance.currentUser).uid;
}

class Add_page_1 extends State<add_page_2> {
  TextEditingController customer = TextEditingController();
  TextEditingController Aadhar_no = TextEditingController();
  TextEditingController bank_name = TextEditingController();
  //// TextEditingController state= TextEditingController();
  TextEditingController Confirm_no = TextEditingController();
  TextEditingController IFCS_no = TextEditingController();
  TextEditingController Account_no = TextEditingController();
  TextEditingController branch_name = TextEditingController();
  TextEditingController photoUrl = TextEditingController();
  User_d user;

  String state;
  bool loading = false;
  bool _customer_name = true;
  bool _aadhar_no = true;
  bool _bank_name = true;
  // bool _stateValid =true;
  bool _account_no = true;
  bool _confirm_no = true;
  bool _IFCS_Valid = true;
  bool _branch_Valid = true;
  bool _photoUrlValid = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });
    final uid = (await FirebaseAuth.instance.currentUser).uid;
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map _docdata = doc.data();
    user = User_d.fromDocument(doc, _docdata);
    customer.text = user.name;
    Aadhar_no.text = user.Aadhar_no;
    bank_name.text = user.bank_name;
    state = user.state;
    Account_no.text = user.Account_no;
    IFCS_no.text = user.IFCS_no;
    branch_name.text = user.branch_name;

    setState(() {
      loading = false;
    });
  }

  final AuthService _auth = AuthService();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  User_d currentUser = locator.get<UserController>().currentUser;

  updateProfielData() {
    setState(() async {
      customer.text.trim().length < 30 || customer.text.isEmpty
          ? _customer_name = true
          : _customer_name = false;
      Aadhar_no.text.trim().length == 12 || Aadhar_no.text.isEmpty
          ? _aadhar_no = true
          : _aadhar_no = false;
      bank_name.text.length <= 20 || bank_name.text.isEmpty
          ? _bank_name = true
          : _bank_name = false;
      //  state.text.length<=20 ||
      //    state.text.isEmpty? _stateValid = true :
      //  _stateValid= false;
      Account_no.text.trim().length == 11 || Account_no.text.isEmpty
          ? _account_no = true
          : _account_no = false;
      Confirm_no.text.trim().length == 11 || Confirm_no.text.isEmpty
          ? _confirm_no = true
          : _confirm_no = false;
      IFCS_no.text.trim().length < 23 || IFCS_no.text.isEmpty
          ? _IFCS_Valid = true
          : _IFCS_Valid = false;
      branch_name.text.trim().length < 30 || branch_name.text.isEmpty
          ? _branch_Valid = true
          : _branch_Valid = false;
      var fuser = await FirebaseAuth.instance.currentUser;

      if (_customer_name &&
          _aadhar_no &&
          _account_no &&
          _confirm_no &&
          _IFCS_Valid &&
          _branch_Valid &&
          _bank_name) {
        FirebaseFirestore.instance.collection("users").doc(fuser.uid).update({
          "user": customer.text,
          "Aadhar_no": Aadhar_no.text,
          "Bank_name": bank_name.text,
          "Account_no": Account_no.text,
          "confirm_account": Confirm_no.text,
          "ifcs_no": IFCS_no.text,
          "branch_name": branch_name.text,
        });
        SnackBar snackbar = SnackBar(
          content: Text("Bank details Updated"),
        );
        _scafoldKey.currentState.showSnackBar(snackbar);
      }
    });
  }

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: Stack(
              children: <Widget>[
                Scaffold(
                  appBar: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(color: const Color(0xff0d9408)),
                    ),
                    title: Text(
                      S.of(context).add_bank_details,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Signatra',
                          fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => add_page_1());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                  ),
                  key: _scafoldKey,
                  body: Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 10, top: 0, bottom: 0),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Stack(
                            children: [
                              Transform.translate(
                                offset: Offset(278.5, -11.5),
                                child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: const AssetImage(
                                            'assets/locaiton.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ),
                              Transform.translate(
                                offset: Offset(4.0, 45.0),
                                child: Container(
                                  width: 900.0,
                                  height: 5.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xff0d9408),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(4.0, 40.0),
                                child: Container(
                                  width: 300.0,
                                  height: 5.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(32.0, 70.0),
                                child: Text(
                                  S.of(context).Register,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
                                    color: const Color(0xff2a2e43),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(142.0, 70.0),
                                child: Text(
                                  S.of(context).Add_photo,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
                                    color: const Color(0xff2a2e43),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(250.0, 70.0),
                                child: Text(
                                  S.of(context).Bank_details,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 15,
                                    color: const Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(44.0, 30.0),
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xff0d9408),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xff707070)),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(164.0, 30.0),
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xff0d9408),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xff707070)),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(290.0, 30.0),
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xff0d9408),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xff707070)),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(52.5, 33.5),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 19,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.6023000144958496,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(173.5, 32.5),
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.634000015258789,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(297.5, 32.5),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: const Color(0xffffffff),
                                    letterSpacing: 0.634000015258789,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        TextField(
                          controller: customer,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person_rounded,
                              size: 30,
                              color: const Color(0xff0d9408),
                            ),
                            hintText: S.of(context).Enter_name,
                            labelText: S.of(context).Name,
                            errorText: _customer_name
                                ? null
                                : S.of(context).Display_username,
                            errorStyle: TextStyle(color: Colors.red),
                            focusColor: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: Aadhar_no,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.contact_mail,
                              size: 20,
                              color: const Color(0xff0d9408),
                            ),
                            hintText: S.of(context).Enter_Aadhar_No,
                            labelText: S.of(context).Aadhar_No,
                            errorText: _aadhar_no
                                ? null
                                : S
                                    .of(context)
                                    .Please_Enter_11_digit_Aadhar_number,
                            errorStyle: TextStyle(color: Colors.red),
                            focusColor: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: bank_name,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.account_balance,
                              size: 30,
                              color: const Color(0xff0d9408),
                            ),
                            hintText: S.of(context).Enter_bank,
                            labelText: S.of(context).Bank,
                            errorStyle: TextStyle(color: Colors.red),
                            errorText: _bank_name
                                ? null
                                : S.of(context).Please_Enter_Bank_name,
                            focusColor: Colors.green,
                          ),
                        ),
                        // SizedBox(height: 5,),
                        //  TextField(
                        //  controller: state,
                        //  decoration: InputDecoration(
                        //   hintText: "Enter state",
                        //  labelText: "State",
                        //  errorText:  _stateValid ? null:"Display State",
// focusColor: Colors.green,
                        //  ),
                        //..   ),

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: Account_no,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(Icons.apps,
                                size: 30, color: const Color(0xff0d9408)),
                            hintText: S.of(context).Enter_Account_no,
                            labelText: S.of(context).Account_Number,
                            errorStyle: TextStyle(color: Colors.red),
                            errorText: _account_no
                                ? null
                                : S
                                    .of(context)
                                    .Please_Enter_11_digit_Account_number,
                            focusColor: Colors.green,
                          ),
                        ),
                        // SizedBox(height: 5,),
                        // TextField(
                        //  controller: Confirm_no,
                        // keyboardType: TextInputType.number,
                        // decoration: InputDecoration(
                        //  hintText: "Enter Confirm Account Number",
                        //  labelText: "Confirm Account No.",
                        //  errorText: _confirm_no ?  null : "Display Confirm Account number",

                        //   focusColor: Colors.green,
                        //    ),
                        //  ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: IFCS_no,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_balance_sharp,
                                size: 30, color: const Color(0xff0d9408)),
                            hintText: S.of(context).Enter_IFCS_No,
                            labelText: S.of(context).IFCS_No,
                            errorText: _IFCS_Valid
                                ? null
                                : S.of(context).Display_IFC_Number,
                            errorStyle: TextStyle(color: Colors.red),
                            focusColor: Colors.green,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: branch_name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.home_filled,
                              size: 30,
                              color: const Color(0xff0d9408),
                            ),
                            hintText: S.of(context).Enter_branch_name,
                            labelText: S.of(context).Branch_Name,
                            errorText: _branch_Valid
                                ? null
                                : S.of(context).Enter_branch_name,
                            errorStyle: TextStyle(color: Colors.red),
                            focusColor: Colors.green,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 110, top: 20, right: 110),
                          child: Container(
                            width: 40,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular((20)),
                              child: Container(
                                width: 50,
                                height: 45,
                                child: RaisedButton(
                                  color: Colors.green.withBlue(50),
                                  onPressed: updateProfielData,
                                  child: Text(
                                    S.of(context).Save,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

const String _svg_cydq3p =
    '<svg viewBox="42.3 42.9 340.4 776.3" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 45.0, 42.94)" d="M 5.111551217851229e-07 4.240882844896987e-08 L 6.313114226941252e-06 5.319093361322302e-07 C 6.595848844881402e-06 5.55762994736142e-07 6.844386916782241e-06 8.043015213843319e-07 6.86824023432564e-06 1.087037048819184e-06 C 6.892095825605793e-06 1.369772121506685e-06 6.68222992317169e-06 1.579637114446086e-06 6.399493940989487e-06 1.555783342155337e-06 L 5.975375074740441e-07 1.066283971340454e-06 C 3.14802036882611e-07 1.042430085362867e-06 6.626234494433447e-08 7.93890990280488e-07 4.24088568706793e-08 5.111560312798247e-07 C 1.855494247138267e-08 2.284200490976218e-07 2.284198217239464e-07 1.855494247138267e-08 5.111551217851229e-07 4.240882844896987e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 45.0, 42.94)" d="M 5.119212573845289e-07 -3.433598649849046e-08 L 6.313876838248689e-06 -5.238338189883507e-07 C 6.59661191093619e-06 -5.476881597132888e-07 6.806475539633539e-06 -3.378230246653402e-07 6.782624041079544e-06 -5.508825395850181e-08 C 6.758769814041443e-06 2.276471349205167e-07 6.510231287393253e-06 4.761862726354593e-07 6.2274948504637e-06 5.000397322874051e-07 L 4.255388432738982e-07 9.895392167891259e-07 C 1.428036711104141e-07 1.013393557514064e-06 -6.706117972044012e-08 8.035285645746626e-07 -4.320741098240433e-08 5.207927529227163e-07 C -1.935351789938977e-08 2.380581634042755e-07 2.291860283776259e-07 -1.048145392701372e-08 5.119212573845289e-07 -3.433598649849046e-08 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(257.94, 777.25)" d="M 13.27134990692139 0 L 111.4176025390625 0 C 118.7471694946289 0 124.68896484375 9.397866249084473 124.68896484375 20.99072265625 C 124.68896484375 32.58357620239258 118.7471694946289 41.9814453125 111.4176025390625 41.9814453125 L 13.27134990692139 41.9814453125 C 5.941785335540771 41.9814453125 0 32.58357620239258 0 20.99072265625 C 0 9.397866249084473 5.941785335540771 0 13.27134990692139 0 Z" fill="#d6681e" stroke="#b95a1a" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(42.25, 776.66)" d="M 12.31002521514893 0 L 103.3469467163086 0 C 110.1455917358398 0 115.656982421875 9.030709266662598 115.656982421875 20.170654296875 C 115.656982421875 31.31059646606445 110.1455917358398 40.34130859375 103.3469467163086 40.34130859375 L 12.31002521514893 40.34130859375 C 5.511385440826416 40.34130859375 0 31.31059646606445 0 20.170654296875 C 0 9.030709266662598 5.511385440826416 0 12.31002521514893 0 Z" fill="#d6681e" stroke="#f5f5f5" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_3l4kua =
    '<svg viewBox="1.8 34.0 409.1 9.8" ><path transform="translate(2.12, 34.0)" d="M -0.04563090205192566 0 L 408.7761535644531 0 L 408.7761535644531 9.747811317443848 C 408.7761535644531 9.747811317443848 194.5473022460938 10.07676219940186 92.34188079833984 8.599824905395508 C -9.863560676574707 7.122886657714844 -0.04563090205192566 8.599824905395508 -0.04563090205192566 8.599824905395508 L -0.04563090205192566 0 Z" fill="#000000" fill-opacity="0.26" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pk9al0 =
    '<svg viewBox="0.0 0.0 23.4 41.8" ><path transform="translate(0.0, -0.1)" d="M 11.68280029296875 0.1000000536441803 C 18.15327644348145 0.1000000536441803 23.3656005859375 7.82693338394165 23.3656005859375 17.38737678527832 C 23.3656005859375 22.23308563232422 21.5682487487793 27.34071731567383 16.80525970458984 34.2818603515625 L 11.68280029296875 41.87782669067383 L 6.470474720001221 34.2818603515625 C 1.797353863716125 27.20975303649902 -1.111205918391533e-07 22.10211944580078 -1.111205918391533e-07 17.38737678527832 C -1.111205918391533e-07 7.82693338394165 5.212326526641846 0.1000000536441803 11.68280029296875 0.1000000536441803 L 11.68280029296875 0.1000000536441803 Z" fill="#d8772d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1aek0 =
    '<svg viewBox="23.0 341.1 359.6 367.1" ><path transform="translate(4.66, 49.98)" d="M 19.05419921875 291.158935546875 L 376.9649658203125 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(4.31, 9.45)" d="M 19.05420112609863 450.71044921875 L 159.8538818359375 450.71044921875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(3.95, 327.55)" d="M 19.05420112609863 291.158935546875 L 365.78076171875 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(10.95, 413.45)" d="M 19.05419921875 294.77880859375 L 371.678955078125 294.77880859375" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7y7vtf =
    '<svg viewBox="23.7 400.3 357.9 134.1" ><path transform="translate(4.66, 109.19)" d="M 19.05420303344727 291.158935546875 L 376.9649353027344 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(220.95, 243.29)" d="M 19.05420112609863 291.158935546875 L 160.67919921875 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(4.95, 238.52)" d="M 19.05420303344727 291.158935546875 L 159.05419921875 291.158935546875" fill="#9b478f" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bp6h5i =
    '<svg viewBox="-2.6 0.0 18.0 14.4" ><path transform="translate(-9.62, -10.0)" d="M 6.999998092651367 10 L 16.01172065734863 24.43310546875 L 25.02343940734863 10 L 6.999998092651367 10 Z" fill="#401738" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
