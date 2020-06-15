import 'package:flutter/material.dart';
import 'package:timetrackerapp/Screens/email_Sign_In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetrackerapp/Services/Auth.dart';

class EmailLogin extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
          elevation: 10.0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: EmailSignIn(
              ),
            )));
  }
}
