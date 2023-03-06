import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomTextSize {
  static TextStyle large = TextStyle(fontSize: 30);
  static TextStyle medium = TextStyle(fontSize: 24);
  static TextStyle small = TextStyle(fontSize: 16);
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
