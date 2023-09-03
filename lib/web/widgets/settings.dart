import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/screen/home_page.dart';
import '../const/const.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  final BuildContext ctx;
  const Settings({super.key, required this.ctx});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name = "User";
  String email = "email";
  @override
  void initState() {
    Updatedetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

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
          padding: EdgeInsets.all(
            screenwidth(context) * .01,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenheight(context) * .05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                ),
                SizedBox(height: screenheight(context) * .065),
                Text(
                  'Create a new user profile.',
                  style: TextStyle(
                    fontSize: isMobileView(context)
                        ? 14
                        : screenwidth(context) * 0.015,
                    fontFamily: 'Nunito',
                    color: isdark ? ColorConst.white : ColorConst.black,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: isMobileView(context)
                      ? screenwidth(context)
                      : screenwidth(context) * .8,
                  height: screenheight(context) * .35,
                  padding: EdgeInsets.symmetric(
                      vertical: screenheight(widget.ctx) * .025,
                      horizontal: screenheight(widget.ctx) * .025),
                  decoration: BoxDecoration(
                      color: isdark
                          ? ColorConst.scaffoldDarklite
                          : ColorConst.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Text('User Name',
                                      style: TextStyle(
                                        color: isdark
                                            ? ColorConst.white
                                            : ColorConst.black,
                                        fontSize: isMobileView(context)
                                            ? 14
                                            : screenwidth(context) * 0.01,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    thickness: 1,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Text('Email ID',
                                      style: TextStyle(
                                          color: isdark
                                              ? ColorConst.white
                                              : ColorConst.black,
                                          fontSize: isMobileView(context)
                                              ? 14
                                              : screenwidth(context) * 0.01,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Text(
                                    email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Text('Role',
                                      style: TextStyle(
                                          color: isdark
                                              ? ColorConst.white
                                              : ColorConst.black,
                                          fontSize: isMobileView(context)
                                              ? 14
                                              : screenwidth(context) * 0.01,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Text(
                                    isadmin == 1 ? 'Super Admin' : 'User',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConst.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            'Add User',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobileView(context)
                                  ? 14
                                  : screenwidth(context) * 0.01,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
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
      print(response.body);
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
