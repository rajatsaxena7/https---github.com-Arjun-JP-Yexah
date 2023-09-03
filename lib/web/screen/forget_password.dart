// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:yexah/web/screen/login_screen.dart';
import 'package:yexah/web/screen/sign_up_page.dart';
import 'package:yexah/web/widgets/button.dart';
import 'package:yexah/web/widgets/text_field.dart';
import 'package:yexah/web/widgets/textbtn.dart';
import '../widgets/text.dart';
import '../const/color.dart';
import '../const/const.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class ForgetPAsswordWeb extends StatefulWidget {
  const ForgetPAsswordWeb({super.key});

  @override
  State<ForgetPAsswordWeb> createState() => _ForgetPAsswordWebState();
}

class _ForgetPAsswordWebState extends State<ForgetPAsswordWeb> {
  final signinemailcontroller = TextEditingController();
  final tokencontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final newpwdcontroller = TextEditingController();
  final reenterpwdcontroller = TextEditingController();
  final signinformKey = GlobalKey<FormState>();
  bool isloading = false;
  bool showpassword = true;
  @override
  void dispose() {
    signinemailcontroller.dispose();
    namecontroller.dispose();
    newpwdcontroller.dispose();
    super.dispose();
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
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
                  child: Form(
                    key: signinformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/yexah_logo.png',
                            fit: BoxFit.fill,
                            height: screenheight(context) * 0.3,
                            width: screenwidth(context) * 0.3
                          ),
                        ),
                        Center(
                          child: Texttxt(
                            text: 'Forget Password',
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontsize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: screenheight(context) * 0.025,
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
                          controller: signinemailcontroller,
                          validator: EmailValidator(
                              errorText: 'Enter a valid email address'),
                        ),
                        SizedBox(
                          height: screenheight(context) * 0.02,
                        ),
                        Texttxt(
                          text: 'New Password',
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
                            hintText: 'Enter New Password',
                            controller: newpwdcontroller,
                            sufixicon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showpassword = !showpassword;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                            obscuretext: showpassword,
                            validator: passwordValidator),
                        SizedBox(
                          height: screenheight(context) * 0.015,
                        ),
                        Texttxt(
                          text: 'Re-Enter Password',
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
                            hintText: 'Re-Enter Password',
                            controller: reenterpwdcontroller,
                            sufixicon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showpassword = !showpassword;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                            obscuretext: showpassword,
                            validator: (val) {
                              if (newpwdcontroller.text !=
                                  reenterpwdcontroller.text) {
                                return 'Password Not Match';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: screenheight(context) * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texttxt(
                              text: 'Enter Token',
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textColor,
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            TextButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                      'https://deals.yexah.com:3000/send-reset-email');

                                  try {
                                    final response = await http.post(
                                      url,
                                      headers: {
                                        "Content-Type": "application/json"
                                      },
                                      body: jsonEncode({
                                        'email': signinemailcontroller.text,
                                      }),
                                    );

                                    if (response.statusCode == 200) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Reset token sent successfully')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Error sending reset token')),
                                      );
                                    }
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error sending reset token: $error')),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Get Token',
                                  style: TextStyle(color: ColorConst.primary),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: screenheight(context) * 0.01,
                        ),
                        Textfld(
                          hintText: 'Enter Token',
                          controller: tokencontroller,
                          obscuretext: false,
                        ),
                        SizedBox(
                          height: screenheight(context) * 0.02,
                        ),
                        PrimaryBtn(
                            btnText: isloading ? 'loading' : "Sign Up",
                            onpressed: () async {
                              setState(() {
                                isloading = true;
                              });

                              if (signinformKey.currentState!.validate()) {
                                signinformKey.currentState!.save();
                                final url = Uri.parse(
                                    'https://deals.yexah.com:3000/reset-password');

                                try {
                                  final response = await http.post(
                                    url,
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: jsonEncode({
                                      'email': signinemailcontroller.text,
                                      'token': tokencontroller.text,
                                      'newPassword': reenterpwdcontroller.text,
                                    }),
                                  );

                                  if (response.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Password reset successful')),
                                    );
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreenWeb(),
                                        ),
                                        (route) => false);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Error resetting password')),
                                    );
                                  }
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Error resetting password: $error')),
                                  );
                                  print('Error resetting password: $error');
                                }

                                setState(() {
                                  isloading = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter valid email address')));
                              }
                            }),
                        SizedBox(
                          height: screenwidth(context) * 0.01,
                        ),
                        TextBtn(
                            onpressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreenWeb()),
                                  (route) => false);
                            },
                            text: 'Don\'t have an account? Sign up'),
                        SizedBox(
                          height: screenwidth(context) * 0.01,
                        ),
                        TextBtn(
                            onpressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreenWeb()),
                                  (route) => false);
                            },
                            text: 'Already have an account? Sign In'),
                        SizedBox(
                          height: screenwidth(context) * 0.01,
                        ),
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
