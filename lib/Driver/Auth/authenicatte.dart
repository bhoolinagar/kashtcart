import "dart:async";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService() {
    Firebase.initializeApp();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  User_d currentUser;
//User_d get loggedIn => d_user;
  // create user obj based on firbaseUser
  User_d _userFromFirebaseUser(User user) {
    return user != null
        ? User_d(uid: user.uid, name: user.displayName, mobile: user.email)
        : null;
  }

// Stream change user stream
  Stream<User_d> get user {
    // ignore: deprecated_member_use
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

// for vehicle class

//get Uid
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser).uid;
  }

  Future signInAnonymously() async {
    // AuthResult
    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;
    await FirebaseAuth.instance.currentUser
        .updateProfile(displayName: user.displayName);

    // user.updateProfile(info);

    return _userFromFirebaseUser(user);
  }

// sign in with email & passwod
  Future signInUser(String email, String password) async {
    try {
      // AuthResult
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //FirebaseUser
      User user = result.user;
      // UserUpdateInfo info = UserUpdateInfo();
      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: user.displayName);

      //  user.updateProfile(info);
      User_d(uid: result.user.uid, name: result.user.displayName);
    } catch (error) {
      print(error.toString());
    }
  }

//register with email & password
  Future registerUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
      // create a new document for the user the uid

      //return _userFromFirebaseUser(user);

    } catch (error) {
      print(error.toString());
      return error;
    }
  }

  //Google sing with new Mathod

  Future signInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication gAuth =
            await googleUser.authentication;
        if (gAuth.accessToken != null && gAuth.idToken != null) {
          UserCredential result =
              await _auth.signInWithCredential(GoogleAuthProvider.credential
                  // getCredential
                  (
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken,
          ));
          User user = result.user;
          print('Sign in with google complete: user' + user.displayName);

          // if check if user exits in users collection in database
          final DateTime timestamp = DateTime.now();

          final QuerySnapshot doc = await FirebaseFirestore.instance
              .collection("users")
              .where('uid', isEqualTo: user.uid)
              // .document(user.uid)
              .get();
          // 2 if the user doesn't sign  the mwe wqnt to create acount page
          final List<DocumentSnapshot> documents = doc.docs;

          if (documents.length == 0) {
            // 3 ) get username from create account, use it to make new user docunemt in user collection
            FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              "uid": user.uid,
              "user": user.displayName,
              "email": user.email,
              "photourl": user.photoURL,
              "timestamp": timestamp,
              "country": "",
              "state": " ",
              "district": " ",
              "block": " ",
              "village": " ",
              " pincode": " ",
              'chattingWith': null
            });

            //  doc = await Firestore.instance
            //    .collection("users") m
            //  .document(user.uid)
            //.get();

            // print(User.fromDocument(doc));

            // Write data to local
            // currentUser = user;
            await prefs.setString('id', user.uid);
            await prefs.setString('user', user.displayName);
            await prefs.setString('photoUrl', user.photoURL);
            return user;
          } else {
            // Write data to local
            await prefs.setString('uid', documents[0]['uid']);
            await prefs.setString('user', documents[0]['user']);
            await prefs.setString('thumbnailUrl', documents[0]['thumbnailUrl']);
            await prefs.setString('aboutMe', documents[0]['aboutMe']);
          }
        } else {
          throw PlatformException(code: "Error Missing", message: 'Sign again');
        }
      }
    } catch (error) {
      print(error.toString());
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
      currentUser = null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User_d> getUser() async {
    var FUser = await _auth.currentUser;
    return User_d(uid: FUser.uid, name: FUser.displayName);
  }

  Future<void> updateDisplayName(String displayName) async {
    var user = await _auth.currentUser;
    //user.updateProfile(UserUpdateInfo().displayName = displayName);
    user.updateProfile(displayName: displayName);
  }
//Sign in

}

//sign with google
