import 'package:flutter/material.dart';
import 'package:timetrackerapp/Services/Auth.dart';
import 'package:timetrackerapp/Services/AuthProvider.dart';
import 'package:timetrackerapp/Widget/platformAlertDialog.dart';

class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmedSignOut (BuildContext context) async{
    final didRequestSignOut = await PlatformAlertDialog(
      title:  'Logout',
      content: 'Are You sure you want to log out',
      defaultAction: 'logout',
      cancel: 'No',
    ).show(context);
    if(didRequestSignOut)
      _signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HomePage',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          FlatButton(

            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmedSignOut(context),

          )
        ],
      ),
    );
  }
}
