import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LandingUtils with ChangeNotifier {
  final picker = ImagePicker();

  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;
  Future pickeruserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null
        ? print("select Image")
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    //  userAvatar != null
    //   ? Provider.of<D_Profile>(context, listen: false).showUserAvatar(context)
    // : print("Image upload error");
  }

  Future selectAvataroption(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Divider(
                  thickness: 4.0,
                  color: Colors.orangeAccent,
                ),
                Row(
                  children: [
                    MaterialButton(
                      child: Text(
                        "Gallary",
                        style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange),
                      ),
                      onPressed: () {
                        //   pickeruserAvatar(context, ImageSource.gallery)
                        //    .whenComplete(() {
                        //   Navigator.pop(context);
                        //  Provider.of<D_Profile>(context, listen: false)
                        //     .showUserAvatar(context);
                        //     .showUserAvatar(context);
                        //  }
                        //  );
                      },
                    ),
                    MaterialButton(
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange),
                      ),
                      onPressed: () {
                        //pickeruserAvatar(context, ImageSource.camera)
                        //   .whenComplete(() {
                        //Navigator.pop(context);
                        //Provider.of<D_Profile>(context)
                        // .showUserAvatar(context);
                        // });
                      },
                    )
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }


}
