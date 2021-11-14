import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/screens/d_home.dart';
import 'package:kisan/generated/l10n.dart';



class About_as extends StatelessWidget {
  final String avatarUrl;
  final Function onTap;
  const About_as({this.avatarUrl, this.onTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: const Color(0xff0d9408)),
        ),
        title: Text(
         S.of(context).About_us,
          style: TextStyle(
              fontSize: 18.0,
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
            Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => d_home()
            ));
          },
        ),
      ),
    );
  }
}
