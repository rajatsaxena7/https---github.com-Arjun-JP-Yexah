import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/screen/pdf_viwer.dart';
import 'package:yexah/web/widgets/button.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';
import 'deals.dart';
import 'deals_at_yexah_banner.dart';
import 'package:http/http.dart' as http;

enum Downloadtab { main, download, apikit }

Enum initialdownloadtab = Downloadtab.main;

class Downloads extends StatefulWidget {
  final BuildContext ctx;
  const Downloads({super.key, required this.ctx});

  @override
  State<Downloads> createState() => _DownloadsState();
}

bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width <
      600; // You can adjust this threshold
}

class _DownloadsState extends State<Downloads> {
  bool contracts = false;
  List<dynamic> pdfData = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        initialdownloadtab == Downloadtab.main
            ? downloadmain(context)
            : initialdownloadtab == Downloadtab.download
                ? contract(context)
                : initialdownloadtab == Downloadtab.apikit
                    ? apikit(context)
                    : const SizedBox(),
      ],
    );
  }

  Widget downloadmain(context) => Column(
        children: [
          Container(
            width: isMobileView(context)
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.78,
            height: screenheight(context) * 0.85,
            color: isdark
                ? ColorConst.rightcontainerdark
                : ColorConst.rightcontainerlite,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: GestureDetector(
                      onTap: () {},
                      child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                    ),
                  ),
                  SizedBox(height: screenheight(context) * .05),
                  isMobileView(context)
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    initialdownloadtab = Downloadtab.download;
                                  });
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        width: screenwidth(context) * .1,
                                        height: screenwidth(context) * .1,
                                        child: Image.asset(
                                            'assets/images/folder.png')),
                                    Text(
                                      'CONTRACTS',
                                      style: TextStyle(
                                          color: isdark
                                              ? ColorConst.textdarkw
                                              : ColorConst.textliteb),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    initialdownloadtab = Downloadtab.apikit;
                                    print(initialdownloadtab);
                                  });
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        width: screenwidth(context) * .1,
                                        height: screenwidth(context) * .1,
                                        child: Image.asset(
                                            'assets/images/folder.png')),
                                    Text('API KIT',
                                        style: TextStyle(
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  initialdownloadtab = Downloadtab.download;
                                });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                      width: screenwidth(context) * .1,
                                      height: screenwidth(context) * .07,
                                      child: Image.asset(
                                          'assets/images/folder.png')),
                                  Text(
                                    'CONTRACTS',
                                    style: TextStyle(
                                        color: isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  initialdownloadtab = Downloadtab.apikit;
                                  print(initialdownloadtab);
                                });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                      width: screenwidth(context) * .1,
                                      height: screenwidth(context) * .07,
                                      child: Image.asset(
                                          'assets/images/folder.png')),
                                  Text('API KIT',
                                      style: TextStyle(
                                          color: isdark
                                              ? ColorConst.textdarkw
                                              : ColorConst.textliteb))
                                ],
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
          const FooterCon()
        ],
      );
  Widget contract(context) {
    checkapikit();
    check();
    return Container(
      width: isMobileView(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.78,
      height: screenheight(context),
      color: isdark
          ? ColorConst.rightcontainerdark
          : ColorConst.rightcontainerlite,
      padding: EdgeInsets.all(
        screenwidth(context) * .02,
      ),
      child: Column(
        children: [
          Container(
            color: isdark
                ? ColorConst.rightcontainerdark
                : ColorConst.rightcontainerlite,
            width: screenwidth(context),
            height: screenheight(context) * .07,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            initialdownloadtab = Downloadtab.main;
                          });
                        },
                        icon: Icon(Icons.arrow_back,
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          !approvelpending
              ? Container(
                  color: Colors.transparent,
                  width: screenwidth(context) * .7,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Final_Signed_Contract.pdf',
                        style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontFamily: 'Nunito',
                            fontSize: isMobileView(context)
                                ? 14
                                : screenwidth(context) * .015,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 50,
                          width: screenwidth(context) * .1,
                          child: PrimaryBtn(
                              btnText: "Download", onpressed: downoadcontract)),
                      const SizedBox(width: 40)
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No approved contracts availabe!',
                    style: TextStyle(
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                        fontFamily: 'Nunito',
                        fontSize: screenwidth(context) * .015,
                        fontWeight: FontWeight.w600),
                  ),
                ),
        ],
      ),
    );
  }

  Widget apikit(context) {
    checkapikit();
    return Container(
      width: isMobileView(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.78,
      height: screenheight(context),
      color: isdark
          ? ColorConst.rightcontainerdark
          : ColorConst.rightcontainerlite,
      padding: EdgeInsets.all(
        screenwidth(context) * .02,
      ),
      child: Column(
        children: [
          Container(
            color: isdark
                ? ColorConst.rightcontainerdark
                : ColorConst.rightcontainerlite,
            width: screenwidth(context),
            height: screenheight(context) * .06,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        initialdownloadtab = Downloadtab.main;
                      });
                    },
                    icon: Icon(Icons.arrow_back,
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb))
              ],
            ),
          ),
          const SizedBox(height: 20),
          !approvelpending
              ? Container(
                  color: Colors.transparent,
                  width: screenwidth(context) * .7,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Yexha_API_KIT.pdf',
                        style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontFamily: 'Nunito',
                            fontSize: isMobileView(context)
                                ? 14
                                : screenwidth(context) * 0.01,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 50,
                          width: screenwidth(context) * .1,
                          child: PrimaryBtn(
                              btnText: "Download",
                              onpressed: () async {
                                ByteData bytess = await rootBundle
                                    .load('assets/pdf/apikit.pdf');
                                final buffer = bytess.buffer;
                                final String filename =
                                    ' Yexah - Privacy Policy - Vertices Drafts 003 (Clean).pdf';
                                var blob =
                                    html.Blob([bytess], 'text/plain', 'native');

                                var anchorElement = html.AnchorElement(
                                  href: html.Url.createObjectUrlFromBlob(blob)
                                      .toString(),
                                )
                                  ..setAttribute("download", filename)
                                  ..click();
                              })),
                      const SizedBox(width: 40)
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No API KIT availabe!',
                    style: TextStyle(
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                        fontFamily: 'Nunito',
                        fontSize: screenwidth(context) * .015,
                        fontWeight: FontWeight.w600),
                  ),
                )
        ],
      ),
    );
  }

  Future<void> check() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = await prefs.getInt('UserID');

      final response = await http.post(
        Uri.parse("https://deals.yexah.com:3000/getusers/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      // print(data);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          pdfData = data["pdf_finalsignedcontract"]["data"] ?? [];
        });
        if (pdfData.isNotEmpty) {
          contracts = true;
        } else {
          contracts = false;
        }
      }
    } catch (er) {
      throw Exception("$er");
    }
  }

  downoadcontract() async {
    if (pdfData.isNotEmpty) {
      Uint8List pdfBytes = Uint8List.fromList(pdfData.cast<int>());
      String filename = "pdf_final_signedcontract";
      final blob = html.Blob([Uint8List.fromList(pdfBytes)], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', filename);
      anchor.click();
      html.Url.revokeObjectUrl(url);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("PDF downloaded and saved")));
    }
  }

  Future<void> checkapikit() async {
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

        final approvedtype = res["approvedtype"].toString();

        setState(() {
          approvedtype == '1'
              ? approvelpending = false
              : approvelpending = true;
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
