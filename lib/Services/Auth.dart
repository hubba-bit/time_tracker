import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;

  User({@required this.uid});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailPassword(String email, String password);
  Future<User> createUserWithEmailPassword(String email, String password);
  Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> get onAuthStateChanged {
    return _fireBaseAuth.onAuthStateChanged.map(_userFromFireBase);
  }

  User _userFromFireBase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Future<User> CurrentUser() async {
    final returnedUser = await _fireBaseAuth.currentUser();
    return _userFromFireBase(returnedUser);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _fireBaseAuth.signInAnonymously();
    return _userFromFireBase(authResult.user);
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _fireBaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      return _userFromFireBase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR ABORTED BY USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _fireBaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFireBase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing google auth Token ',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'you Aborted the sign in ',
      );
    }
  }

  @override
  Future<User> signInWithEmailPassword(String email, String password) async {
    final authResult = await _fireBaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _userFromFireBase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailPassword(
      String email, String password) async {
    final authResult = await _fireBaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFireBase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _fireBaseAuth.signOut();
  }

  @override
  Future<User> currentUser() {
    // TODO: implement currentUser
    return null;
  }
}
