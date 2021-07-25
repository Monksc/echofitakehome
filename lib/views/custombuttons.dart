import 'package:flutter/material.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  SecondaryButton({@required this.onPressed, @required this.text = ''});
  @override
  Widget build(BuildContext context) {
    return CupertinoCard(
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(text),
        ),
      ),
      elevation: 2.0,
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(0.0),
      color: Colors.white,
      radius: BorderRadius.all(
        new Radius.circular(40.0),
      ),
    );
  }
}
