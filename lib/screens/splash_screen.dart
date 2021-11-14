import 'dart:async';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FINANCE',
                style: kTitleText,
              ),
              Text(
                'BUDDY',
                style: kTitleText,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Finance Made Easy',
                style:TextStyle(
                  color:Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
                )
              ),
              SizedBox(
                height: 20.0,
              ),
              CircularProgressIndicator(color: kPrimaryColor)
            ],
          )
      ),
    );
  }
}
