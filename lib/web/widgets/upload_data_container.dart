import 'package:flutter/material.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/const/const.dart';

import '../screen/home_page.dart';

class UploadData extends StatelessWidget {
  final TextEditingController controller;
  final String tittle;
  final String subtittle;
  final String buttontittle;
  final String message;
  final VoidCallback ontap;

  const UploadData(
      {super.key,
      required this.controller,
      required this.tittle,
      this.subtittle = '',
      this.buttontittle = 'Choose file',
      this.message = 'No file choosen',
      required this.ontap});
  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width <
        600; // You can adjust this threshold
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            // height: screenheight(context) * .01,
            width: isMobileView(context)
                ? screenwidth(context) * 0.45
                : screenwidth(context) * .01),
        Text(
          tittle,
          style: TextStyle(
              color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
              fontSize:
                  isMobileView(context) ? 12 : screenwidth(context) * .012),
        ),
        SizedBox(height: screenheight(context) * .01),
        subtittle != ''
            ? Padding(
                padding: EdgeInsets.only(bottom: screenheight(context) * .01),
                child: Text(
                  subtittle,
                  style: TextStyle(
                      color:
                          isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                      fontSize: isMobileView(context)
                          ? 12
                          : screenwidth(context) * .01),
                ),
              )
            : const SizedBox(),
        Center(
          child: Container(
            width: isMobileView(context)
                ? MediaQuery.of(context).size.width * 0.81
                : MediaQuery.of(context).size.width * 0.65,
            height: screenheight(context) * .07,
            padding:
                EdgeInsets.symmetric(horizontal: screenwidth(context) * .1),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isdark ? ColorConst.grey200 : ColorConst.black)),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: ontap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttontittle,
                      style: TextStyle(
                          fontSize: isMobileView(context)
                              ? 12
                              : screenwidth(context) * .011,
                          color: Colors.white),
                    )),
                SizedBox(width: screenwidth(context) * .05),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: isMobileView(context)
                          ? 12
                          : screenwidth(context) * .011,
                      color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
