import 'package:flutter/material.dart';

class customRaisedBtn extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final Widget child;
  final VoidCallback onPressed;

  customRaisedBtn(
      {@required this.color,
      this.borderRadius,
      this.child,
      @required this.onPressed})
      : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        )
      ),

    );
  }
}
