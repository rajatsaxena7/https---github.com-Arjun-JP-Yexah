import 'package:flutter/material.dart';
import 'package:yexah/web/const/color.dart';

import '../const/const.dart';

class TextBtn extends StatelessWidget {
  final Function()? onpressed;
  final String text;
  const TextBtn({super.key, required this.onpressed, required this.text});

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return TextButton(
        onPressed: onpressed,
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          foregroundColor:
              MaterialStateProperty.all<Color>(ColorConst.darkGreen2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: ColorConst.primary,
            // fontWeight: FontWeight.bold,
            fontSize: isMobileView(context) ? 12 : screenwidth(context) * 0.012,
          ),
        ));
  }
}
