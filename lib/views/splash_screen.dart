import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fire/views/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'sign_up_screen.dart';

class SplashScreen extends StatelessWidget {
  final box = GetStorage();

  chooseScreen(context) async {
    var userID = box.read('id');
    if (userID != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SingupScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () => chooseScreen(context));

    return Scaffold(
      body: Center(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80.0,
                width: 80.0,
                child: Image.asset("assets/firebase_logo.png")),
            SizedBox(
              width: 5.0,
            ),
            Text(
              "Firebase",
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }
}
