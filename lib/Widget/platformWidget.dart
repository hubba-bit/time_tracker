import 'package:flutter/material.dart';
import 'dart:io';
abstract class PlatFormWidget extends StatelessWidget {
 Widget buildCupertinoWidget (BuildContext context);
 Widget buildMaterialWidget (BuildContext context);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildCupertinoWidget(context);

    }
    return buildMaterialWidget(context);
  }
}
