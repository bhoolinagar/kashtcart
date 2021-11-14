import "dart:async";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisan/Driver/Auth/user.dart';

class LoginService {
  LoginService() {
    Firebase.initializeApp();
  }

  User_d _user_d;
  User_d get loggedInModel => _user_d;

  Future<bool> SignWithgoogle() async {
//Triger the authencation flow
    GoogleSignIn google_sign = GoogleSignIn();
    final GoogleSignInAccount google_user = await google_sign.signIn();
    if (google_user == null) {
      return false;
    }
    final GoogleSignInAuthentication google_auth =
        await google_user.authentication;
// create a new user creadential

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: google_auth.accessToken, idToken: google_auth.idToken);
//once sign in return the UserCredential

    UserCredential user_creds =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (user_creds != null) {
      _user_d = User_d(
          name: user_creds.user.displayName,
          avatarUrl: user_creds.user.photoURL,
          email: user_creds.user.email,
          uid: user_creds.user.uid);

      FirebaseFirestore.instance
          .collection('users')
          .doc(user_creds.user.uid)
          .set({
        "uid": user_creds.user.uid,
        "user": user_creds.user.displayName,
        "email": user_creds.user.email,
        "ThumbnailUrl": user_creds.user.photoURL,
        "timestamp": "",
        "mobile": user_creds.user.phoneNumber,
        "country": "",
        "state": " ",
        "district": " ",
        "block": " ",
        "village": " ",
        " pincode": " ",
        'chattingWith': null
      });

      return true;
    }
  }
}
