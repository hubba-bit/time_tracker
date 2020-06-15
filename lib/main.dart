import 'package:flutter/material.dart';
import 'package:timetrackerapp/Screens/emailLogin.dart';
import 'package:timetrackerapp/Services/Auth.dart';
import 'package:timetrackerapp/Services/AuthProvider.dart';
import 'Screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth:Auth(),

    child: MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.red,
        accentColor: Colors.green,

      ),
      home: LandingPage(
      //  auth: Auth(),
      ),
      ),
    );
  }
}
