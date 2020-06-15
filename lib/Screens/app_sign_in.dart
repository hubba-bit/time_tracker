import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/Screens/emailLogin.dart';
import 'package:timetrackerapp/Services/AuthProvider.dart';
import 'package:timetrackerapp/Widget/customraisedbtn.dart';



class SignInPage extends StatelessWidget {


  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signInAnonymously();
    }
    catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);

      await auth.signInWithGoogle();
    }
    catch (e) {
      print(e.toString());
    }
  }
  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);

      await auth.signInWithFacebook();
    }
    catch (e) {
      print(e.toString());
    }
  }

void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder:(context) => EmailLogin(
      ),
      ),);
print('done');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
        // actions: <Widget>[
        // Text('logout'),
        //],
      ),
      body: _bodyContent( context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          customRaisedBtn(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset('images/google-logo.png'),
                Text(
                  'Sign In with Google',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                Opacity(
                    opacity: 0.0, child: Image.asset('images/google-logo.png')),
              ],
            ),
            color: Colors.white,
            onPressed: () => _signInWithGoogle(context),
            borderRadius: 4.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          customRaisedBtn(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset('images/facebook-logo.png'),
//                SizedBox(
//                  height: 0.1,
//                ),
                Text(
                  'Sign in With Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Opacity(
                    opacity: 0.0,
                    child: Image.asset('images/facebook-logo.png')),
              ],
            ),
            color: Colors.indigo,
            onPressed: () =>_signInWithFacebook(context),//_signInWithFacebook,
            borderRadius: 4.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          customRaisedBtn(
            child: Text(
              'Sign in With Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            color: Colors.orange,
            onPressed: () => _signInWithEmail(context),
            borderRadius: 4.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'OR',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          customRaisedBtn(
            child: Text(
              'Create your Account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            color: Colors.green,
            onPressed: () =>_signInAnonymously(context),
            borderRadius: 4.0,
          ),
        ],
      ),
    );
  }

}



