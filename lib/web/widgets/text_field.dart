import 'package:flutter/material.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/screen/home_page.dart';

import '../const/const.dart';

class Textfld extends StatelessWidget {
  final String hintText;
  final bool obscuretext;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? sufixicon;
  const Textfld(
      {super.key,
      required this.hintText,
      this.controller,
      this.obscuretext = false,
      this.validator,
      this.sufixicon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenheight(context) * 0.08,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            color: isdark ? ColorConst.textdarkw : ColorConst.textliteb),
        validator: validator,
        obscureText: obscuretext,
        cursorColor: ColorConst.grey800,
        decoration: InputDecoration(
            suffixIcon: sufixicon,
            hoverColor: ColorConst.grey800,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: ColorConst.primary,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'Nunito')),
      ),
    );
  }
}
