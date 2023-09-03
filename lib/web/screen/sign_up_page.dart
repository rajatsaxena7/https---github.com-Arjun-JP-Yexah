import 'dart:convert';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:yexah/web/screen/login_screen.dart';
import 'package:yexah/web/widgets/button.dart';
import 'package:yexah/web/widgets/text_field.dart';
import 'package:yexah/web/widgets/textbtn.dart';
import '../widgets/text.dart';
import '../const/color.dart';
import '../const/const.dart';
import 'package:http/http.dart' as http;

import 'forget_password.dart';
import 'home_page.dart';

class SignUpScreenWeb extends StatefulWidget {
  const SignUpScreenWeb({super.key});

  @override
  State<SignUpScreenWeb> createState() => _SignUpScreenWebState();
}

class _SignUpScreenWebState extends State<SignUpScreenWeb> {
  final signinemailcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final signinpwdcontroller = TextEditingController();
  final signinformKey = GlobalKey<FormState>();
  bool isloading = false;
  bool showpassword = true;
  @override
  void dispose() {
    signinemailcontroller.dispose();
    namecontroller.dispose();
    signinpwdcontroller.dispose();
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
                child: SingleChildScrollView(
                  child: Form(
                    key: signinformKey,
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
                            text: 'Sign Up',
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
                          text: 'Your Name',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: screenheight(context) * 0.01,
                        ),
                        Textfld(
                            hintText: 'Enter your Name',
                            controller: namecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your name.';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: screenheight(context) * 0.02,
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
                            controller: signinpwdcontroller,
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
                        PrimaryBtn(
                            btnText: isloading ? 'loading' : "Sign Up",
                            onpressed: () async {
                              setState(() {
                                isloading = true;
                              });

                              if (signinformKey.currentState!.validate()) {
                                signinformKey.currentState!.save();
                                try {
                                  var url = Uri.parse(
                                      'https://deals.yexah.com:3000/register');
                                  var body = jsonEncode({
                                    "fullname": namecontroller.text,
                                    "email": signinemailcontroller.text,
                                    "password": signinpwdcontroller.text
                                  });

                                  var response = await http
                                      .post(url, body: body, headers: {
                                    'Content-Type': 'application/json',
                                    'Accept': '*/*',
                                  });
                                  print(response.body);
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Successfully Registered ')));
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreenWeb(),
                                    ));
                                  } else {
                                    setState(() {
                                      isloading = false;
                                    });
                                    Map error = jsonDecode(response.body);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error['message'])));
                                  }
                                } catch (error) {
                                  setState(() {
                                    isloading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(error.toString())));
                                }

                                setState(() {
                                  isloading = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please enter valid data')));
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
                                          const LoginScreenWeb()),
                                  (route) => false);
                            },
                            text: 'Already have an account? Sign In'),
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
