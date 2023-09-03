// ignore_for_file: prefer_const_declarations

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/widgets/upload_data_container.dart';
import '../const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';
import 'package:http/http.dart' as http;

class ExcelUpload extends StatefulWidget {
  final BuildContext ctx;
  const ExcelUpload({super.key, required this.ctx});

  @override
  State<ExcelUpload> createState() => _ExcelUploadState();
}

bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width <
      600; // You can adjust this threshold
}

class _ExcelUploadState extends State<ExcelUpload> {
  final controller = TextEditingController();
  bool filepicked = false;
  bool isloading = false;
  bool panfilepicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isMobileView(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.789,
        height: screenheight(widget.ctx) * 0.85,
          color: isdark
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: EdgeInsets.all(
            screenwidth(context) * .02,
          ),
          child: Column(
            children: [
              DealsAtYexahBanner(isdarkk: isdark, ctx: context),
              SizedBox(height: screenheight(context) * .05),
              UploadData(
                  controller: controller,
                  tittle: 'Upload Excel file',
                  message: filepicked ? 'File picked' : "No file choosen",
                  ontap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom, allowedExtensions: ['xlsx']);

                    if (result != null) {
                      setState(() {
                        filepicked = true;
                      });
                      PlatformFile file = result.files.first;
                      print(file.name);
                    } else {
                      // User canceled the picker
                    }
                  }),
              SizedBox(height: screenheight(context) * .05),
              Center(
                child: SizedBox(
                    width: screenwidth(context) * .2,
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          panfilepicked = false;
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            setState(() {
                              panfilepicked = true;
                            });
                            PlatformFile panfile = result.files.first;

                            // print(panfile.name);
                            final url =
                                'https://deals.yexah.com:3000/upload'; // Replace with your backend API URL
                            final request =
                                http.MultipartRequest('POST', Uri.parse(url));
                            request.files.add(await http.MultipartFile.fromPath(
                                'excelFile', panfile.path!));

                            final response = await request.send();
                            if (response.statusCode == 200) {
                              // print('Data uploaded successfully.');
                            } else {
                              // print(
                              //     'Failed to upload data. Status code: ${response.statusCode}');
                            }
                          } else {
                            // User canceled the picker
                          }
                          // final int? userid = prefs.getInt('UserID');
                        },
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.zero),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                ColorConst.primary),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorConst.primary)),
                        child: Text(
                          isloading ? "Loading" : "Submit",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ))),
              )
            ],
          ),
        ),
        const FooterCon()
      ],
    );
  }
}
