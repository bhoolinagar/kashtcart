import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/LandingUtils.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier {
  //StorageUploadTask
  UploadTask imageUploadTask;

  Future uploadUserAvatar(BuildContext context) async {
    // StorageReference
    Reference imageRefe = FirebaseStorage.instance.ref().child(
        'user/profile/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');

    await imageUploadTask.whenComplete;
    imageRefe.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          "the user profile avatar => ${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}");
      notifyListeners();
    });
  }
}
