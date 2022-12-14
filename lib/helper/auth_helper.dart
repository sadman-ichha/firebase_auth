import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/views/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  final box = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _OTPController = TextEditingController();

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

  Future signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential _userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    User? _user = _userCredential.user;

    if (_user!.uid.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      print("something is wrong");
    }
  }

  phoneAuth(number, context) async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential _userCredential =
              await auth.signInWithCredential(credential);
          User? _user = _userCredential.user;
          if (_user!.uid.isNotEmpty) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          } else {
            print("failed");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Enter your OTP"),
                    content: Column(
                      children: [
                        TextField(
                          controller: _OTPController,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              PhoneAuthCredential _phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: _OTPController.text);

                              UserCredential _userCredential = await auth
                                  .signInWithCredential(_phoneAuthCredential);
                              User? _user = _userCredential.user;
                              if (_user!.uid.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()));
                              } else {
                                print("failed");
                              }
                            },
                            child: Text("Verify")),
                      ],
                    ),
                  ));
        },
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {});
  }
}
