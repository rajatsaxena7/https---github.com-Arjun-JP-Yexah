// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yexah/web/const/color.dart';
import 'package:http/http.dart' as http;
import 'package:yexah/web/const/const.dart';
import 'package:yexah/web/widgets/button.dart';
import 'home_page.dart';

enum Notificationtab { notifications, approved }

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Enum initialnotificationpage = Notificationtab.notifications;
  XFile? pickedImageadmin;
  late final base64Image;
  bool signed = false;

  Image? image;
  bool imagepicked = false;
  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(
          'https://deals.yexah.com:3000/getconfiguredusersnotapproved'));

      if (response.statusCode == 200) {
        // print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (er) {
      throw Exception('Failed to load users');
    }
  }

  Future<List<dynamic>> fetchApprovedUsers() async {
    try {
      final response = await http.get(
          Uri.parse('https://deals.yexah.com:3000/getapprovedconfiguredusers'),
          headers: {});

      if (response.statusCode == 200) {
        // print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (er) {
      throw Exception('Failed to load users');
    }
  }

  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width <
        600; // You can adjust this threshold
  }

  late Uint8List imageBytesadmin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor:
            isdark ? ColorConst.scaffoldDark : ColorConst.scaffoldlite,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                initialnotificationpage = Notificationtab.notifications;
              });
            },
            child: Container(
              color: Colors.transparent,
              width: screenwidth(context) * .3,
              child: Text(
                'Notifications',
                style: TextStyle(
                    fontSize:
                        initialnotificationpage == Notificationtab.notifications
                            ? screenwidth(context) * .040
                            : screenwidth(context) * .035,
                    color:
                        initialnotificationpage == Notificationtab.notifications
                            ? ColorConst.secondary
                            : isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                initialnotificationpage = Notificationtab.approved;
              });
            },
            child: Container(
              color: Colors.transparent,
              width: screenwidth(context) * .3,
              child: Text(
                'Approved Deals',
                style: TextStyle(
                    fontSize:
                        initialnotificationpage == Notificationtab.approved
                            ? screenwidth(context) * .040
                            : screenwidth(context) * .035,
                    color: initialnotificationpage == Notificationtab.approved
                        ? ColorConst.secondary
                        : isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb),
              ),
            ),
          ),
        ]),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios,
                color: isdark ? ColorConst.textdarkw : ColorConst.textliteb)),
        backgroundColor: isdark ? ColorConst.scaffoldDark : ColorConst.white,
        title: SizedBox(
            width: screenwidth(context) * .22,
            height: screenheight(context) * .12,
            child: Image.asset('assets/images/yexah_logo_home.png')),
      ),
      body: Container(
        color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
        child: Row(
          children: [
            Visibility(
              visible: screenwidth(context) >= 600,
              child: Container(
                color: Colors.transparent,
                height: screenheight(context),
                width: screenwidth(context) * .2,
                padding: EdgeInsets.symmetric(
                    horizontal: screenheight(context) * .05,
                    vertical: screenwidth(context) * .01),
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        initialnotificationpage = Notificationtab.notifications;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: screenheight(context) * .07,
                      width: screenwidth(context) * .2,
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                            fontSize: initialnotificationpage ==
                                    Notificationtab.notifications
                                ? screenwidth(context) * .019
                                : screenwidth(context) * .017,
                            color: initialnotificationpage ==
                                    Notificationtab.notifications
                                ? ColorConst.secondary
                                : isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        initialnotificationpage = Notificationtab.approved;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: screenheight(context) * .07,
                      width: screenwidth(context) * .2,
                      child: Text(
                        'Approved Deals',
                        style: TextStyle(
                            fontSize: initialnotificationpage ==
                                    Notificationtab.approved
                                ? screenwidth(context) * .019
                                : screenwidth(context) * .017,
                            color: initialnotificationpage ==
                                    Notificationtab.approved
                                ? ColorConst.secondary
                                : isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            initialnotificationpage == Notificationtab.notifications
                ? notification()
                : approveddeals(),
          ],
        ),
      ),
    );
  }

  Widget notification() => Container(
        color: isdark
            ? ColorConst.rightcontainerdark
            : ColorConst.rightcontainerlite,
        height: screenheight(context),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * 0.8,
        padding: EdgeInsets.all(screenwidth(context) * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenheight(context),
                width: isMobileView(context)
                    ? screenwidth(context)
                    : screenwidth(context) * 0.8,
                child: FutureBuilder<List<dynamic>>(
                  future: fetchUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final userList = snapshot.data;
                      // Render your user list here, e.g., using ListView.builder
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              color: isdark
                                  ? ColorConst.scaffoldDark
                                  : ColorConst.white,
                              width: isMobileView(context)
                                  ? screenwidth(context)
                                  : screenwidth(context) * 0.75,
                              height: isMobileView(context)
                                  ? screenheight(context) * .18
                                  : screenheight(context) * 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.6
                                        : screenwidth(context) * 0.35,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: isMobileView(context)
                                              ? screenwidth(context) * 0.06
                                              : screenwidth(context) * 0.03,
                                          child: Text(
                                            snapshot.data![index]["id"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: isMobileView(context)
                                                    ? screenwidth(context) *
                                                        .035
                                                    : screenwidth(context) *
                                                        0.01,
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileView(context)
                                              ? screenwidth(context) * 0.2
                                              : screenwidth(context) * 0.12,
                                          child: Text(
                                              snapshot.data![index]["fullname"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: isMobileView(
                                                          context)
                                                      ? screenwidth(context) *
                                                          .035
                                                      : screenwidth(context) *
                                                          0.01,
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb)),
                                        ),
                                        SizedBox(
                                          width: isMobileView(context)
                                              ? screenwidth(context) * 0.2
                                              : screenwidth(context) * 0.12,
                                          child: Text(
                                              snapshot.data![index]["email"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: isMobileView(
                                                          context)
                                                      ? screenwidth(context) *
                                                          .035
                                                      : screenwidth(context) *
                                                          0.01,
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isMobileView(context)
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                                width: isMobileView(context)
                                                    ? screenwidth(context) * .3
                                                    : screenwidth(context) *
                                                        0.1,
                                                child: PrimaryBtn(
                                                    btnText: 'Download',
                                                    onpressed: () async {
                                                      List<dynamic> pdfData =
                                                          snapshot.data![index][
                                                                  "pdf_signedcontract"]
                                                              ["data"];
                                                      Uint8List pdfBytes =
                                                          Uint8List.fromList(
                                                              pdfData
                                                                  .cast<int>());
                                                      String filename =
                                                          "pdf_client_signedcontract.pdf";
                                                      final blob = html.Blob([
                                                        Uint8List.fromList(
                                                            pdfBytes)
                                                      ], 'application/pdf');
                                                      final url = html.Url
                                                          .createObjectUrlFromBlob(
                                                              blob);
                                                      final anchor =
                                                          html.AnchorElement(
                                                              href: url)
                                                            ..setAttribute(
                                                                'download',
                                                                filename);
                                                      anchor.click();
                                                      html.Url.revokeObjectUrl(
                                                          url);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "PDF downloaded and saved")));
                                                    })),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                                width: isMobileView(context)
                                                    ? screenwidth(context) * .3
                                                    : screenwidth(context) *
                                                        0.1,
                                                child: PrimaryBtn(
                                                  btnText: imagepicked
                                                      ? "Uploaded"
                                                      : 'Upload Signed PDF',
                                                  onpressed: () async {
                                                    setState(() {
                                                      imagepicked = false;
                                                    });
                                                    File? selectedPdf;
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles();

                                                    if (result != null) {
                                                      setState(() {
                                                        imagepicked = true;

                                                        // selectedPdf = File(result
                                                        //     .files.single.path!);
                                                      });
                                                      // final path = result.paths;
                                                      Uint8List pdfBytes =
                                                          result.files.first
                                                              .bytes!;
                                                      // final pdfBytes =
                                                      //     await selectedPdf!
                                                      //         .readAsBytes();
                                                      final url = Uri.parse(
                                                          'https://deals.yexah.com:3000/upload-pdf/${snapshot.data![index]["id"]}');
                                                      var request =
                                                          http.MultipartRequest(
                                                              'POST', url);

                                                      request.files.add(http
                                                              .MultipartFile
                                                          .fromBytes(
                                                              'pdf', pdfBytes,
                                                              filename:
                                                                  'pdf_Yexah_signedcontract${snapshot.data![index]["id"]}.pdf'));

                                                      var response =
                                                          await request.send();
                                                      if (response.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          signed = true;
                                                        });
                                                        // print(
                                                        //     'PDF uploaded and saved successfully');
                                                        // print(response.request);
                                                      } else {
                                                        // print('Failed to upload PDF');
                                                      }
                                                    } else {
                                                      // User canceled the picker
                                                    }
                                                  },
                                                )),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                                width: isMobileView(context)
                                                    ? screenwidth(context) * .3
                                                    : screenwidth(context) *
                                                        0.1,
                                                child: PrimaryBtn(
                                                  btnText: 'Approve',
                                                  onpressed: () async {
                                                    try {
                                                      if (signed) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Confirm Approval'),
                                                              content: const Text(
                                                                  'Are you sure you want to Approve this Deal?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                        signed);
                                                                    final userid =
                                                                        snapshot.data![index]
                                                                            [
                                                                            "id"];
                                                                    // print(userid);
                                                                    final response =
                                                                        await http
                                                                            .post(
                                                                      Uri.parse(
                                                                          'https://deals.yexah.com:3000/approveContract/$userid'),
                                                                      headers: {
                                                                        'Content-Type':
                                                                            'application/json'
                                                                      },
                                                                    );
                                                                    setState(
                                                                        () {});
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        setState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Upload the signed Contract')));
                                                      }
                                                    } catch (er) {
                                                      throw Exception(
                                                          "Error not approved deal ");
                                                    }

                                                    const String apiUrl =
                                                        'https://deals.yexah.com:3000/send-email-contract-approved';

                                                    final Map<String, String>
                                                        bodyy = {
                                                      'email': snapshot
                                                          .data![index]["email"]
                                                          .toString(),
                                                      'text':
                                                          "Yexah has authorised your deal. The signed PDF can be received at yexah /downloads/contracts, and the API kit is now accessible in yexah /downloads/API kit.\n\n Thank You",
                                                    };

                                                    try {
                                                      final response =
                                                          await http.post(
                                                              Uri.parse(apiUrl),
                                                              headers: {
                                                                'Content-Type':
                                                                    'application/json',
                                                                'Accept-Encoding':
                                                                    'gzip, deflate, br',
                                                                'Accept': '*/*',
                                                              },
                                                              body: jsonEncode(
                                                                  bodyy));

                                                      if (response.statusCode ==
                                                          200) {
                                                        // Email sent successfully

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Email has been sent successfully.')));
                                                        Future.delayed(
                                                                const Duration(
                                                                    seconds: 2))
                                                            .then((value) {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Email sending filed.')));
                                                      }
                                                    } catch (error) {
                                                      print(error);
                                                    }
                                                  },
                                                )),
                                            const SizedBox(width: 10),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .1,
                                                child: PrimaryBtn(
                                                    btnText: 'Download',
                                                    onpressed: () async {
                                                      List<dynamic> pdfData =
                                                          snapshot.data![index][
                                                                  "pdf_signedcontract"]
                                                              ["data"];
                                                      Uint8List pdfBytes =
                                                          Uint8List.fromList(
                                                              pdfData
                                                                  .cast<int>());
                                                      String filename =
                                                          "pdf_client_signedcontract.pdf";
                                                      final blob = html.Blob([
                                                        Uint8List.fromList(
                                                            pdfBytes)
                                                      ], 'application/pdf');
                                                      final url = html.Url
                                                          .createObjectUrlFromBlob(
                                                              blob);
                                                      final anchor =
                                                          html.AnchorElement(
                                                              href: url)
                                                            ..setAttribute(
                                                                'download',
                                                                filename);
                                                      anchor.click();
                                                      html.Url.revokeObjectUrl(
                                                          url);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "PDF downloaded and saved")));
                                                    })),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .15,
                                                child: PrimaryBtn(
                                                  btnText: imagepicked
                                                      ? "Uploaded"
                                                      : 'Upload Signed PDF',
                                                  onpressed: () async {
                                                    setState(() {
                                                      imagepicked = false;
                                                    });
                                                    File? selectedPdf;
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles();

                                                    if (result != null) {
                                                      setState(() {
                                                        imagepicked = true;

                                                        // selectedPdf = File(result
                                                        //     .files.single.path!);
                                                      });
                                                      // final path = result.paths;
                                                      Uint8List pdfBytes =
                                                          result.files.first
                                                              .bytes!;
                                                      // final pdfBytes =
                                                      //     await selectedPdf!
                                                      //         .readAsBytes();
                                                      final url = Uri.parse(
                                                          'https://deals.yexah.com:3000/upload-pdf/${snapshot.data![index]["id"]}');
                                                      var request =
                                                          http.MultipartRequest(
                                                              'POST', url);

                                                      request.files.add(http
                                                              .MultipartFile
                                                          .fromBytes(
                                                              'pdf', pdfBytes,
                                                              filename:
                                                                  'pdf_Yexah_signedcontract${snapshot.data![index]["id"]}.pdf'));

                                                      var response =
                                                          await request.send();
                                                      if (response.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          signed = true;
                                                        });
                                                        // print(
                                                        //     'PDF uploaded and saved successfully');
                                                        // print(response.request);
                                                      } else {
                                                        // print('Failed to upload PDF');
                                                      }
                                                    } else {
                                                      // User canceled the picker
                                                    }
                                                  },
                                                )),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .1,
                                                child: PrimaryBtn(
                                                  btnText: 'Approve',
                                                  onpressed: () async {
                                                    try {
                                                      if (signed) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Confirm Approval'),
                                                              content: const Text(
                                                                  'Are you sure you want to Approve this Deal?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                        signed);
                                                                    final userid =
                                                                        snapshot.data![index]
                                                                            [
                                                                            "id"];
                                                                    // print(userid);
                                                                    final response =
                                                                        await http
                                                                            .post(
                                                                      Uri.parse(
                                                                          'https://deals.yexah.com:3000/approveContract/$userid'),
                                                                      headers: {
                                                                        'Content-Type':
                                                                            'application/json'
                                                                      },
                                                                    );
                                                                    setState(
                                                                        () {});
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        setState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Upload the signed Contract')));
                                                      }
                                                    } catch (er) {
                                                      throw Exception(
                                                          "Error not approved deal ");
                                                    }

                                                    const String apiUrl =
                                                        'https://deals.yexah.com:3000/send-email-contract-approved';

                                                    final Map<String, String>
                                                        bodyy = {
                                                      'email': snapshot
                                                          .data![index]["email"]
                                                          .toString(),
                                                      'text':
                                                          "Yexah has authorised your deal. The signed PDF can be received at yexah /downloads/contracts, and the API kit is now accessible in yexah /downloads/API kit.\n\n Thank You",
                                                    };

                                                    try {
                                                      final response =
                                                          await http.post(
                                                              Uri.parse(apiUrl),
                                                              headers: {
                                                                'Content-Type':
                                                                    'application/json',
                                                                'Accept-Encoding':
                                                                    'gzip, deflate, br',
                                                                'Accept': '*/*',
                                                              },
                                                              body: jsonEncode(
                                                                  bodyy));

                                                      if (response.statusCode ==
                                                          200) {
                                                        // Email sent successfully

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Email has been sent successfully.')));
                                                        Future.delayed(
                                                                const Duration(
                                                                    seconds: 2))
                                                            .then((value) {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Email sending filed.')));
                                                      }
                                                    } catch (error) {
                                                      print(error);
                                                    }
                                                  },
                                                )),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 5),
                          itemCount: snapshot.data!.length);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );

  Widget approveddeals() => Container(
        color: isdark
            ? ColorConst.rightcontainerdark
            : ColorConst.rightcontainerlite,
        height: screenheight(context),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * 0.8,
        padding: EdgeInsets.all(screenwidth(context) * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenheight(context),
                width: isMobileView(context)
                    ? screenwidth(context)
                    : screenwidth(context) * 0.8,
                child: FutureBuilder<List<dynamic>>(
                  future: fetchApprovedUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final userList = snapshot.data;
                      // Render your user list here, e.g., using ListView.builder
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              color: isdark
                                  ? ColorConst.scaffoldDark
                                  : ColorConst.white,
                              width: screenwidth(context) * .75,
                              height: screenheight(context) * .1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: screenwidth(context) * .4,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: isMobileView(context)
                                              ? screenwidth(context) * .05
                                              : screenwidth(context) * 0.03,
                                          child: Text(
                                            snapshot.data![index]["id"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: isMobileView(context)
                                                    ? screenwidth(context) *
                                                        .035
                                                    : screenwidth(context) *
                                                        0.01,
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isMobileView(context)
                                              ? screenwidth(context) * .2
                                              : screenwidth(context) * 0.12,
                                          child: Text(
                                              snapshot.data![index]["fullname"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: isMobileView(
                                                          context)
                                                      ? screenwidth(context) *
                                                          .035
                                                      : screenwidth(context) *
                                                          0.01,
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb)),
                                        ),
                                        SizedBox(
                                          width: isMobileView(context)
                                              ? screenwidth(context) * .15
                                              : screenwidth(context) * 0.12,
                                          child: Text(
                                              snapshot.data![index]["email"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: isMobileView(
                                                          context)
                                                      ? screenwidth(context) *
                                                          .035
                                                      : screenwidth(context) *
                                                          0.01,
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  isMobileView(context)
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .3,
                                                child: PrimaryBtn(
                                                    btnText: 'Download',
                                                    onpressed: () async {
                                                      List<dynamic> pdfData =
                                                          snapshot.data![index][
                                                                  "pdf_finalsignedcontract"]
                                                              ["data"];
                                                      Uint8List pdfBytes =
                                                          Uint8List.fromList(
                                                              pdfData
                                                                  .cast<int>());
                                                      String filename =
                                                          "pdf_finalsignedcontract";
                                                      final blob = html.Blob([
                                                        Uint8List.fromList(
                                                            pdfBytes)
                                                      ], 'application/pdf');
                                                      final url = html.Url
                                                          .createObjectUrlFromBlob(
                                                              blob);
                                                      final anchor =
                                                          html.AnchorElement(
                                                              href: url)
                                                            ..setAttribute(
                                                                'download',
                                                                filename);
                                                      anchor.click();
                                                      html.Url.revokeObjectUrl(
                                                          url);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "PDF downloaded and saved")));
                                                    })),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .3,
                                                child: PrimaryBtn(
                                                    btnText: 'Approved',
                                                    onpressed: () {})),
                                            const SizedBox(width: 10),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .1,
                                                child: PrimaryBtn(
                                                    btnText: 'Download',
                                                    onpressed: () async {
                                                      List<dynamic> pdfData =
                                                          snapshot.data![index][
                                                                  "pdf_finalsignedcontract"]
                                                              ["data"];
                                                      Uint8List pdfBytes =
                                                          Uint8List.fromList(
                                                              pdfData
                                                                  .cast<int>());
                                                      String filename =
                                                          "pdf_finalsignedcontract";
                                                      final blob = html.Blob([
                                                        Uint8List.fromList(
                                                            pdfBytes)
                                                      ], 'application/pdf');
                                                      final url = html.Url
                                                          .createObjectUrlFromBlob(
                                                              blob);
                                                      final anchor =
                                                          html.AnchorElement(
                                                              href: url)
                                                            ..setAttribute(
                                                                'download',
                                                                filename);
                                                      anchor.click();
                                                      html.Url.revokeObjectUrl(
                                                          url);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "PDF downloaded and saved")));
                                                    })),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                                width:
                                                    screenwidth(context) * .1,
                                                child: PrimaryBtn(
                                                    btnText: 'Approved',
                                                    onpressed: () {})),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 5),
                          itemCount: snapshot.data!.length);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
}
