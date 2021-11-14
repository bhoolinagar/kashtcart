import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan/generated/l10n.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xffffffff),
      child: Center(
        child: AlertDialog(
          backgroundColor: Color(0xfff5d7bd),
          title: Container(
            height: 50,
            width: 50,
            child: Row(
              children: [
                Text(
                  S.of(context).loading,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 50),
                SpinKitCircle(
                  color: Colors.green,
                  size: 50.0,
                )
              ],
            ),
          ),
          titlePadding: const EdgeInsets.only(top: 20, left: 20),
        ),
      ),
    );
  }
}

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Container(
          color: Color(0xffffffff),
          child: Column(
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 250,
                // color: Colors.red,
                // margin: EdgeInsets.fromLTRB(160, 10, 0, 40),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/internat.png'))),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                S.of(context).internet_off,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff327d0c)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(S.of(context).internet_on
                ,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff327d0c)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
