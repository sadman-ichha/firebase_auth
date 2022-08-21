import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/helper/auth_helper.dart';
import 'package:flutter_fire/views/log_in_screen.dart';
import 'package:flutter_fire/views/phone_auth_screen.dart';

class SingupScreen extends StatelessWidget {
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _emailEditingController,
              decoration: InputDecoration(hintText: "email"),
            ),
            TextFormField(
              controller: _passEditingController,
              decoration: InputDecoration(hintText: "password"),
            ),
            ElevatedButton(
                onPressed: () {
                  final email = _emailEditingController.text;
                  final pass = _passEditingController.text;
                  var obj = AuthHelper();
                  obj.SignUp(email, pass, context);
                },
                child: Text("Sing up")),
            RichText(
              // ignore: prefer_const_constructors
              text: TextSpan(
                  text: "Already have an account?",
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: " Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ]),
            ),
            ElevatedButton(
                onPressed: () => AuthHelper().signInWithGoogle(context),
                child: Text("Login With Google")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PhoneAuthScreen()));
                },
                child: Text("Phone"))
          ],
        ),
      ),
    );
  }
}
