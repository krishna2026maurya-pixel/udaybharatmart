import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/size.dart';

TextTheme commonTextTheme = const TextTheme(
  displayLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.xxxl,
  ),
  displayMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.xl,
  ),
  displaySmall: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.lg,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.sm,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.md - 1.0,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.sm,
  ),
  labelLarge: TextStyle(
    fontSize: FontSize.xl,
    fontWeight: FontWeight.w600,
  ),
);

const smallText = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: FontSize.sm,

);

const smallMediumText = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: FontSize.sm,
  color: Colors.black,

);

const mediumText = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: FontSize.md,

);

const mediumLargeText = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: FontSize.mdL,

);
const largeText = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: FontSize.lg,
  color: Colors.white,
);

const textFieldText = TextStyle(
  fontSize: FontSize.mdL,
  fontWeight: FontWeight.w400,
);
const labelHint = TextStyle(
  fontSize: FontSize.md,
  fontWeight: FontWeight.normal,
  height: 1.1,
);

const buttonStyle = TextStyle(
  fontSize: FontSize.mdL,
  height: 1.2,
  fontWeight: FontWeight.w400,
);
