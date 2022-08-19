import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/helper/auth_helper.dart';
import 'package:flutter_fire/views/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
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
                final password = _passEditingController.text;
                var obj = AuthHelper();
                obj.LogIn(email, password, context);
              },
              child: Text("Login"),
            ),
            RichText(
              // ignore: prefer_const_constructors
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: " Singup",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SingupScreen()),
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
          ],
        ),
      ),
    );
  }
}
