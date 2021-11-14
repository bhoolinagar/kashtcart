import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/locator.dart';

import 'authenicatte.dart';
import 'm_helper.dart';

class StorageRepo {
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: 'gs://sign-d1888.appspot.com');
  AuthService _authService = locator.get<AuthService>();

  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("user", isEqualTo: username)
        .snapshots();
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUsername = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("user", isEqualTo: username)
        .get();
  }

  Future<String> uploadFile(File file) async {
    String downloadur;
    var user = await _authService.user;
    Reference storageRef = storage.ref().child("user/profile/$user.uid");
    var uploadtask = storageRef.putFile(file);
    await uploadtask.whenComplete(() {
      downloadur = storageRef.getDownloadURL() as String;
    }).catchError((e) {
      print(e);
    });
    // String downloadUrl = await completeTask.;
    //ref.getDownloadURL();
    return downloadur;
  }

  Future<String> getUserProfileImageDownloadUrl(String uid) async {
    var storageRef = storage.ref().child('user/profile/$uid');
    return await storageRef.getDownloadURL();
  }

  Future loadingImage(BuildContext context, String ImageUrl) async {
    var storageRef = storage.ref().child("image").child("tractorl.png");
    return await storageRef.getDownloadURL();
  }

  UserData(String uid, String name, String email, String password) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'user': name, 'email': email, "uid": uid, "password": password});
  }

  addConversataionMessage(String chatroomId, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversataionMessage(String chatroomId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatroomId)
        .collection('chats')
        .doc(chatroomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future updateuserData(
      String uid,
      String name,
      String mobile,
      String country,
      String state,
      String district,
      String block,
      String pincode,
      String village) async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'user': name,
      'mobile': mobile,
      'country': country,
      'state': state,
      'district': district,
      'block': block,
      "pincode": pincode,
      "village": village,
    });
  }
}
