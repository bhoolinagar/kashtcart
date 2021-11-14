import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/main.dart';

class Splash_screen extends StatefulWidget {
  _Splash_screen createState() => _Splash_screen();
}

class _Splash_screen extends State<Splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => IsInternet())));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff3B9412),
      body: MaterialButton(
        // onPressed: () {
        // Navigator.of(context)
        //   .push(MaterialPageRoute(builder: (context) => IsInternet()));
        //},
        child: Container(
          alignment: Alignment.center,
          // padding: const EdgeInsets.only(top: 300, left: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.only(bottom: 40),
                // color: Color(0xffac1414),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: AssetImage("assets/KC logo.png"),
                      fit: BoxFit.cover),
                ),
                child: Image.asset('assets/ram1.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome to Kashtcart",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffffffff)),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        //  alignment: Alignment.center,
        color: Color(0xff3B9412),
        child: Text("Powered by Kashtcart",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
