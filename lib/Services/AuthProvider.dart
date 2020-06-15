import 'package:flutter/material.dart';

import 'Auth.dart';
class AuthProvider extends InheritedWidget{
  final AuthBase auth;
  final Widget child;
   AuthProvider({this.auth , @required this.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
   return false;
  }
   static AuthBase of(BuildContext context){
    AuthProvider provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();

return provider.auth;   }
}