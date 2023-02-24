import 'dart:math';

import 'package:flutter/material.dart';

class DualLinearProgressIndicator extends StatelessWidget {
  final double maxValue;
  final double progressValue;
  final double addValue;
  final Color mainColor;
  final Color addColor;

  const DualLinearProgressIndicator({
    Key? key,
    required this.maxValue,
    required this.progressValue,
    required this.addValue,
    this.mainColor = const Color(0xFF00338D),
    this.addColor = const Color(0xFFEBB700),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          Container(
            color: Colors.grey[300],
            height: 32,
            width: double.infinity,
          ),
          FractionallySizedBox(
            widthFactor: min((addValue + progressValue) / maxValue, 1),
            child: Container(
              color: addColor,
              height: 32,
            ),
          ),
          FractionallySizedBox(
            widthFactor: min((progressValue / maxValue), 1),
            child: Container(
              color: mainColor,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}
