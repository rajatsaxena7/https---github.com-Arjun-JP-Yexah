import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:yexah/web/const/color.dart';

import 'package:yexah/web/screen/home_page.dart';

class DigitalPadScreen extends StatefulWidget {
  DigitalPadScreen({Key? key}) : super(key: key);

  @override
  DigitalPadScreenState createState() => DigitalPadScreenState();
}

class DigitalPadScreenState extends State<DigitalPadScreen> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Received Sign Successfully'),
          content: Text(
            'Your signed contract email to you with next 24 hours.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageWeb(),
                    ));
              },
              child: const Text('close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: ColorConst.greyishBackgroundColour,
        body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: Container(
                      height: 400,
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 4.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)))),
              SizedBox(height: 10),
              Row(children: <Widget>[
                TextButton(
                  child: Text('Upload sign'),
                  onPressed: _handleSaveButtonPressed,
                ),
                TextButton(
                  child: Text('Clear'),
                  onPressed: _handleClearButtonPressed,
                )
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center));
  }
}
