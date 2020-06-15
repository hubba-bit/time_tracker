import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/Services/AuthProvider.dart';
import 'package:timetrackerapp/Widget/platformAlertDialog.dart';

enum FormType {signin , register}


class EmailSignIn extends StatefulWidget {

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

final FocusNode _emailFocusNode = FocusNode();
final FocusNode _passFocusNode= FocusNode();
String get _email => _emailController.text;
String get _password => _passwordController.text;

  FormType _formType = FormType.signin;
  bool _isLoading = false;

 // String email;
  List<Widget> _buildChildren(){

    final primaryText = _formType ==FormType.signin ? 'Sign in' : 'Create your account';
    // ignore: non_constant_identifier_names
    final SecondaryText = _formType ==FormType.signin ? 'Need an account' : ' already have an account';
    bool submitEnabled = _email.isNotEmpty && _password.isNotEmpty;

    return[
      TextField(
        controller: _emailController,

  focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@gmail.com'
        ),
       autocorrect: false,
       // onChanged: (value) => email = value ,

      keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
     onEditingComplete: _emailEditingDone,
        onChanged: (email)=> _updateState(),
      ),

      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
      focusNode: _passFocusNode,
        decoration: InputDecoration(
          labelText: 'password',
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete:_submit,
        onChanged: (password) => _updateState,
      ),
      SizedBox(
        height: 8.0,
      ),
      RaisedButton(

        child: Text(primaryText),
        onPressed: submitEnabled? _submit : null,
        color: Colors.orange,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(SecondaryText),
        onPressed: _toggleFormType,
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void _submit() async{
    setState(() {
      _isLoading = true;
    });
try{
  final auth = AuthProvider.of(context);
//print('email : ${_emailController.text }, password : ${_password.text}');
if(_formType == FormType.signin){
  await auth.signInWithEmailPassword(_email,_password);
}
else{
  await auth.createUserWithEmailPassword(_email, _password);
}
Navigator.of(context).pop();
  }
   catch(e){
PlatformAlertDialog(
  title:
  'Sign in failed',
    content : e.toString() ,
    defaultAction: 'ok',
  cancel :'Cancel',
).show(context);
  } finally {
  setState((){
      _isLoading = false;
      });
}
  }
  void _toggleFormType(){
    setState(() {
      _formType = _formType == FormType.signin ? FormType.register : FormType.signin;
    });
  }

  void _emailEditingDone() {
    FocusScope.of(context).requestFocus(_passFocusNode);
  }

 void  _updateState() {
    print('email :$_email, password :$_password');
    setState(() {

    });
  }
}
