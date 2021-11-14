import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/screens/DSmobile.dart';
import 'package:kisan/Driver/screens/d_home.dart';

class Phone_Auth {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return d_home(
              currentId: snapshot.data.documents['uid'],
            );
          } else {
            return DSmobile();
          }
        });
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    return SignPhone(authCreds);
  }

  SignPhone(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }
}

//class SignInViewModel extends BaseModel {
  //bool _userLoginAutoValidate = false;

  //TextEditingController _passwordController = TextEditingController();

  //TextEditingController _userIdController = TextEditingController();

  //bool _passwordVisible = false;

  //bool get passwordVisible => _passwordVisible;

  //set passwordVisible(bool value) {
    //_passwordVisible = value;
    //notifyListeners();
  //}

  //TextEditingController get userIdController => _userIdController;

  //set userIdController(TextEditingController value) {
    //_userIdController = value;
    //notifyListeners();
 // }

  //TextEditingController get passwordController => _passwordController;

  //set passwordController(TextEditingController value) {
    //_passwordController = value;
    //notifyListeners();
 // }

 // bool get userLoginAutoValidate => _userLoginAutoValidate;
 // set userLoginAutoValidate(bool value) {
   // _userLoginAutoValidate = value;
    //notifyListeners();
 // }

 // clearAllModels() {
   // _userLoginAutoValidate = false;
    //_passwordController = TextEditingController();
    //_userIdController = TextEditingController();
    //_passwordVisible = false;
 // }
//}
