// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/screen/home_page.dart';
import 'package:yexah/web/screen/sign_up_page.dart';
import 'package:yexah/web/widgets/button.dart';
import 'package:yexah/web/widgets/dashboard.dart';
import 'package:yexah/web/widgets/text.dart';
import 'package:yexah/web/widgets/text_field.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import '../widgets/deals.dart';
import 'admin_login.dart';
import 'forget_password.dart';

class LoginScreenWeb extends StatefulWidget {
  const LoginScreenWeb({super.key});

  @override
  State<LoginScreenWeb> createState() => _LoginScreenWebState();
}

class _LoginScreenWebState extends State<LoginScreenWeb> {
  final emailcontroller = TextEditingController();
  final pwdcontroller = TextEditingController();
  final loginformKey = GlobalKey<FormState>();
  bool isloading = false;
  bool showpassword = true;

  @override
  void dispose() {
    emailcontroller.dispose();
    pwdcontroller.dispose();
    super.dispose();
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
              width: isMobileView(context)
                  ? screenwidth(context) * .8
                  : screenwidth(context) * .3,
              decoration: BoxDecoration(
                  color: isdark ? ColorConst.black : ColorConst.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 114, 33)),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Form(
                  key: loginformKey,
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
                            text: 'Sign In',
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontsize: 25,
                            fontWeight: FontWeight.w900,
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
                          text: 'Email*',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: screenheight(context) * 0.01,
                        ),
                        Textfld(
                            hintText: 'Enter your email here',
                            controller: emailcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid email address.';
                              }
                              return null;
                            }),
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
                            controller: pwdcontroller,
                            sufixicon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showpassword = !showpassword;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                            obscuretext: showpassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid password.';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: screenheight(context) * 0.015,
                        ),
                        PrimaryBtn(
                            btnText: isloading ? "Loading" : "Sign in",
                            onpressed: () async {
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const HomePageWeb()),
                              //     (route) => false);
                              setState(() {
                                isloading = true;
                              });

                              if (loginformKey.currentState!.validate()) {
                                loginformKey.currentState!.save();
                                try {
                                  var url = Uri.parse(
                                      'https://deals.yexah.com:3000/login');
                                  var body = jsonEncode({
                                    "email": emailcontroller.text,
                                    "password": pwdcontroller.text
                                  });

                                  var responselogin = await http
                                      .post(url, body: body, headers: {
                                    'Content-Type': 'application/json',
                                    'Accept': '*/*',
                                  });

                                  Map res = jsonDecode(responselogin.body);
                                  print(res);
                                  // print(responselogin.statusCode);
                                  if (responselogin.statusCode == 200) {
                                    emailcontroller.clear();
                                    pwdcontroller.clear();
                                    initialtabs = ConfigPage.zero;

                                    final userid = res['user']['id'];
                                    final token = res["token"].toString();
                                    isadmin = res['user']["isAdmin"];
                                    final configuretype =
                                        res['user']["configuretype"];
                                    final approvedtype =
                                        res['user']["approvedtype"].toString();
                                    print(approvedtype);
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt('UserID', userid);

                                    await prefs.setInt(
                                        'Configuretype', configuretype);

                                    await prefs.setString(
                                        'Approvedtype', approvedtype);

                                    await prefs.setString('Token', token);

                                    await prefs.setInt('Admin', isadmin);

                                    final bool mode =
                                        prefs.getBool('darkmode') ?? false;
                                    const int admin = 0;
                                    final int confignow =
                                        prefs.getInt('Configuretype')!;

                                    try {
                                      var url = Uri.parse(
                                          'https://deals.yexah.com:3000/get_providerplanref/$userid');

                                      var respon =
                                          await http.get(url, headers: {
                                        'Content-Type': 'application/json',
                                        'Accept': '*/*',
                                      });
                                      if (respon.statusCode == 200) {
                                        final Data = jsonDecode(respon.body);

                                        final Customersupprt = Data[
                                                    "providerData"][
                                                "confirmation_for_customer_support"]
                                            .toString();
                                        print(
                                            'customersupport  $Customersupprt');
                                        await prefs.setString(
                                            'Customersupport', Customersupprt);
                                        setState(() {
                                          Customersupprt == '1'
                                              ? showcustomersupporttab = true
                                              : showcustomersupporttab = false;
                                        });
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePageWeb()),
                                            (route) => false);
                                      } else {
                                        final Data = jsonDecode(respon.body);

                                        final Customersupprt = '0';

                                        await prefs.setString(
                                            'Customersupport', Customersupprt);
                                        setState(() {
                                          Customersupprt == '1'
                                              ? showcustomersupporttab = true
                                              : showcustomersupporttab = false;
                                        });
                                      }
                                    } catch (er) {
                                      print("aaaaaaaaaaa$er");
                                    }

                                    setState(() {
                                      isdark = mode;
                                      isadmin = admin;
                                      confignow == '1'
                                          ? showpage5 = true
                                          : false;
                                    });

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
                                            content: Text(
                                                error["message"].toString())));
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
                              }
                            }),
                        SizedBox(
                          height: screenwidth(context) * 0.01,
                        ),
                        TextBtn(
                            onpressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreenWeb()),
                                  (route) => false);
                            },
                            text: 'Don\'t have an account? Sign up'),
                        SizedBox(
                          height: screenwidth(context) * 0.01,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.admin_panel_settings,
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
                                              const AdminLoginWeb()),
                                      (route) => false);
                                },
                                text: 'Admin Sign in'),
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
      ),
    );
  }
}
