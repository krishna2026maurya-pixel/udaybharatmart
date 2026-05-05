import 'package:flutter/material.dart';
class CustomProgressBar extends StatelessWidget {
  final Color? color;
  const CustomProgressBar({Key? key,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: CircularProgressIndicator(
        valueColor:AlwaysStoppedAnimation<Color>(color??Colors.white),
        strokeWidth: 2.0,
      )
    );
  }
}
