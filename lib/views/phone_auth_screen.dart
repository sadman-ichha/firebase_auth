import 'package:flutter/material.dart';
import 'package:flutter_fire/helper/auth_helper.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneAuthScreen extends StatelessWidget {
  TextEditingController _numEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _numEditingController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Enter your phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: () {
                  AuthHelper().phoneAuth(_numEditingController.text, context);
                },
                child: Text("Request OTP")),
          ],
        ),
      ),
    );
  }
}
