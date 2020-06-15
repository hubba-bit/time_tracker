import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/Services/Auth.dart';
import 'package:timetrackerapp/Services/AuthProvider.dart';

import 'HomePage.dart';
import 'app_sign_in.dart';

 class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return StreamBuilder<User>(

    stream: auth.onAuthStateChanged,
      builder: (context, snapshots){
        if(snapshots.connectionState == ConnectionState.active){
          User user = snapshots.data;
          if (user==null) {
            return SignInPage(
              //auth : auth ,
            );
          } else {
            return HomePage(
              //auth: auth,
            );
          }
    }
        else{
          return Scaffold(
            body: Center(
              child:  CircularProgressIndicator(),
            ),
          );
        }
    },

    );

  }
}