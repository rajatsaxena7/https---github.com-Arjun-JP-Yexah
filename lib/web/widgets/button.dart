import 'package:flutter/material.dart';
import 'package:yexah/web/const/color.dart';

import '../const/const.dart';

class PrimaryBtn extends StatelessWidget {
  final String btnText;
  final Function()? onpressed;
  final double? height;
  const PrimaryBtn(
      {super.key, required this.btnText, required this.onpressed, this.height});

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return Center(
      child: SizedBox(
        width: isMobileView(context)
            ? screenwidth(context) * 0.5
            : screenwidth(context) * double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConst.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(
            btnText,
            style: TextStyle(
              color: ColorConst.white,
              fontFamily: 'Nunito',
              fontSize:
                  isMobileView(context) ? 12 : screenwidth(context) * 0.012,
            ),
          ),
        ),
      ),
    );
  }
}
