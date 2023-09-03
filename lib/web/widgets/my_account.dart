import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';
import 'package:http/http.dart' as http;

class MyAccounts extends StatefulWidget {
  final BuildContext ctx;
  const MyAccounts({super.key, required this.ctx});

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width <
        600; // You can adjust this threshold
  }

  @override
  void initState() {
    Updatedetails();
    super.initState();
  }

  String name = '';

  String email = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isMobileView(context)
              ? screenwidth(context)
              : MediaQuery.of(context).size.width * 0.789,
          height: screenheight(widget.ctx) * 0.85,
          color: isdark
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: EdgeInsets.all(screenwidth(context) * .01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 35),
                child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
              ),
              SizedBox(height: screenheight(context) * .05),
              Center(
                child: Container(
                  width: screenwidth(widget.ctx),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(screenwidth(context) * .01),
                    color:
                        isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenwidth(context) * .01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "@$name",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: isMobileView(context)
                                    ? screenwidth(context) * 0.06
                                    : screenwidth(context) * 0.02,
                                fontWeight: FontWeight.bold,
                                color: ColorConst.primary),
                          ),
                        ),
                        SizedBox(height: screenheight(context) * .035),
                        Text('About',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                color: isdark
                                    ? ColorConst.white
                                    : ColorConst.black,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01,
                                fontWeight: FontWeight.bold)),
                        Divider(
                            color: ColorConst.primary,
                            endIndent: screenwidth(context) * 0.7),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Contact Name :          ',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    )),
                                SizedBox(width: screenheight(widget.ctx) * .1),
                                Text(name ?? "Name",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: isdark
                                            ? ColorConst.white
                                            : ColorConst.textColor,
                                        fontSize: isMobileView(context)
                                            ? 14
                                            : screenwidth(context) * 0.01)),
                                SizedBox(
                                    height: screenheight(widget.ctx) * .025),
                              ],
                            ),
                            SizedBox(height: screenheight(widget.ctx) * .025),
                            Row(
                              children: [
                                Text('Display Name :           ',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    )),
                                SizedBox(width: screenheight(widget.ctx) * .1),
                                Text(name ?? "Name",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: isdark
                                            ? ColorConst.white
                                            : ColorConst.textColor,
                                        fontSize: isMobileView(context)
                                            ? 14
                                            : screenwidth(context) * 0.01)),
                                SizedBox(
                                    height: screenheight(widget.ctx) * .025),
                              ],
                            ),
                            SizedBox(height: screenheight(widget.ctx) * .025),
                            Row(
                              children: [
                                Text('Contact Email :           ',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    )),
                                SizedBox(width: screenheight(widget.ctx) * .1),
                                Text(email ?? 'Email',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: isdark
                                            ? ColorConst.white
                                            : ColorConst.textColor,
                                        fontSize: isMobileView(context)
                                            ? 14
                                            : screenwidth(context) * 0.01)),
                                SizedBox(
                                    height: screenheight(widget.ctx) * .02),
                              ],
                            ),
                            SizedBox(height: screenheight(widget.ctx) * .025),
                            Row(
                              children: [
                                Text('Contact Number :        ',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    )),
                                SizedBox(width: screenheight(widget.ctx) * .1),
                                Text('**********',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: isdark
                                            ? ColorConst.white
                                            : ColorConst.textColor,
                                        fontSize: isMobileView(context)
                                            ? 14
                                            : screenwidth(context) * 0.01)),
                                SizedBox(
                                    height: screenheight(widget.ctx) * .025),
                                IconButton(
                                    iconSize: screenwidth(context) * .01,
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                            Row(
                              children: [
                                Text('Business  Email :          ',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    )),
                                SizedBox(width: screenheight(widget.ctx) * .09),
                                Text(email ?? 'email',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: isdark
                                            ? ColorConst.white
                                            : ColorConst.textColor,
                                        fontSize: isMobileView(context)
                                            ? 14
                                            : screenwidth(context) * 0.01)),
                                SizedBox(
                                    height: screenheight(widget.ctx) * .02),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const FooterCon()
      ],
    );
  }

  Future<void> Updatedetails() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = await prefs.getInt('UserID');
      // print(id.toString());
      final response = await http.post(
        Uri.parse("https://deals.yexah.com:3000/getusers/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        Map res = jsonDecode(response.body);

        setState(() {
          name = res["fullname"];
          email = res["email"].toString();
        });
      } else {
        setState(() {
          name = 'User';
          email = 'Email';
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
