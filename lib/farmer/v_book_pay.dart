import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/service_user_id.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/generated/l10n.dart';

class v_book_pay extends StatefulWidget {
  String ve_uid;
  String d_uid;
  v_book_pay({this.ve_uid, this.d_uid});
  @override
  _v_book_pay createState() => _v_book_pay(ve_uid: ve_uid, d_uid: d_uid);
}

class _v_book_pay extends State<v_book_pay> {
  bool _isRadio = false;
  bool _iscredti = false;
  bool _isupi = false;
  bool _isPaytm = false;
  String ve_uid;
  String d_uid;
  _v_book_pay({this.ve_uid, this.d_uid});

  TextEditingController name = TextEditingController();
  TextEditingController review = TextEditingController();
  TextEditingController mobile = TextEditingController();

  String Dropcountry = "";

  String Dropdistrict = "";
  TextEditingController cvv = TextEditingController();
  TextEditingController e_date = TextEditingController();

  bool _displaynameValid = true;
  bool _mobileValid = true;
  bool _contryValid = true;
  bool _districtValid = true;
  bool _stateValid = true;
  bool loading = false;
  Farmer_details farmer;
  String amount;
  Future<DocumentSnapshot> getUser() async {
    setState(() {
      loading = true;
    });

    // final f_uid = (await FirebaseAuth.instance.currentUser).uid;
    // DocumentSnapshot doc =
    //   await FirebaseFirestore.instance.collection("users").doc(uid).get();
    // Map _docdata = doc1.data();
    // user = User_d.fromDocument(doc, _docdata);
    //vehicle_name = user.vehicle;
    DocumentSnapshot doc1 = await FirebaseFirestore.instance
        .collection("Drivers")
        .doc(d_uid)
        .collection('d_Order')
        .doc(ve_uid)
        .get();
    Map _docdata = doc1.data();
    farmer = Farmer_details.fromDocument(doc1, _docdata);
    ve_uid = farmer.service_uid;

    amount = farmer.amount;
    // = vehicle.v_name;
    // v_avatar_b = vehicle.avatar_b;
    // v_avtar_f = vehicle.avatarUrl_f;
    // v_avatar_l = vehicle.avatar_l;
    // v_avtar_r = vehicle.AvatarUrl_r;

    //v_avatar_b = vehicle.avatar_b;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0d9408),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => d_drawer()));
          },
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).pay,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      // key: _scafoldKey,
      body: ListView(padding: EdgeInsets.only(top: 10), children: <Widget>[
        Stack(
          children: [
            Transform.translate(
              offset: Offset(210.5, -9.5),
              child: Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/locaiton.png'),
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
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff0d9408),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(4.0, 40.0),
              child: Container(
                width: 225.0,
                height: 5.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: Colors.orange,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(20.0, 70.0),
              child: Text(
                S.of(context).Book,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 16,
                  color: const Color(0xff2a2e43),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(112.0, 70.0),
              child: Text(
                S.of(context).Work,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 16,
                  color: const Color(0xff2a2e43),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(217.0, 70.0),
              child: Text(
                S.of(context).pay,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 16,
                  color: const Color(0xff2a2e43),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(296.0, 70.0),
              child: Text(
                S.of(context).Review,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 15,
                  color: const Color(0xff000000),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(24.0, 30.0),
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff0d9408),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(214.0, 30.0),
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff0d9408),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(310.0, 30.0),
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff0d9408),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(120.0, 30.0),
              child: Container(
                width: 30.0,
                height: 30.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 7),
                  child: Text(
                    "2",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 19,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.6023000144958496,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff0d9408),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(32.5, 33.5),
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
              offset: Offset(223.5, 32.5),
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
            Transform.translate(
              offset: Offset(317.5, 32.5),
              child: Text(
                '4',
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
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 70),
          child: Row(
            children: [
              Text(S.of(context).Amount,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold)),
              Text(": $amount",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 40),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: RadioListTile(
                  groupValue: _isRadio ? false : true,
                  value: false,
                  title: Text(S.of(context).cash_pay_to_kak,
                      style: TextStyle(fontSize: 14)),
                  activeColor: const Color(0xff179C18),
                  onChanged: (val) {
                    setState(() => _isRadio = !_isRadio);
                    get_review(context);
                  },
                ),
              ),
            ],
          ),

          //
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 40),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: RadioListTile(
                  groupValue: _iscredti ? false : true,
                  value: false,
                  title: Text(S.of(context).Credit_debit_card,
                      style: TextStyle(fontSize: 14)),
                  activeColor: const Color(0xff179C18),
                  onChanged: (val) {
                    setState(() => _iscredti = !_iscredti);
                    update_farmer(context);
                  },
                ),
              ),
            ],
          ),

          //
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 40),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: RadioListTile(
                  groupValue: _isupi ? false : true,
                  value: false,
                  title: Text(S.of(context).UPI_ID,
                      style: TextStyle(fontSize: 14)),
                  activeColor: const Color(0xff179C18),
                  onChanged: (val) {
                    setState(() => _isupi = !_isupi);
                    update_farmer(context);
                  },
                ),
              ),
            ],
          ),

          //
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 40),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: RadioListTile(
                  groupValue: _isPaytm ? false : true,
                  value: false,
                  title:
                      Text(S.of(context).Paytm, style: TextStyle(fontSize: 14)),
                  activeColor: const Color(0xff179C18),
                  onChanged: (val) {
                    setState(() => _isPaytm = !_isPaytm);
                  },
                ),
              ),
            ],
          ),

          //
        ),
      ]),
    );
  }

  get_review(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Pay_Service_bill,
            style: TextStyle(
              color: Color(0xff3B9412),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Text(S.of(context).Review),
            SizedBox(
              height: 5,
            ),

            TextField(
              controller: review,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Display_review,
                labelText: S.of(context).Review,
                errorText: _displaynameValid ? null : S.of(context).Review,
                focusColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Text("$_mycountry"),
            //SizedBox(
            //width: 20,
            //),

            // Text("$_mycountry"),
            //SizedBox(
            //width: 20,
            //),,

            Padding(
              padding: const EdgeInsets.only(left: 40, top: 30, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((20)),
                      child: Container(
                        width: 40,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: //uploading
                              //   ? null
                              () {
                            //   updateProfielData();
                          },
                          child: Text(
                            S.of(context).Review,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 80,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((20)),
                      child: Container(
                        width: 60,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            S.of(context).Cancel,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  update_farmer(mContext) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            S.of(context).Pay_Service_bill,
            style: TextStyle(
              color: Color(0xff3B9412),
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            TextField(
              controller: mobile,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.credit_card_rounded,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_debit_card_no,
                labelText: S.of(context).Credit_debit_card,
                errorText:
                    _mobileValid ? null : S.of(context).Enter_debit_card_no,
                focusColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),

            TextField(
              controller: e_date,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.date_range,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Expiry_Date,
                labelText: S.of(context).Expiry_Date,
                errorText: _mobileValid ? null : S.of(context).Expiry_Date,
                focusColor: Colors.green,
              ),
            ),

            SizedBox(
              height: 5,
            ),
            TextField(
              controller: cvv,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_CVV_number,
                labelText: S.of(context).CVV_number,
                errorText: _mobileValid ? null : S.of(context).Enter_CVV_number,
                focusColor: Colors.green,
              ),
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: const Color(0xff3B9412),
                ),
                hintText: S.of(context).Enter_Card_holder_name,
                labelText: S.of(context).Name,
                errorText:
                    _displaynameValid ? null : S.of(context).Display_username,
                focusColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Text("$_mycountry"),
            //SizedBox(
            //width: 20,
            //),

            // Text("$_mycountry"),
            //SizedBox(
            //width: 20,
            //),,

            Padding(
              padding: const EdgeInsets.only(left: 40, top: 30, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((20)),
                      child: Container(
                        width: 40,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: //uploading
                              //   ? null
                              () {
                            //   updateProfielData();
                          },
                          child: Text(
                            S.of(context).pay,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 80,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((20)),
                      child: Container(
                        width: 60,
                        height: 45,
                        child: RaisedButton(
                          color: const Color(0xff0d9408),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            S.of(context).Cancel,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
