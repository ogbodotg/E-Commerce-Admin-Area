import 'dart:async';

import 'package:ahia_admin/Pages/HomeScreen.dart';
import 'package:ahia_admin/Pages/LoginPage.dart';
import 'package:ahia_admin/Services/Firebase_Services.dart';
import 'package:ahia_admin/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        // backgroundColor: Color(0xFF84c225),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Wiwa Admin',
                  style: TextStyle(
                      fontFamily: 'Signatra',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white)),
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
