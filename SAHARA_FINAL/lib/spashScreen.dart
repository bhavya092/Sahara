import 'package:flutter/material.dart';
//import 'sign_in.dart';
//import 'dart:async';

class SplashScreen extends StatelessWidget {
  static const routeName = 'route11';
  @override
  Widget build(BuildContext context) {
    /*   Timer(Duration(seconds: 0), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => SignIn()));
    });
*/
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      // child:Image.asset('image/bg.png',fit: BoxFit.cover,) ,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/bg1.jpg'), fit: BoxFit.cover)),
    );
  }
}
