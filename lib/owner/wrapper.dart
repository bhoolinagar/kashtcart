import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/screens/d_home.dart';
import 'package:kisan/Driver/screens/d_login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _Wrapper createState() => _Wrapper();
}

class _Wrapper extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<User_d>(
      context,
    );

    //final f_user = Provider.of<F_User>(context);
    print(user);
    if (user == null) {
      return  d_login();
       // XDiPhoneXXS11Pro1();
    } else {
      return  d_home(currentId: user.uid,);
        //XDiPhoneXXS11Pro2();
    }
  }
}
