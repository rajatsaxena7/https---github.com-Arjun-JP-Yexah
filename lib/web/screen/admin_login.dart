// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/screen/forget_password.dart';
import 'package:yexah/web/screen/home_page.dart';
import 'package:yexah/web/widgets/button.dart';
import 'package:yexah/web/widgets/dashboard.dart';
import 'package:yexah/web/widgets/deals.dart';
import 'package:yexah/web/widgets/text.dart';
import 'package:yexah/web/widgets/text_field.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import 'login_screen.dart';

class AdminLoginWeb extends StatefulWidget {
  const AdminLoginWeb({super.key});

  @override
  State<AdminLoginWeb> createState() => _AdminLoginWebState();
}

final adminemailcontroller = TextEditingController();
final adminpwdcontroller = TextEditingController();
bool isloading = false;
bool showpassword = true;

class _AdminLoginWebState extends State<AdminLoginWeb> {
  @override
  void dispose() {
    adminemailcontroller.dispose();
    adminpwdcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setdarkmode();
    super.initState();
  }

  setdarkmode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool mode = prefs.getBool('darkmode') ?? false;
    const int admin = 1;
    // prefs.getInt('Admin');
    setState(() {
      isdark = mode;
      isadmin = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
      bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width < 600;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: isdark ? ColorConst.scaffoldDark : ColorConst.white,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          child: Center(
            child: Container(
              height: screenheight(context) * 1,
              width:  isMobileView(context)
                  ? screenwidth(context) * .8
                  : screenwidth(context) * .3,
              decoration: BoxDecoration(
                  color: isdark ? ColorConst.black : ColorConst.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 114, 33)),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset('assets/images/yexah_logo.png',
                            fit: BoxFit.fill,
                            height: screenheight(context) * 0.3,
                            width: screenwidth(context) * 0.3),
                      ),
                      Center(
                        child: Texttxt(
                          text: 'Admin Sign In',
                          color: isdark ? ColorConst.white : ColorConst.black,
                          fontsize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenheight(context) * 0.07,
                      ),
                      Texttxt(
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textColor,
                        fontsize: 20,
                        text: 'Email',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: screenheight(context) * 0.01,
                      ),
                      Textfld(
                          hintText: 'Enter your email here',
                          controller: adminemailcontroller),
                      SizedBox(
                        height: screenheight(context) * 0.02,
                      ),
                      Texttxt(
                        text: 'Password',
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textColor,
                        fontsize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: screenheight(context) * 0.01,
                      ),
                      Textfld(
                          hintText: 'Enter Password',
                          controller: adminpwdcontroller,
                          sufixicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpassword = !showpassword;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye)),
                          obscuretext: showpassword),
                      SizedBox(
                        height: screenheight(context) * 0.015,
                      ),
                      PrimaryBtn(
                          btnText: isloading ? "Loading" : "Sign in",
                          onpressed: () async {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              var url = Uri.parse(
                                  'https://deals.yexah.com:3000/login/admin');
                              var body = jsonEncode({
                                "email": adminemailcontroller.text,
                                "password": adminpwdcontroller.text
                              });

                              var responselogin =
                                  await http.post(url, body: body, headers: {
                                'Content-Type': 'application/json',
                                'Accept': '*/*',
                              });

                              Map res = jsonDecode(responselogin.body);

                              if (responselogin.statusCode == 200) {
                                setState(() {
                                  isloading = false;
                                });
                                initialtabs = ConfigPage.zero;
                                final userid = res['user']['id'];
                                final token = res["token"].toString();
                                final isadmin = res['user']["isAdmin"];

                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt('UserID', userid);
                                await prefs.setString('Token', token);
                                await prefs.setInt('Admin', isadmin);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePageWeb()),
                                    (route) => false);
                              } else {
                                setState(() {
                                  isloading = false;
                                });
                                Map error = jsonDecode(responselogin.body);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(error["message"].toString())));
                              }
                            } catch (error) {
                              setState(() {
                                isloading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No User Found')));
                            }

                            setState(() {
                              isloading = false;
                            });
                          }),
                      SizedBox(
                        height: screenwidth(context) * 0.01,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.person_2_rounded,
                              color: ColorConst.primary),
                          SizedBox(
                            width: screenwidth(context) * 0.01,
                          ),
                          TextBtn(
                              onpressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreenWeb(),
                                    ));
                              },
                              text: 'User Sign in'),
                        ],
                      ),
                      SizedBox(
                        height: screenwidth(context) * 0.01,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.lock,
                            color: ColorConst.primary,
                            size: 17,
                          ),
                          SizedBox(
                            width: screenwidth(context) * 0.01,
                          ),
                          TextBtn(
                              onpressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPAsswordWeb()),
                                    (route) => false);
                              },
                              text: 'Forget your password'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
