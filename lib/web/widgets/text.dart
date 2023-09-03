import 'package:flutter/material.dart';

class Texttxt extends StatelessWidget {
  final String text;
  final Color color;
  final double fontsize;
  final FontWeight? fontWeight;

  const Texttxt(
      {super.key,
      required this.color,
      required this.fontsize,
      required this.text,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'Nunito'),
    );
  }
}
