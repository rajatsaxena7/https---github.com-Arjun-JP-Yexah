// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yexah/web/const/color.dart';

import '../const/const.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class ChatScreenWeb extends StatefulWidget {
  const ChatScreenWeb({super.key});

  @override
  State<ChatScreenWeb> createState() => _ChatScreenWebState();
}

class _ChatScreenWebState extends State<ChatScreenWeb> {
  final textcontroller = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isdark ? ColorConst.scaffoldDark : ColorConst.white,
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: screenwidth(context) * .22,
                  height: screenheight(context) * .12,
                  child: Image.asset('assets/images/yexah_logo_home.png')),
              const Spacer(),
              SizedBox(
                width: screenwidth(context) * .15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // if (isadmin == 1) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) =>
                        //           const NotificationPage()));
                        // } else {
                        //   return;
                        // }
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/notification-1.svg",
                        color: isdark ? Colors.white : ColorConst.scaffoldDark,
                      ),
                    ),
                    CircleAvatar(
                      radius: screenwidth(context) * .015,
                      backgroundImage:
                          const AssetImage("assets/my_account_logo_new.png"),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: screenheight(context) * .2),
          Container(
            width: screenwidth(context) * .8,
            height: screenheight(context) * .4,
            padding: EdgeInsets.all(screenheight(context) * .05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isdark
                    ? ColorConst.rightcontainerdark
                    : ColorConst.rightcontainerlite),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the Question',
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          isdark ? ColorConst.textdarkw : ColorConst.textliteb),
                ),
                SizedBox(height: screenheight(context) * .01),
                TextField(
                    controller: textcontroller,
                    style: TextStyle(
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb),
                    decoration: InputDecoration(
                      hintText: 'Type your question here.',
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: isdark
                              ? ColorConst.textdarkw
                              : ColorConst.textliteb),
                    )),
                SizedBox(height: screenheight(context) * .01),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        const String apiUrl =
                            'https://deals.yexah.com:3000/send-email';

                        final Map<String, String> bodyy = {
                          'email': "admin@yexah.com",
                          'text': textcontroller.text.toString(),
                        };

                        try {
                          final response = await http.post(Uri.parse(apiUrl),
                              headers: {
                                'Content-Type': 'application/json',
                                'Accept': '*/*',
                              },
                              body: jsonEncode(bodyy));
                          print(response.statusCode);
                          setState(() {
                            isloading = false;
                          });
                          if (response.statusCode == 200) {
                            // Email sent successfully

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Email has been sent successfully.')));
                            Future.delayed(const Duration(seconds: 2))
                                .then((value) {
                              Navigator.of(context).pop();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Email sending filed.')));
                          }
                        } catch (error) {
                          print(error);
                        }
                      },
                      child: Text(isloading ? "Loading" : 'Submit')),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: ColorConst.primary,
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}
