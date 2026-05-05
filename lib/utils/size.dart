
import 'package:flutter/cupertino.dart';

class MyFontSize {

  static double size24=24;

  final double h;
  final double w;

  MyFontSize(BuildContext context):
        h= MediaQuery.of(context).size.height,
        w=MediaQuery.of(context).size.width;

}


class FontSize {
  FontSize._();


  static const xxxs = 9.0;


  static const xxs = 10.0;


  static const xs = 12.0;


  static const sm = 13.0;


  static const smL = 15.0;


  static const md = 16.0;


  static const mdL = 17.0;


  static const lg = 18.0;


  static const xl = 20.0;


  static const xl0 = 22.0;


  static const xl2 = 24.0;


  static const xl3 = 26.0;


  static const xl4 = 28.0;


  static const xxl = 30.0;


  static const xxl2 = 34.0;


  static const xxxl = 40.0;
}
