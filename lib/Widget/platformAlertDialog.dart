import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:timetrackerapp/Widget/platformWidget.dart';

class PlatformAlertDialog extends PlatFormWidget {
  final String title;
  final String content;
  final String defaultAction;
  final String cancel;
  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.defaultAction,
      @required this.cancel})
      : assert(title != null),
        assert(content != null),
        assert(defaultAction != null);

  Future<bool> show(BuildContext context) async{
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(context: context, builder:  (context) => this)

: await showDialog<bool>(context: context,
    //barrierDismissible: false,
    builder: (context) => this ,);
  }


  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title :Text(title),
    content : Text(content),
    actions : _buildActions(context),
    );


  }

  @override
  Widget buildMaterialWidget (BuildContext context){
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List <Widget> _buildActions (BuildContext context){
    final actions = <Widget> [];
    if(cancel != null ){
      actions.add(PlatformAlertDialogAction(
          child: Text(cancel),
      onpressed : () => Navigator.of(context).pop(false),
      ),
      );
    }
    actions.add(PlatformAlertDialogAction(
    child:Text (defaultAction),
    onpressed:() => Navigator.of(context).pop(true),),
    );
    return actions;
  }

}

class PlatformAlertDialogAction extends PlatFormWidget{
  final Widget child;
  final VoidCallback onpressed;
  PlatformAlertDialogAction({this.child, this.onpressed});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
return CupertinoDialogAction(
  child: child,
  onPressed: onpressed,
);}

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    return FlatButton(
      child:  child,
      onPressed: onpressed,
    );
  }
}


