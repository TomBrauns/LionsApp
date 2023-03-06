import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomTextStyles {
  static TextStyle headlineLarge = TextStyle(fontSize: 30);
  static TextStyle titleLarge = TextStyle(fontSize: 24);
  static TextStyle titleMedium = TextStyle(fontSize: 20);
}

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
