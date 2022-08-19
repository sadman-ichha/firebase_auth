import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/views/home_screen.dart';
import 'package:get_storage/get_storage.dart';

class AuthHelper {
  final box = GetStorage();

  Future SignUp(emailAddress, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      var authCredential = userCredential.user;
      print(authCredential);

      if (authCredential!.uid.isNotEmpty) {
        box.write('id', authCredential.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        print("signUp failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("'The password provided is too weak.'");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future LogIn(emailAddress, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      var authCredential = userCredential.user;
      print(authCredential);

      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
      } else {
        print("Login failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}
