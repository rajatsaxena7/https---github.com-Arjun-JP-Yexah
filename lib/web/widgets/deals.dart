// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/widgets/upload_data_container.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

bool showcustomersupporttab = false;
bool showpage5 = false;
bool customersupport = true;

enum ConfigPage { zero, one, two, three, four, five }

enum Payment { onetime, monthly, quarterly, every6months, annualy, none }

class Deals extends StatefulWidget {
  final BuildContext ctx;

  const Deals({super.key, required this.ctx});

  @override
  State<Deals> createState() => _DealsState();
}

Enum initialtabs = ConfigPage.zero;
bool approvelpending = true;

class _DealsState extends State<Deals> {
  @override
  void dispose() {
    pancontroller.dispose();
    gstcontroller.dispose();
    logocontroller.dispose();
    businessname.dispose();
    brandname.dispose();
    legalname.dispose();
    address.dispose();
    city.dispose();
    postalcode.dispose();
    country.dispose();
    website.dispose();
    designation.dispose();
    email.dispose();
    phonenumber.dispose();
    aadharnumber.dispose();
    super.dispose();
  }

  final pancontroller = TextEditingController();
  final gstcontroller = TextEditingController();
  final logocontroller = TextEditingController();
  final businessname = TextEditingController();
  final brandname = TextEditingController();
  final legalname = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final postalcode = TextEditingController();
  final country = TextEditingController();
  final website = TextEditingController();
  final designation = TextEditingController();
  final email = TextEditingController();
  final phonenumber = TextEditingController();
  final aadharnumber = TextEditingController();
  final page2formKey = GlobalKey<FormState>();
  final page3formKey = GlobalKey<FormState>();
  double marginevalueslider1 = 0;
  double marginevalueslider2 = 0;

  Enum initialpaymentvalue = Payment.none;

  bool mobile = false;
  bool tv = false;
  bool laptop = false;
  bool ac = false;
  bool fridge = false;
  List<String> gadgetcount = [];
  bool panfilepicked = false;
  bool gstfilepicked = false;
  bool logofilepicked = false;
  bool aadharfilepicked = false;
  bool signedfilepicked = false;

  bool disablecofigbtn = false;
  double total = 0;
  double markup = 0;
  double reparerequest = 0;
  double markuppercentage = 0;
  double markupamount = 0;
  int numberofproduct = 0;
  int constamount = 0;
  double totalfinal = 0;
  List<String> products = [];
  XFile? pickedImage;
  var pickedgst;
  var pickedaadhar;
  var pickedlogo;
  var pickedpan;
  Map reqbody = {
    "user_id": '',
    "how_often": '',
    "markupPercentage": '',
    "repairRequest": '',
    " basePrice": '',
    " markupMoney": '',
    " markup": '',
    "confirmation_for_customer_support": '',
    "party2Name": '',
    "party2Address": '',
    "city": '',
    "postalCode": '',
    "country": '',
    "website": '',
    "party2PAN": '',
    "party2GST": '',
    "authSignatoryName": '',
    "designation": '',
    "authSignatoryEmailAddress": '',
    "authSignatoryPhoneNumber": '',
    "authSignatoryAadharNumber": '',
    "selectedGadgets": '',
    "selectedNumberOfGadgets": '',
  };
  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width <
        600; // You can adjust this threshold
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return Column(
      children: [
        SizedBox(
          width: isMobileView(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.789,
          height: screenheight(context) * 0.9,
          child: initialtabs == ConfigPage.zero
              ? dealpage(context)
              : configPage(context),
        ),
      ],
    );
  }

  Widget dealpage(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    check();
    return Container(
      width: isMobileView(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * .8,
      height: screenheight(context) * .9,
      color: isdark
          ? ColorConst.rightcontainerdark
          : ColorConst.rightcontainerlite,
      // padding: const EdgeInsets.onl,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'EMBED CURATED OFFERINGS, INCREASE REVENUES AND GET MORE DONE WITH YEXAH!',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: ColorConst.primary,
                    fontSize: screenwidth(context) * .02,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenheight(context) * .07),
            isMobileView(context)
                ? Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    width: screenwidth(context) * .8,
                    height: screenheight(context) * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.scaffoldDarklite
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenheight(context) * .12,
                                width: screenwidth(context) * .7,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text('Embed For',
                                              style: TextStyle(
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              )),
                                        ),
                                        Flexible(
                                          child: Text('White Goods retail',
                                              style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  color: ColorConst.primary,
                                                  fontSize: isMobileView(
                                                          context)
                                                      ? 14
                                                      : screenwidth(context) *
                                                          0.01,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: isMobileView(context)
                                          ? 40
                                          : screenwidth(context) * 0.01,
                                      height: screenheight(context) * .1,
                                      child: Image.asset(
                                          'assets/images/responsive.png'),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'For you if you are looking to supplement your offerings in consumer electronics  retail. Discover our curated offers for your business',
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
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'A2Z Gadget\nRepair',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: isMobileView(context)
                                              ? 14
                                              : screenwidth(context) * 0.01,
                                          color: ColorConst.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: isMobileView(context)
                                        ? 80
                                        : screenwidth(context) * 0.01,
                                    height: screenheight(context) * .08,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/a2zlogo.png',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Description'),
                                              content: Text(
                                                'A2Z Gadget Repair is one of india\'s largest teleconsultation providers. with over 10,000 empanelled doctores and 24*7 offerings. More on A2Z Gadget Repair at  A2ZGadget Repair.com. Know more on Yexahs curated offer with A2Z Gadget Repair here link to download key fact sheet pdf document (refer 1st deal workflow page]]) )',
                                                style: TextStyle(
                                                  fontSize: isMobileView(
                                                          context)
                                                      ? 14
                                                      : screenwidth(context) *
                                                          0.01,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.info,
                                        size: screenwidth(context) * .022,
                                        color: ColorConst.secondary,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Bundle gadget repair with home pick up and drop (laptops, phones, home appliances, TV)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .035),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      showpage5
                                          ? initialtabs = ConfigPage.five
                                          : initialtabs = ConfigPage.one;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    showpage5 ? 'Configured' : 'Configure Now',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Coming Soon...',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: isMobileView(context)
                                        ? 14
                                        : screenwidth(context) * 0.01,
                                    color: ColorConst.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenheight(context) * .02),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Standalone extended warranty at Point of Sale, for upto 2 years for phone, laptops, TVs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    width: screenwidth(context) * .76,
                    height: screenheight(context) * .35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? Colors.transparent
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenheight(context) * .12,
                                  width: screenwidth(context) * .18,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Text('Embed For',
                                              style: TextStyle(
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              )),
                                          Flexible(
                                            child: Text('White Goods retail',
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: ColorConst.primary,
                                                    fontSize:
                                                        screenwidth(context) *
                                                            .013,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenwidth(context) * .05,
                                        height: screenheight(context) * .1,
                                        child: Image.asset(
                                            'assets/images/responsive.png'),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'For you if you are looking to supplement your offerings in consumer electronics  retail. Discover our curated offers for your business',
                                    style: TextStyle(
                                        color: isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb,
                                        fontFamily: 'Nunito',
                                        fontSize: screenwidth(context) * .009,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'A2Z Gadget\nRepair',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: screenwidth(context) * .013,
                                          color: ColorConst.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth(context) * .07,
                                    height: screenheight(context) * .08,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/a2zlogo.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Description'),
                                              content: const Text(
                                                  'A2Z Gadget Repair is one of india\'s largest teleconsultation providers. with over 10,000 empanelled doctores and 24*7 offerings. More on A2Z Gadget Repair at  A2ZGadget Repair.com. Know more on Yexahs curated offer with A2Z Gadget Repair here link to download key fact sheet pdf document (refer 1st deal workflow page]]) )'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.info,
                                        size: screenwidth(context) * .022,
                                        color: ColorConst.secondary,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Bundle gadget repair with home pick up and drop (laptops, phones, home appliances, TV)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: screenwidth(context) * .009,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .035),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      showpage5
                                          ? initialtabs = ConfigPage.five
                                          : initialtabs = ConfigPage.one;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  child: Text(
                                    showpage5 ? 'Configured' : 'Configure Now',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.008,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Coming Soon...',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: screenwidth(context) * .013,
                                    color: ColorConst.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenheight(context) * .02),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Standalone extended warranty at Point of Sale, for upto 2 years for phone, laptops, TVs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: screenwidth(context) * .009,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: screenheight(context) * .05,
            ),
            isMobileView(context)
                ? Container(
                    width: screenwidth(context) * .8,
                    height: screenheight(context) * .9,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.scaffoldDarklite
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenheight(context) * .12,
                                width: screenwidth(context) * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Text('Embed For',
                                            style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                            )),
                                        Text('Health and Wellness',
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: ColorConst.primary,
                                                fontSize: isMobileView(context)
                                                    ? 14
                                                    : screenwidth(context) *
                                                        0.01,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: isMobileView(context)
                                          ? 40
                                          : screenwidth(context) * 0.01,
                                      height: screenheight(context) * .1,
                                      child: Image.asset(
                                          'assets/images/health_and_wellness.png'),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'For you if you are looking to add offerings around health and wellness for your consumers',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb,
                                    fontSize: isMobileView(context)
                                        ? 14
                                        : screenwidth(context) * 0.01,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Provider 2 <Insert Name/logo>',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: isMobileView(context)
                                              ? 14
                                              : screenwidth(context) * 0.01,
                                          color: ColorConst.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.info,
                                        size: screenwidth(context) * .022,
                                        color: ColorConst.secondary,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Offer teleconsultations to your consumers via your mobile and web consumer journey',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .035),
                              ElevatedButton(
                                  onPressed: () {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     const SnackBar(
                                    //         content: Text(
                                    //             "Sorry This Deal is not Active Now")));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      // backgroundColor: ColorConst.primary,
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      ),
                                  child: Text(
                                    'Configure Now',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 7
                                          : screenwidth(context) * 0.012,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Coming Soon...',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: isMobileView(context)
                                        ? 14
                                        : screenwidth(context) * 0.01,
                                    color: ColorConst.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenheight(context) * .02),
                              Text(
                                  'Offer free home lab test to your consumers via your mobile and web consumer journey',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    width: screenwidth(context) * .76,
                    height: screenheight(context) * .35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? Colors.transparent
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenheight(context) * .12,
                                width: screenwidth(context) * .18,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Text('Embed For',
                                            style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                            )),
                                        Text('Health and Wellness',
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: ColorConst.primary,
                                                fontSize:
                                                    screenwidth(context) * .013,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: screenwidth(context) * .048,
                                      height: screenheight(context) * .1,
                                      child: Image.asset(
                                          'assets/images/health_and_wellness.png'),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'For you if you are looking to add offerings around health and wellness for your consumers',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb,
                                    fontSize: screenwidth(context) * .009,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Provider 2 <Insert Name/logo>',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: screenwidth(context) * .013,
                                          color: ColorConst.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.info,
                                        size: screenwidth(context) * .022,
                                        color: ColorConst.secondary,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Offer teleconsultations to your consumers via your mobile and web consumer journey',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: screenwidth(context) * .009,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                              ElevatedButton(
                                  onPressed: () {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     const SnackBar(
                                    //         content: Text(
                                    //             "Sorry This Deal is not Active Now")));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  child: Text(
                                    'Configure Now',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.008,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Coming Soon...',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: screenwidth(context) * .013,
                                    color: ColorConst.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenheight(context) * .02),
                              Text(
                                  'Offer free home lab test to your consumers via your mobile and web consumer journey',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: screenwidth(context) * .009,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: screenheight(context) * .05,
            ),
            isMobileView(context)
                ? Container(
                    width: screenwidth(context) * .8,
                    height: screenheight(context) * .9,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.scaffoldDarklite
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenheight(context) * .12,
                                width: screenwidth(context) * .35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Text('Embed For',
                                            style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                            )),
                                        Text('Automotives',
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: ColorConst.primary,
                                                fontSize: isMobileView(context)
                                                    ? 14
                                                    : screenwidth(context) *
                                                        0.01,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: isMobileView(context)
                                          ? 40
                                          : screenwidth(context) * 0.01,
                                      height: screenheight(context) * .1,
                                      child: Image.asset(
                                          'assets/images/automotives.png'),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'For you if you are looking to add further services to your existing business around automotives/ components and add more value to your customers',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb,
                                    fontSize: isMobileView(context)
                                        ? 14
                                        : screenwidth(context) * 0.01,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Coming Soon...',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: isMobileView(context)
                                              ? 14
                                              : screenwidth(context) * 0.01,
                                          color: ColorConst.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.info,
                                        size: screenwidth(context) * .022,
                                        color: ColorConst.secondary,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  'Vehicle servicing twice a year at Garages across India',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .73,
                          height: screenheight(context) * .27,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Coming Soon...',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: isMobileView(context)
                                        ? 14
                                        : screenwidth(context) * 0.01,
                                    color: ColorConst.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenheight(context) * .02),
                              Text(
                                  'Roadside assistance package in the event of vehicle breakdown in India',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: isMobileView(context)
                                          ? 14
                                          : screenwidth(context) * 0.01,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    width: screenwidth(context) * .76,
                    height: screenheight(context) * .35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? Colors.transparent
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenheight(context) * .12,
                                width: screenwidth(context) * .18,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Text('Embed For',
                                            style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                            )),
                                        Text('Automotives',
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: ColorConst.primary,
                                                fontSize:
                                                    screenwidth(context) * .013,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: screenwidth(context) * .05,
                                      height: screenheight(context) * .1,
                                      child: Image.asset(
                                          'assets/images/automotives.png'),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'For you if you are looking to add further services to your existing business around automotives/ components and add more value to your customers',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb,
                                    fontSize: screenwidth(context) * .009,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Coming Soon...',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: screenwidth(context) * .013,
                                          color: ColorConst.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.info,
                                        size: screenwidth(context) * .022,
                                        color: ColorConst.secondary,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  'Vehicle servicing twice a year at Garages across India',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: screenwidth(context) * .009,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        ),
                        Container(
                          width: screenwidth(context) * .24,
                          height: screenheight(context) * .308,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isdark
                                ? ColorConst.rightcontainerdark
                                : ColorConst.rightcontainerlite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Coming Soon...',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: screenwidth(context) * .013,
                                    color: ColorConst.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenheight(context) * .02),
                              Text(
                                  'Roadside assistance package in the event of vehicle breakdown in India',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                      fontSize: screenwidth(context) * .009,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: screenheight(context) * .015),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: screenheight(context) * .05,
            ),
            Container(
                width: screenwidth(context) * .8,
                height: screenheight(context) * .1,
                color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                child: const Center(child: FooterCon())),
          ],
        ),
      ),
    );
  }

  Widget configPage(BuildContext context) => SizedBox(
        width: isMobileView(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .78,
        height: screenheight(context) * 0.9,
        child: Column(
          children: [
            Container(
              width: isMobileView(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * .78,
              height: screenheight(context) * .1,
              color: isdark
                  ? ColorConst.rightcontainerdark
                  : ColorConst.rightcontainerlite,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showpage5 == true
                              ? initialtabs = ConfigPage.five
                              : initialtabs = ConfigPage.one;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .01),
                          CircleAvatar(
                            backgroundColor: initialtabs == ConfigPage.one
                                ? ColorConst.secondary
                                : const Color.fromARGB(88, 255, 153, 0),
                            radius: initialtabs == ConfigPage.one
                                ? screenwidth(context) * .015
                                : screenwidth(context) * .01,
                            child: initialtabs == ConfigPage.one
                                ? Icon(
                                    Icons.edit,
                                    size: screenwidth(context) * .02,
                                    color: Colors.white,
                                  )
                                : Text(
                                    '1',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                    ),
                                    // ignore: prefer_const_constructors
                                  ),
                          ),
                          SizedBox(width: screenwidth(context) * .01),
                          Text(
                            'Configure your product',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb),
                          ),
                          SizedBox(width: screenwidth(context) * .01),
                          SizedBox(
                            width: screenwidth(context) * .01,
                            child: const Divider(),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showpage5 == true
                              ? initialtabs = ConfigPage.five
                              : initialtabs = ConfigPage.two;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .01),
                          CircleAvatar(
                            backgroundColor: initialtabs == ConfigPage.two
                                ? ColorConst.secondary
                                : const Color.fromARGB(88, 255, 153, 0),
                            radius: initialtabs == ConfigPage.two
                                ? screenwidth(context) * .015
                                : screenwidth(context) * .01,
                            child: initialtabs == ConfigPage.two
                                ? Icon(
                                    Icons.edit,
                                    size: screenwidth(context) * .02,
                                    color: Colors.white,
                                  )
                                : Text(
                                    '2',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                    ),
                                    // ignore: prefer_const_constructors
                                  ),
                          ),
                          SizedBox(width: screenwidth(context) * .01),
                          Text('Upload your company details',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb)),
                          SizedBox(width: screenwidth(context) * .01),
                          SizedBox(
                            width: screenwidth(context) * .01,
                            child: const Divider(),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showpage5 == true
                              ? initialtabs = ConfigPage.five
                              : initialtabs = ConfigPage.three;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .01),
                          CircleAvatar(
                            backgroundColor: initialtabs == ConfigPage.three
                                ? ColorConst.secondary
                                : const Color.fromARGB(88, 255, 153, 0),
                            radius: initialtabs == ConfigPage.three
                                ? screenwidth(context) * .015
                                : screenwidth(context) * .01,
                            child: initialtabs == ConfigPage.three
                                ? Icon(
                                    Icons.edit,
                                    size: screenwidth(context) * .02,
                                    color: Colors.white,
                                  )
                                : Text(
                                    '3',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                    ),
                                    // ignore: prefer_const_constructors
                                  ),
                          ),
                          SizedBox(width: screenwidth(context) * .01),
                          Text('Generate your contact',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb)),
                          SizedBox(width: screenwidth(context) * .01),
                          SizedBox(
                            width: screenwidth(context) * .01,
                            child: const Divider(),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showpage5 == true
                              ? initialtabs = ConfigPage.five
                              : initialtabs = ConfigPage.four;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .01),
                          CircleAvatar(
                            backgroundColor: initialtabs == ConfigPage.four
                                ? ColorConst.secondary
                                : const Color.fromARGB(88, 255, 153, 0),
                            radius: initialtabs == ConfigPage.four
                                ? screenwidth(context) * .015
                                : screenwidth(context) * .01,
                            child: initialtabs == ConfigPage.four
                                ? Icon(
                                    Icons.edit,
                                    size: screenwidth(context) * .02,
                                    color: Colors.white,
                                  )
                                : Text(
                                    '4',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                    ),
                                    // ignore: prefer_const_constructors
                                  ),
                          ),
                          SizedBox(width: screenwidth(context) * .01),
                          Text('Sign your contract',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb)),
                          SizedBox(width: screenwidth(context) * .01),
                          SizedBox(
                            width: screenwidth(context) * .01,
                            child: const Divider(),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          initialtabs = ConfigPage.five;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .01),
                          CircleAvatar(
                            backgroundColor: initialtabs == ConfigPage.five
                                ? ColorConst.secondary
                                : const Color.fromARGB(88, 255, 153, 0),
                            radius: initialtabs == ConfigPage.five
                                ? screenwidth(context) * .015
                                : screenwidth(context) * .01,
                            child: initialtabs == ConfigPage.five
                                ? Icon(
                                    Icons.edit,
                                    size: screenwidth(context) * .02,
                                    color: Colors.white,
                                  )
                                : Text(
                                    '5',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                    ),
                                    // ignore: prefer_const_constructors
                                  ),
                          ),
                          SizedBox(width: screenwidth(context) * .01),
                          Text('Access your API',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb)),
                          SizedBox(width: screenwidth(context) * .01),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            initialtabs == ConfigPage.one
                ? configPage1(context)
                : initialtabs == ConfigPage.two
                    ? configPage2(context)
                    : initialtabs == ConfigPage.three
                        ? configPage3(context)
                        : initialtabs == ConfigPage.four
                            ? configPage4(context)
                            : configPage5(context),
          ],
        ),
      );

  Widget configPage1(BuildContext context) => Container(
        width: isMobileView(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.78,
        height: screenheight(context) * 0.73,
        padding: EdgeInsets.all(screenwidth(context) * .01),
        color: isdark
            ? ColorConst.rightcontainerdark
            : ColorConst.rightcontainerlite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      initialtabs = ConfigPage.zero;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: ColorConst.secondary,
                  ),
                  label: const Text(
                    'Go back to dashboard',
                    style: TextStyle(
                        fontFamily: 'Nunito', color: ColorConst.secondary),
                  )),
              SizedBox(
                  width: isMobileView(context)
                      ? MediaQuery.of(context).size.width
                      : screenwidth(context) * .78,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenwidth(context) * .78,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Gadget Repair.Partner < A2Z Gadget Repair >',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: isMobileView(context)
                                          ? 12
                                          : screenwidth(context) * 0.012,
                                      color: ColorConst.primary),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  width: screenwidth(context) * .15,
                                  height: screenheight(context) * .1,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/a2zlogo.png'))),
                                )
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height: screenheight(context) * .03),
                        Text(
                          "Your Configurator",
                          style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: isMobileView(context)
                                ? 12
                                : screenwidth(context) * 0.012,
                          ),
                        ),
                        SizedBox(height: screenheight(context) * .01),
                        Text(
                          "Simulate and customize your offering for your customers and set your markup rate , then proceed to your contract !",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobileView(context)
                                ? 12
                                : screenwidth(context) * 0.012,
                          ),
                        ),
                        SizedBox(height: screenheight(context) * .05),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Container(
                                    width: screenwidth(context),
                                    color: isdark
                                        ? ColorConst.rightcontainerdark
                                        : ColorConst.rightcontainerlite,
                                    padding: EdgeInsets.all(
                                        screenwidth(context) * .01),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: screenwidth(context),
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'How Often do you want your customers to pay ?',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.onetime;

                                                      totalzzz();
                                                      markuptotal();
                                                      constamount = 250;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .onetime
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              initialpaymentvalue ==
                                                                      Payment
                                                                          .onetime
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'One time',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.monthly;

                                                      markuptotal();
                                                      totalzzz();
                                                      int constamount = 25;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .monthly
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              initialpaymentvalue ==
                                                                      Payment
                                                                          .monthly
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Monthly',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.quarterly;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .quarterly
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color: initialpaymentvalue ==
                                                                  Payment
                                                                      .quarterly
                                                              ? ColorConst
                                                                  .primary
                                                              : Colors.grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Quarterly',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.every6months;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .every6months
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color: initialpaymentvalue ==
                                                                  Payment
                                                                      .every6months
                                                              ? ColorConst
                                                                  .primary
                                                              : Colors.grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Every 6 months',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.annualy;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .annualy
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              initialpaymentvalue ==
                                                                      Payment
                                                                          .annualy
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Annually',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .03),
                                        Container(
                                            width: screenwidth(context),
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Simulate your offering',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .015),
                                                Text(
                                                  'Here you can customize the offering, based on your business  and curate a solution that you can offer to your customer',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .015),
                                                Text(
                                                  'Select gadget type that you want repairs for',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .015),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          mobile = !mobile;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                          if (mobile) {
                                                            if (initialpaymentvalue ==
                                                                Payment
                                                                    .onetime) {
                                                              total = 250 * 1;
                                                            } else if (initialpaymentvalue ==
                                                                Payment
                                                                    .monthly) {
                                                              total = 250 * 1;
                                                            }
                                                          }
                                                        });
                                                        mobile
                                                            ? gadgetcount
                                                                .add('mobile')
                                                            : gadgetcount
                                                                    .contains(
                                                                        'mobile')
                                                                ? gadgetcount
                                                                    .remove(
                                                                        'mobile')
                                                                : gadgetcount;
                                                        // print(gadgetcount);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              mobile
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: mobile
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'Mobile Phone',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          laptop = !laptop;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              laptop
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: laptop
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'Laptop',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          tv = !tv;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              tv
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: tv
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'TV',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          ac = !ac;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              ac
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: ac
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'AC',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fridge = !fridge;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              fridge
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: fridge
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'Fridge',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Text(
                                                  'How many repair requests per customer ?',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                Text(
                                                  'Per customer/ per device/ per 12 months',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Column(
                                                  children: [
                                                    Text(
                                                      marginevalueslider1
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: isMobileView(
                                                                  context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorConst
                                                              .primary),
                                                    ),
                                                    Slider(
                                                      thumbColor:
                                                          ColorConst.primary,
                                                      activeColor:
                                                          ColorConst.primary,
                                                      min: 0,
                                                      max: 6,
                                                      divisions: 6,
                                                      value:
                                                          marginevalueslider1,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          marginevalueslider1 =
                                                              newValue;

                                                          reparerequest =
                                                              newValue;
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .03),
                                        Container(
                                            width: screenwidth(context),
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Set Your Markup',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                Text(
                                                  'Now is the time to choose your margin. Please note this choice will be stated  in your contract and fixed in the API.',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                Text(
                                                  'The markup and other fields will be fixed once defined and cannot be changed later in the API',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Column(
                                                  children: [
                                                    Text(
                                                      marginevalueslider2
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: isMobileView(
                                                                  context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorConst
                                                              .primary),
                                                    ),
                                                    Slider(
                                                      thumbColor:
                                                          ColorConst.primary,
                                                      activeColor:
                                                          ColorConst.primary,
                                                      min: 0,
                                                      max: 500,
                                                      divisions: 500,
                                                      value:
                                                          marginevalueslider2,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          marginevalueslider2 =
                                                              newValue;
                                                          markuptotal();
                                                          markuppercentage =
                                                              newValue;
                                                          markupamount = total *
                                                              markuppercentage *
                                                              .01;
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth(context),
                                    color: ColorConst.transparent,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: screenwidth(context),
                                            height: screenheight(context) * .35,
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Price Confirmation per transaction',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Text(
                                                  'Total price for your customers, including taxes (18% GST charged by you in India)',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                Expanded(
                                                  child: Text(
                                                    'Total  ${_removeStringAfterDotOrSpace(totalfinal.toString())}',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: ColorConst.primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          isMobileView(context)
                                                              ? 16
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                Expanded(
                                                  child: Text(
                                                    'Including INR ${_removeStringAfterDotOrSpace(markupamount.toString())} which is your markup',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          isMobileView(context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .03),
                                        Container(
                                            width: screenwidth(context),
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Confirmation to integrate Yexah! Customer Support',
                                                  style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Text(
                                                  'Click Yes to have Yexah! send emails to your customers every time they purchase a partner’s offering or have a service requirement/ wish to track a request made to the  partner via your site/app.  Our API kit will involve a field to access your customer data (we need this to send them emails.',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                  softWrap: true,
                                                  // maxLines: 10,
                                                ),
                                                Text(
                                                  'You will also get to access the Yexah! customer support platfrom for free to manage customer interactions.',
                                                  style: TextStyle(
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb),
                                                  softWrap: true,
                                                  maxLines: 10,
                                                ),
                                                Text(
                                                  'Know more on the operating model document.\nIf you don’t select this , then all service requests of your customers on partner’s offerings will be managed by your team/ CRM tool and we will only provide the pricing API, with no access to their contact details',
                                                  style: TextStyle(
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb),
                                                  softWrap: true,
                                                  maxLines: 10,
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          customersupport =
                                                              true;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              customersupport
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: customersupport
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .01),
                                                          Text('Yes',
                                                              style: TextStyle(
                                                                  color: isdark
                                                                      ? ColorConst
                                                                          .textdarkw
                                                                      : ColorConst
                                                                          .textliteb))
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: screenwidth(
                                                                context) *
                                                            .05),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          customersupport =
                                                              false;
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              !customersupport
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: !customersupport
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .01),
                                                          Text('No',
                                                              style: TextStyle(
                                                                  color: isdark
                                                                      ? ColorConst
                                                                          .textdarkw
                                                                      : ColorConst
                                                                          .textliteb))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth(context),
                                    height: screenheight(context) * .8,
                                    padding: EdgeInsets.all(
                                        screenwidth(context) * .01),
                                    color: ColorConst.transparent,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const PdfViewerWeb(
                                            //               filePath:
                                            //                   'assets/pdf/key_fact_sheet.pdf',
                                            //             )));
                                            ByteData bytes = await rootBundle.load(
                                                'assets/pdf/key_fact_sheet.pdf');
                                            final buffer = bytes.buffer;
                                            const String filename =
                                                'Yexah_key_fact_sheet.pdf';
                                            var blob = html.Blob([bytes],
                                                'text/plain', 'native');

                                            var anchorElement =
                                                html.AnchorElement(
                                              href: html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob)
                                                  .toString(),
                                            )
                                                  ..setAttribute(
                                                      "download", filename)
                                                  ..click();
                                          },
                                          child: Container(
                                            width: screenwidth(context),
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .003),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Key Fact Sheet',
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                        fontSize: isMobileView(
                                                                context)
                                                            ? 12
                                                            : screenwidth(
                                                                    context) *
                                                                0.012,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.download,
                                                      color: ColorConst.primary,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        "Brief overview of the provider’s offering, service TATs and an overview of the partner organization",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            color: isdark
                                                                ? ColorConst
                                                                    .textdarkw
                                                                : ColorConst
                                                                    .textliteb,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize:
                                                                isMobileView(
                                                                        context)
                                                                    ? 12
                                                                    : 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .025),
                                        GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const PdfViewerWeb(
                                            //               filePath:
                                            //                   'assets/pdf/operating_model.pdf',
                                            //             )));

                                            ByteData bytes = await rootBundle.load(
                                                'assets/pdf/operating_model.pdf');
                                            final buffer = bytes.buffer;
                                            const String filename =
                                                'operating_model.pdf';
                                            var blob = html.Blob([bytes],
                                                'text/plain', 'native');

                                            var anchorElement =
                                                html.AnchorElement(
                                              href: html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob)
                                                  .toString(),
                                            )
                                                  ..setAttribute(
                                                      "download", filename)
                                                  ..click();
                                          },
                                          child: Container(
                                            width: screenwidth(context),
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .003),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Operating Model',
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                        fontSize: isMobileView(
                                                                context)
                                                            ? 12
                                                            : screenwidth(
                                                                    context) *
                                                                0.012,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.download,
                                                      color: ColorConst.primary,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        "Brief overview of how the offering will work in practice for your customers at each step, purchase to availing the provider’s service",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize:
                                                              isMobileView(
                                                                      context)
                                                                  ? 12
                                                                  : 18,
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .02),
                                        GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const PdfViewerWeb(
                                            //               filePath:
                                            //                   'assets/pdf/sample_customer_copy.pdf',
                                            //             )));

                                            ByteData bytes = await rootBundle.load(
                                                'assets/pdf/sample_customer_copy.pdf');
                                            final buffer = bytes.buffer;
                                            const String filename =
                                                'sample_customer_copy.pdf';
                                            var blob = html.Blob([bytes],
                                                'text/plain', 'native');

                                            var anchorElement =
                                                html.AnchorElement(
                                              href: html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob)
                                                  .toString(),
                                            )
                                                  ..setAttribute(
                                                      "download", filename)
                                                  ..click();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .003),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'View sample Customer Copy',
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                        fontSize: isMobileView(
                                                                context)
                                                            ? 12
                                                            : screenwidth(
                                                                    context) *
                                                                0.012,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.download,
                                                      color: ColorConst.primary,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        "Download a sample document that will get generated for your customer once he purchases the plan. This document will be required by the customer to interact with the provider subsequently",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize:
                                                              isMobileView(
                                                                      context)
                                                                  ? 12
                                                                  : 18,
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        isMobileView(context)
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          screenwidth(context) *
                                                              .3),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        final validation =
                                                            totalzzz();
                                                        if (validation == 0.0) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Please enter Needed data')));
                                                        } else {
                                                          setState(() {
                                                            initialtabs =
                                                                ConfigPage.two;
                                                          });
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorConst.primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                          'Save and Continue',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: Colors
                                                                  .white))),
                                                  const SizedBox(
                                                      width: 20, height: 20),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorConst.primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                          'Save as Draft',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: Colors
                                                                  .white)))
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          screenwidth(context) *
                                                              .3),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        final validation =
                                                            totalzzz();
                                                        if (validation == 0.0) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Please enter Needed data')));
                                                        } else {
                                                          setState(() {
                                                            initialtabs =
                                                                ConfigPage.two;
                                                          });
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorConst.primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                          'Save and Continue',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: Colors
                                                                  .white))),
                                                  const SizedBox(height: 20),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorConst.primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                          'Save as Draft',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: Colors
                                                                  .white)))
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Container(
                                    width: screenwidth(context) * .34,
                                    color: isdark
                                        ? ColorConst.rightcontainerdark
                                        : ColorConst.rightcontainerlite,
                                    padding: EdgeInsets.all(
                                        screenwidth(context) * .01),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: screenwidth(context) * .34,
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'How Often do you want your customers to pay ?',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.onetime;

                                                      totalzzz();
                                                      markuptotal();
                                                      constamount = 250;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .onetime
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              initialpaymentvalue ==
                                                                      Payment
                                                                          .onetime
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'One time',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.monthly;

                                                      markuptotal();
                                                      totalzzz();
                                                      int constamount = 25;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .monthly
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              initialpaymentvalue ==
                                                                      Payment
                                                                          .monthly
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Monthly',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.quarterly;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .quarterly
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color: initialpaymentvalue ==
                                                                  Payment
                                                                      .quarterly
                                                              ? ColorConst
                                                                  .primary
                                                              : Colors.grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Quarterly',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.every6months;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .every6months
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color: initialpaymentvalue ==
                                                                  Payment
                                                                      .every6months
                                                              ? ColorConst
                                                                  .primary
                                                              : Colors.grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Every 6 months',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      initialpaymentvalue =
                                                          Payment.annualy;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          initialpaymentvalue ==
                                                                  Payment
                                                                      .annualy
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                          color:
                                                              initialpaymentvalue ==
                                                                      Payment
                                                                          .annualy
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                      SizedBox(
                                                          width: screenwidth(
                                                                  context) *
                                                              .01),
                                                      Text(
                                                        'Annually',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .03),
                                        Container(
                                            width: screenwidth(context) * .34,
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Simulate your offering',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .015),
                                                Text(
                                                  'Here you can customize the offering, based on your business  and curate a solution that you can offer to your customer',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .015),
                                                Text(
                                                  'Select gadget type that you want repairs for',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .015),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          mobile = !mobile;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                          if (mobile) {
                                                            if (initialpaymentvalue ==
                                                                Payment
                                                                    .onetime) {
                                                              total = 250 * 1;
                                                            } else if (initialpaymentvalue ==
                                                                Payment
                                                                    .monthly) {
                                                              total = 250 * 1;
                                                            }
                                                          }
                                                        });
                                                        mobile
                                                            ? gadgetcount
                                                                .add('mobile')
                                                            : gadgetcount
                                                                    .contains(
                                                                        'mobile')
                                                                ? gadgetcount
                                                                    .remove(
                                                                        'mobile')
                                                                : gadgetcount;
                                                        // print(gadgetcount);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              mobile
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: mobile
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'Mobile Phone',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          laptop = !laptop;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              laptop
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: laptop
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'Laptop',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          tv = !tv;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              tv
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: tv
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'TV',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          ac = !ac;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              ac
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: ac
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'AC',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenheight(
                                                                context) *
                                                            .01),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fridge = !fridge;
                                                          productcount();
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              fridge
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: fridge
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .005),
                                                          Text(
                                                            'Fridge',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: isdark
                                                                  ? ColorConst
                                                                      .textdarkw
                                                                  : ColorConst
                                                                      .textliteb,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Text(
                                                  'How many repair requests per customer ?',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                Text(
                                                  'Per customer/ per device/ per 12 months',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Column(
                                                  children: [
                                                    Text(
                                                      marginevalueslider1
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: isMobileView(
                                                                  context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorConst
                                                              .primary),
                                                    ),
                                                    Slider(
                                                      thumbColor:
                                                          ColorConst.primary,
                                                      activeColor:
                                                          ColorConst.primary,
                                                      min: 0,
                                                      max: 6,
                                                      divisions: 6,
                                                      value:
                                                          marginevalueslider1,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          marginevalueslider1 =
                                                              newValue;

                                                          reparerequest =
                                                              newValue;
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .03),
                                        Container(
                                            width: screenwidth(context) * .34,
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Set Your Markup',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .01),
                                                Text(
                                                  'Now is the time to choose your margin. Please note this choice will be stated  in your contract and fixed in the API.',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                Text(
                                                  'The markup and other fields will be fixed once defined and cannot be changed later in the API',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isMobileView(
                                                            context)
                                                        ? 12
                                                        : screenwidth(context) *
                                                            0.012,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Column(
                                                  children: [
                                                    Text(
                                                      marginevalueslider2
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: isMobileView(
                                                                  context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorConst
                                                              .primary),
                                                    ),
                                                    Slider(
                                                      thumbColor:
                                                          ColorConst.primary,
                                                      activeColor:
                                                          ColorConst.primary,
                                                      min: 0,
                                                      max: 500,
                                                      divisions: 500,
                                                      value:
                                                          marginevalueslider2,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          marginevalueslider2 =
                                                              newValue;
                                                          markuptotal();
                                                          markuppercentage =
                                                              newValue;
                                                          markupamount = total *
                                                              markuppercentage *
                                                              .01;
                                                          markuptotal();
                                                          totalzzz();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth(context) * .24,
                                    color: ColorConst.transparent,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: screenwidth(context) * .24,
                                            height: screenheight(context) * .35,
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Price Confirmation per transaction',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Text(
                                                  'Total price for your customers, including taxes (18% GST charged by you in India)',
                                                  style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          screenwidth(context) *
                                                              .01),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                Expanded(
                                                  child: Text(
                                                    'Total  ${_removeStringAfterDotOrSpace(totalfinal.toString())}',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: ColorConst.primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          isMobileView(context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                Expanded(
                                                  child: Text(
                                                    'Including INR ${_removeStringAfterDotOrSpace(markupamount.toString())} which is your markup',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          isMobileView(context)
                                                              ? 12
                                                              : screenwidth(
                                                                      context) *
                                                                  0.012,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .03),
                                        Container(
                                            width: screenwidth(context) * .24,
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .01),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Confirmation to integrate Yexah! Customer Support',
                                                  style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .03),
                                                Text(
                                                  'Click Yes to have Yexah! send emails to your customers every time they purchase a partner’s offering or have a service requirement/ wish to track a request made to the  partner via your site/app.  Our API kit will involve a field to access your customer data (we need this to send them emails.',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: isdark
                                                        ? ColorConst.textdarkw
                                                        : ColorConst.textliteb,
                                                  ),
                                                  softWrap: true,
                                                  // maxLines: 10,
                                                ),
                                                Text(
                                                  'You will also get to access the Yexah! customer support platfrom for free to manage customer interactions.',
                                                  style: TextStyle(
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb),
                                                  softWrap: true,
                                                  maxLines: 10,
                                                ),
                                                Text(
                                                  'Know more on the operating model document.\nIf you don’t select this , then all service requests of your customers on partner’s offerings will be managed by your team/ CRM tool and we will only provide the pricing API, with no access to their contact details',
                                                  style: TextStyle(
                                                      color: isdark
                                                          ? ColorConst.textdarkw
                                                          : ColorConst
                                                              .textliteb),
                                                  softWrap: true,
                                                  maxLines: 10,
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenheight(context) *
                                                            .02),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          customersupport =
                                                              true;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              customersupport
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: customersupport
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .01),
                                                          Text('Yes',
                                                              style: TextStyle(
                                                                  color: isdark
                                                                      ? ColorConst
                                                                          .textdarkw
                                                                      : ColorConst
                                                                          .textliteb))
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: screenwidth(
                                                                context) *
                                                            .05),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          customersupport =
                                                              false;
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              !customersupport
                                                                  ? Icons
                                                                      .radio_button_checked
                                                                  : Icons
                                                                      .radio_button_unchecked,
                                                              color: !customersupport
                                                                  ? ColorConst
                                                                      .primary
                                                                  : Colors
                                                                      .grey),
                                                          SizedBox(
                                                              width: screenwidth(
                                                                      context) *
                                                                  .01),
                                                          Text('No',
                                                              style: TextStyle(
                                                                  color: isdark
                                                                      ? ColorConst
                                                                          .textdarkw
                                                                      : ColorConst
                                                                          .textliteb))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth(context) * .18,
                                    height: screenheight(context) * .8,
                                    padding: EdgeInsets.all(
                                        screenwidth(context) * .01),
                                    color: ColorConst.transparent,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const PdfViewerWeb(
                                            //               filePath:
                                            //                   'assets/pdf/key_fact_sheet.pdf',
                                            //             )));
                                            ByteData bytes = await rootBundle.load(
                                                'assets/pdf/key_fact_sheet.pdf');
                                            final buffer = bytes.buffer;
                                            const String filename =
                                                'Yexah_key_fact_sheet.pdf';
                                            var blob = html.Blob([bytes],
                                                'text/plain', 'native');

                                            var anchorElement =
                                                html.AnchorElement(
                                              href: html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob)
                                                  .toString(),
                                            )
                                                  ..setAttribute(
                                                      "download", filename)
                                                  ..click();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .003),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Key Fact Sheet',
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                        fontSize: isMobileView(
                                                                context)
                                                            ? 12
                                                            : screenwidth(
                                                                    context) *
                                                                0.012,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.download,
                                                      color: ColorConst.primary,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        "Brief overview of the provider’s offering, service TATs and an overview of the partner organization",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            color: isdark
                                                                ? ColorConst
                                                                    .textdarkw
                                                                : ColorConst
                                                                    .textliteb,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize:
                                                                isMobileView(
                                                                        context)
                                                                    ? 12
                                                                    : 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .025),
                                        GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const PdfViewerWeb(
                                            //               filePath:
                                            //                   'assets/pdf/operating_model.pdf',
                                            //             )));

                                            ByteData bytes = await rootBundle.load(
                                                'assets/pdf/operating_model.pdf');
                                            final buffer = bytes.buffer;
                                            const String filename =
                                                'operating_model.pdf';
                                            var blob = html.Blob([bytes],
                                                'text/plain', 'native');

                                            var anchorElement =
                                                html.AnchorElement(
                                              href: html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob)
                                                  .toString(),
                                            )
                                                  ..setAttribute(
                                                      "download", filename)
                                                  ..click();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .003),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Operating Model',
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                        fontSize: isMobileView(
                                                                context)
                                                            ? 12
                                                            : screenwidth(
                                                                    context) *
                                                                0.012,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.download,
                                                      color: ColorConst.primary,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        "Brief overview of how the offering will work in practice for your customers at each step, purchase to availing the provider’s service",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize:
                                                              isMobileView(
                                                                      context)
                                                                  ? 12
                                                                  : 18,
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                screenheight(context) * .02),
                                        GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const PdfViewerWeb(
                                            //               filePath:
                                            //                   'assets/pdf/sample_customer_copy.pdf',
                                            //             )));

                                            ByteData bytes = await rootBundle.load(
                                                'assets/pdf/sample_customer_copy.pdf');
                                            final buffer = bytes.buffer;
                                            const String filename =
                                                'sample_customer_copy.pdf';
                                            var blob = html.Blob([bytes],
                                                'text/plain', 'native');

                                            var anchorElement =
                                                html.AnchorElement(
                                              href: html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob)
                                                  .toString(),
                                            )
                                                  ..setAttribute(
                                                      "download", filename)
                                                  ..click();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                screenwidth(context) * .003),
                                            decoration: BoxDecoration(
                                                color: isdark
                                                    ? ColorConst.scaffoldDark
                                                    : ColorConst.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenwidth(context) *
                                                            .01)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'View sample Customer Copy',
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                        fontSize: isMobileView(
                                                                context)
                                                            ? 12
                                                            : screenwidth(
                                                                    context) *
                                                                0.012,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.download,
                                                      color: ColorConst.primary,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        "Download a sample document that will get generated for your customer once he purchases the plan. This document will be required by the customer to interact with the provider subsequently",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize:
                                                              isMobileView(
                                                                      context)
                                                                  ? 12
                                                                  : 18,
                                                          color: isdark
                                                              ? ColorConst
                                                                  .textdarkw
                                                              : ColorConst
                                                                  .textliteb,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                        Visibility(
                          visible: screenwidth(context) >= 600,
                          child: Row(
                            children: [
                              SizedBox(width: screenwidth(context) * .3),
                              ElevatedButton(
                                  onPressed: () {
                                    final validation = totalzzz();
                                    if (validation == 0.0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please enter Needed data')));
                                    } else {
                                      setState(() {
                                        initialtabs = ConfigPage.two;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Save and Continue',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: Colors.white))),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Save as Draft',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: Colors.white)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
  Widget configPage2(BuildContext context) => Container(
        width: isMobileView(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.78,
        height: screenheight(context) * .73,
        padding: EdgeInsets.all(screenwidth(context) * .01),
        color: isdark
            ? ColorConst.rightcontainerdark
            : ColorConst.rightcontainerlite,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                    onPressed: () {
                      setState(() {
                        initialtabs = ConfigPage.zero;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorConst.secondary,
                    ),
                    label: const Text(
                      'Go back to dashboard',
                      style: TextStyle(
                          fontFamily: 'Nunito', color: ColorConst.secondary),
                    )),
                SizedBox(
                  height: screenheight(context) * 0.01,
                ),
                SizedBox(
                  width: screenwidth(context) * .78,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Gadget Repair.Partner < A2Z Gadget Repair >',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: isMobileView(context)
                                  ? 12
                                  : screenwidth(context) * 0.012,
                              color: ColorConst.primary),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: screenwidth(context) * .15,
                          height: screenheight(context) * .1,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/a2zlogo.png'))),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenheight(context) * .03),
                Text(
                  "Your Company details",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobileView(context)
                        ? 12
                        : screenwidth(context) * 0.015,
                  ),
                ),
                SizedBox(height: screenheight(context) * .01),
                Text(
                  "Please fill the company details , upload documents for contract to get generated !",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontWeight: FontWeight.normal,
                    fontSize: isMobileView(context) ? 12 : 18,
                  ),
                ),
                SizedBox(height: screenheight(context) * .05),
                Container(
                  width: isMobileView(context)
                      ? screenwidth(context)
                      : screenwidth(context) * .78,
                  padding: EdgeInsets.all(screenwidth(context) * .025),
                  decoration: BoxDecoration(
                      color:
                          isdark ? ColorConst.scaffoldDark : ColorConst.white,
                      borderRadius: BorderRadius.circular(
                        screenwidth(context) * .005,
                      )),
                  child: Form(
                    key: page2formKey,
                    child: Column(
                      children: [
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Your Business Brand Name*',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: isdark
                                              ? ColorConst.textdarkw
                                              : ColorConst.textliteb,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: brandname,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your brand name.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Your Entity\'s Legal Name*',
                                          style: TextStyle(
                                              fontFamily: 'Nunito',
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                              fontWeight: FontWeight.normal)),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: legalname,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your legal name.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Your Business Brand Name*',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: isdark
                                              ? ColorConst.textdarkw
                                              : ColorConst.textliteb,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: brandname,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your brand name.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Your Entity\'s Legal Name*',
                                          style: TextStyle(
                                              fontFamily: 'Nunito',
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                              fontWeight: FontWeight.normal)),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: legalname,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your legal name.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  )
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Address to be mentioned on contract*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: address,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your  Address.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Address to be mentioned on contract*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .4,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: address,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your  Address.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text('City*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: city,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your city name.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Postal code*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: postalcode,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your postal code.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('City*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: city,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your city name.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Postal code*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: postalcode,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your postal code.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text('Country*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: country,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your country.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Website',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: website,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your website address.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('Country*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: country,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your country.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Website',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: website,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your website address.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text('GST Number*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: gstcontroller,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter GST number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('PAN Card Number',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: pancontroller,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your PAN number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('GST Number*',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: gstcontroller,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter GST number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('PAN Card Number',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                          )),
                                      SizedBox(
                                          width: screenwidth(context) * .2,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              controller: pancontroller,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your PAN number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .05),
                        UploadData(
                            controller: pancontroller,
                            tittle: 'Your Entity\'s PAN card*',
                            message: panfilepicked
                                ? 'File picked'
                                : 'No file choosen',
                            ontap: () async {
                              setState(() {
                                panfilepicked = false;
                              });

                              final ImagePicker _picker = ImagePicker();
                              XFile? pickedpan1 = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              final panbytes = await pickedpan1!.readAsBytes();
                              if (pickedpan1 != null) {
                                setState(() {
                                  panfilepicked = true;
                                  pickedpan = panbytes;
                                });

                                // print(panfile.name);
                              } else {
                                // User canceled the picker
                              }
                            }),
                        SizedBox(height: screenheight(context) * .05),
                        UploadData(
                            controller: pancontroller,
                            tittle: 'Your Entity\'s GST Number*',
                            message: gstfilepicked
                                ? 'File picked'
                                : 'No file choosen',
                            ontap: () async {
                              setState(() {
                                gstfilepicked = false;
                              });

                              final ImagePicker _picker = ImagePicker();
                              XFile? pickedgst1 = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              final gstbytes = await pickedgst1!.readAsBytes();
                              if (pickedgst1 != null) {
                                setState(() {
                                  gstfilepicked = true;
                                  pickedgst = gstbytes;
                                });

                                // print(gstfile.name);
                              } else {
                                // User canceled the picker
                              }
                            }),
                        SizedBox(height: screenheight(context) * .05),
                        UploadData(
                            controller: pancontroller,
                            tittle: 'Your Entity\'s Logo*',
                            message: logofilepicked
                                ? 'File picked'
                                : 'No file choosen',
                            ontap: () async {
                              setState(() {
                                logofilepicked = false;
                              });

                              final ImagePicker _picker = ImagePicker();
                              XFile? pickedlogo1 = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              final logobytes =
                                  await pickedlogo1!.readAsBytes();
                              if (pickedlogo1 != null) {
                                setState(() {
                                  logofilepicked = true;
                                  pickedlogo = logobytes;
                                });

                                // print(logofile.name);
                              } else {
                                // User canceled the picker
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenheight(context) * .05),
                isMobileView(context)
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(width: screenwidth(context) * .3),
                            ElevatedButton(
                                onPressed: () {
                                  if (panfilepicked &&
                                      gstfilepicked &&
                                      logofilepicked) {
                                    if (page2formKey.currentState!.validate()) {
                                      page2formKey.currentState!.save();
                                      setState(() {
                                        initialtabs = ConfigPage.three;
                                      });
                                    } else {
                                      // print('Validation failed');
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Upload PanCard,Logo & GST files")));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConst.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Save and Continue',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: Colors.white))),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConst.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Save as Draft',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: Colors.white)))
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .3),
                          ElevatedButton(
                              onPressed: () {
                                if (panfilepicked &&
                                    gstfilepicked &&
                                    logofilepicked) {
                                  if (page2formKey.currentState!.validate()) {
                                    page2formKey.currentState!.save();
                                    setState(() {
                                      initialtabs = ConfigPage.three;
                                    });
                                  } else {
                                    // print('Validation failed');
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Upload PanCard,Logo & GST files")));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConst.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save and Continue',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white))),
                          const SizedBox(width: 20),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConst.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save as Draft',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white)))
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
  Widget configPage3(BuildContext context) => Container(
        width: isMobileView(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.78,
        height: screenheight(context) * .73,
        padding: EdgeInsets.all(screenwidth(context) * .01),
        color: isdark
            ? ColorConst.rightcontainerdark
            : ColorConst.rightcontainerlite,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                    onPressed: () {
                      setState(() {
                        initialtabs = ConfigPage.zero;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorConst.secondary,
                    ),
                    label: const Text(
                      'Go back to dashboard',
                      style: TextStyle(
                          fontFamily: 'Nunito', color: ColorConst.secondary),
                    )),
                SizedBox(
                  width: screenwidth(context) * .78,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Gadget Repair.Partner < A2Z Gadget Repair >',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: isMobileView(context)
                                  ? 12
                                  : screenwidth(context) * 0.02,
                              color: ColorConst.primary),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: screenwidth(context) * .15,
                          height: screenheight(context) * .1,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/a2zlogo.png'))),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenheight(context) * .03),
                Text(
                  "Contract signatory details",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobileView(context)
                        ? 12
                        : screenwidth(context) * 0.015,
                  ),
                ),
                SizedBox(height: screenheight(context) * .01),
                Text(
                  "We are digitaly signed contracts via Aadhar e-sign,please furnish authorized signatory details",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      color:
                          isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                      // fontWeight: FontWeight.bold,
                      fontSize: isMobileView(context)
                          ? 12
                          : screenwidth(context) * .009),
                ),
                SizedBox(height: screenheight(context) * .05),
                Container(
                  width: isMobileView(context)
                      ? screenwidth(context)
                      : screenwidth(context) * 0.78,
                  padding: EdgeInsets.all(screenwidth(context) * .025),
                  decoration: BoxDecoration(
                      color:
                          isdark ? ColorConst.scaffoldDark : ColorConst.white,
                      borderRadius: BorderRadius.circular(
                        screenwidth(context) * .005,
                      )),
                  child: Form(
                    key: page3formKey,
                    child: Column(
                      children: [
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text('Name of authorised signatory *',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: businessname,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter authorised signatory name.';
                                                }
                                                return null;
                                              })),
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Designation*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: designation,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter Designation.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Name of authorised signatory \nin your business*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .3,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: businessname,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter authorised signatory name.';
                                                }
                                                return null;
                                              })),
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                  Column(
                                    children: [
                                      Text('Designation*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .17,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: designation,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter Designation.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  )
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Authorised signatory Email address*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: email,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter email id.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Authorised signatory Email address*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .3,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: email,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter email id.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Authorised signatory phone number(linked to aadhar)*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: phonenumber,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter phone number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Authorised signatory phone number(linked to aadhar)*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .3,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: phonenumber,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter phone number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                  SizedBox(width: screenwidth(context) * .02),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .04),
                        isMobileView(context)
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Authorised signatory Aadhar card number*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .7,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: aadharnumber,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter aadhar number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Authorised signatory Aadhar card number*',
                                          style: TextStyle(
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb)),
                                      SizedBox(
                                          width: screenwidth(context) * .3,
                                          height: screenheight(context) * .08,
                                          child: TextFormField(
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                              ),
                                              controller: aadharnumber,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ColorConst.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter aadhar number.';
                                                }
                                                return null;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: screenheight(context) * .05),
                        UploadData(
                            controller: pancontroller,
                            tittle: 'Authorised signatory Aadhar card*',
                            message: aadharfilepicked
                                ? 'File picked'
                                : 'No file choosen',
                            ontap: () async {
                              aadharfilepicked = false;
                              final ImagePicker _picker = ImagePicker();
                              XFile? pickedaadhar1 = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              final aadhsrbytes =
                                  await pickedaadhar1!.readAsBytes();

                              if (pickedaadhar1 != null) {
                                setState(() {
                                  aadharfilepicked = true;
                                  pickedaadhar = aadhsrbytes;
                                });
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                final int userid = prefs.getInt('UserID')!;
                                final url = Uri.parse(
                                    'https://deals.yexah.com:3000/save-imagedata');

                                try {
                                  final base64Imageaaddar =
                                      base64Encode(pickedaadhar);
                                  final base64Imagepan =
                                      base64Encode(pickedpan);
                                  final base64Imagegst =
                                      base64Encode(pickedgst);
                                  final base64Imagelogo =
                                      base64Encode(pickedlogo);

                                  final response = await http.post(
                                    url,
                                    headers: {
                                      'Content-Type': 'application/json',
                                    },
                                    body: jsonEncode({
                                      'user_id': userid,
                                      ' gst_image': base64Imagegst,
                                      'adharcard_image': base64Imageaaddar,
                                      'pancard_image': base64Imagepan,
                                      'logo_image': base64Imagelogo
                                    }),
                                  );
                                  print(response.body);
                                  if (response.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'image data saved successfully')),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Error saving image data')),
                                    );
                                  }
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Error saving image data: $error')),
                                  );
                                  print('Error saving image data: $error');
                                }
                              } else {
                                // User canceled the picker
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenheight(context) * .05),
                isMobileView(context)
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(width: screenwidth(context) * .3),
                            ElevatedButton(
                                onPressed: () {
                                  if (aadharfilepicked) {
                                    if (page3formKey.currentState!.validate()) {
                                      page3formKey.currentState!.save();
                                      setState(() {
                                        initialtabs = ConfigPage.four;
                                      });
                                    } else {
                                      print('Validation failed');
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Upload Aadhar file")));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConst.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Save and Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                    ))),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConst.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Save as Draft',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                    )))
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          SizedBox(width: screenwidth(context) * .3),
                          ElevatedButton(
                              onPressed: () {
                                if (aadharfilepicked) {
                                  if (page3formKey.currentState!.validate()) {
                                    page3formKey.currentState!.save();
                                    setState(() {
                                      initialtabs = ConfigPage.four;
                                    });
                                  } else {
                                    print('Validation failed');
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Upload Aadhar file")));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConst.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save and Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                  ))),
                          const SizedBox(width: 20),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConst.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save as Draft',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                  )))
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
  Widget configPage4(BuildContext context) {
    return Container(
      width: isMobileView(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.78,
      height: screenheight(context) * .73,
      padding: EdgeInsets.all(screenwidth(context) * .01),
      color: isdark
          ? ColorConst.rightcontainerdark
          : ColorConst.rightcontainerlite,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      initialtabs = ConfigPage.zero;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: ColorConst.secondary,
                  ),
                  label: const Text(
                    'Go back to dashboard',
                    style: TextStyle(
                        fontFamily: 'Nunito', color: ColorConst.secondary),
                  )),
              SizedBox(
                width: screenwidth(context) * .78,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Gadget Repair.Partner < A2Z Gadget Repair >',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: isMobileView(context)
                                ? 12
                                : screenwidth(context) * .02,
                            color: ColorConst.primary),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: screenwidth(context) * .15,
                        height: screenheight(context) * .1,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/a2zlogo.png'))),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenheight(context) * .03),
              Text(
                "Review and sign your contract",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobileView(context)
                        ? 12
                        : screenwidth(context) * 0.012),
              ),
              SizedBox(height: screenheight(context) * .01),
              Text(
                "We use digitaly signed contracts via Aadhar e-sign",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontSize: isMobileView(context)
                        ? 12
                        : screenwidth(context) * 0.012),
              ),
              SizedBox(height: screenheight(context) * .05),
              Container(
                width: isMobileView(context)
                    ? screenwidth(context)
                    : screenwidth(context) * 0.78,
                padding: EdgeInsets.all(screenwidth(context) * .025),
                decoration: BoxDecoration(
                    color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                    borderRadius: BorderRadius.circular(
                      screenwidth(context) * .005,
                    )),
                child: Column(
                  children: [
                    UploadData(
                        controller: pancontroller,
                        tittle: 'Review draft contract',
                        buttontittle: 'Send',
                        message: isMobileView(context)
                            ? 'Click to Send the draft\n contract to your email '
                            : 'Click to Send the draft contract to your email ',
                        ontap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final int? userid = prefs.getInt('UserID');
                          final how_often =
                              initialpaymentvalue == Payment.onetime
                                  ? "One Time"
                                  : initialpaymentvalue == Payment.monthly
                                      ? "Monthly"
                                      : initialpaymentvalue == Payment.quarterly
                                          ? "Quarterly"
                                          : initialpaymentvalue ==
                                                  Payment.every6months
                                              ? "Everysixmonths"
                                              : initialpaymentvalue ==
                                                      Payment.annualy
                                                  ? "Annualy"
                                                  : "Not given";
                          print(how_often);
                          Map<String, dynamic> data = {
                            "authSignatoryAadharNumber":
                                aadharnumber.text.toString(),
                            "authSignatoryEmailAddress": email.text.toString(),
                            "authSignatoryName": legalname.text.toString(),
                            "authSignatoryPhoneNumber":
                                phonenumber.text.toString(),
                            "basePrice": total.toString(),
                            "city": city.text.toString(),
                            "confirmation_for_customer_support":
                                customersupport,
                            "country": country.text.toString(),
                            "designation": designation.text.toString(),
                            "how_often": how_often,
                            "markup": "1",
                            "markupMoney": markupamount.toString(),
                            "markupPercentage": markup.toString(),
                            "party2Address": address.text.toString(),
                            "party2GST": gstcontroller.text.toString(),
                            "party2Name": businessname.text.toString(),
                            "party2PAN": pancontroller.text.toString(),
                            "postalCode": postalcode.text.toString(),
                            "repairRequest": reparerequest.toString(),
                            "selectedGadgets": products.toString(),
                            "selectedNumberOfGadgets":
                                products.length.toString(),
                            "user_id": userid,
                            "website": website.text.toString()
                          };
                          print(data);
                          try {
                            final response = await http.post(
                              Uri.parse(
                                  "https://deals.yexah.com:3000/providerref"),
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode(data),
                            );
                            print(response.statusCode);
                            if (response.statusCode == 200) {
                              // final pdfData = response.bodyBytes;
                              // print(pdfData);
                              // const String filename = 'Genareted contract.pdf';
                              // Uint8List pdfBytes =
                              //     Uint8List.fromList(pdfData.cast<int>());

                              // final blob = html.Blob(
                              //     [Uint8List.fromList(pdfBytes)],
                              //     'application/pdf');
                              // final url =
                              //     html.Url.createObjectUrlFromBlob(blob);
                              // final anchor = html.AnchorElement(href: url)
                              //   ..setAttribute('download', filename);
                              // anchor.click();
                              // html.Url.revokeObjectUrl(url);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("PDF Send to your email")));
                            } else {
                              // print(
                              //     'Error during API call: ${response.statusCode}');
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                          try {
                            var responseagreement = await http.post(
                              Uri.parse(
                                  'https://deals.yexah.com:3000/generateAgreementyexahSignature2'),
                              body: jsonEncode({
                                "id": userid,
                                "party2Name": brandname.text,
                                "party2Address": address.text,
                                "party2PAN": pancontroller.text,
                                "party2GST": gstcontroller.text,
                                "authSignatoryName": legalname.text,
                                "designation": designation.text,
                                "authSignatoryEmailAddress": email.text,
                                "authSignatoryPhoneNumber": phonenumber.text,
                              }),
                              headers: {'Content-Type': 'application/json'},
                            );

                            print(responseagreement.body);

                            if (responseagreement.statusCode == 200) {
                              // Get the application documents directory
                              // const String filename = 'Signed_contract.pdf';
                              // final pdfData = responseagreement.bodyBytes;

                              // final blob = html.Blob(
                              //     [Uint8List.fromList(pdfData)],
                              //     'application/pdf');
                              // final url =
                              //     html.Url.createObjectUrlFromBlob(blob);
                              // final anchor = html.AnchorElement(href: url)
                              //   ..setAttribute('download', filename);
                              // anchor.click();
                              // html.Url.revokeObjectUrl(url);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content:
                              //             Text("PDF send to your email")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error generating PDF'),
                                ),
                              );
                            }
                          } catch (error) {
                            print("Error: $error");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('An error occurred: $error'),
                              ),
                            );
                          }
                        }),
                    SizedBox(height: screenheight(context) * .05),
                    Text(
                      'A copy of the contract , signed from your end will be received on the email id of the authorized signatory to you within 24 hours. You can sign the contract from the email link or the section below',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          color: isdark
                              ? ColorConst.textdarkw
                              : ColorConst.textliteb,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobileView(context)
                              ? 12
                              : screenwidth(context) * 0.012),
                    ),
                    SizedBox(height: screenheight(context) * .05),
                    UploadData(
                        controller: pancontroller,
                        tittle: 'Sign contract',
                        subtittle:
                            'Please wait your contract will be ready for signature soon',
                        buttontittle: 'Select',
                        message: signedfilepicked
                            ? 'Uploded'
                            : 'Click to proceed sign',
                        ontap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? picked = await _picker.pickImage(
                              source: ImageSource.gallery);

                          if (picked != null) {
                            setState(() {
                              pickedImage = picked;
                            });

                            if (pickedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please select Sign')),
                              );
                              return;
                            }
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            final int userid = prefs.getInt('UserID')!;
                            final url = Uri.parse(
                                'https://deals.yexah.com:3000/save-signature');

                            try {
                              final imageBytes =
                                  await pickedImage!.readAsBytes();
                              final base64Image = base64Encode(imageBytes);

                              final response = await http.post(
                                url,
                                headers: {
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode({
                                  'user_id': userid,
                                  'signature_image': base64Image,
                                }),
                              );

                              if (response.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Signature saved successfully')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Error saving signature')),
                                );
                              }
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Error saving signature: $error')),
                              );
                              print('Error saving signature: $error');
                            }
                          }
                        }),
                    SizedBox(height: screenheight(context) * .05),
                    Text(
                      'Note: Once you sign the contract the API config is fixed. Please view and make changes if needed. Finalize configuration before signing.',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: isMobileView(context)
                              ? 12
                              : screenwidth(context) * 0.012,
                          color: Colors.red),
                    ),
                    Text(
                      'This step automatically gets completed once the Aadhar signature is successfully affixed on the contract by the authorized signatory mentioned by you. In case in-correct signatory details have been mentioned by you, kindly go back to the previous screen and generate the contract again.',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          color: isdark
                              ? ColorConst.textdarkw
                              : ColorConst.textliteb,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobileView(context)
                              ? 12
                              : screenwidth(context) * 0.012),
                    ),
                    SizedBox(height: screenheight(context) * .02),
                    UploadData(
                        controller: pancontroller,
                        tittle: 'Send Signed Contract',
                        subtittle: 'Proceed to your API kit and go Yexah!',
                        buttontittle: 'Send',
                        message: isMobileView(context)
                            ? 'Click to Send the copy of signed \ncontract to your mail'
                            : 'Click to Send the copy of signed contract to your mail',
                        ontap: () async {
                          final url = Uri.parse(
                              'https://deals.yexah.com:3000/generateAgreementyexahSignature1'); // Replace with your API endpoint URL

                          try {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            final int userid = prefs.getInt('UserID')!;
                            // print(userid);
                            final imageBytes = await pickedImage!.readAsBytes();
                            final base64Image = base64Encode(imageBytes);
                            final response = await http.post(
                              url,
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode({
                                "id": userid,
                                "party2Name": brandname.text,
                                "party2Address": address.text,
                                "party2PAN": pancontroller.text,
                                "party2GST": gstcontroller.text,
                                "authSignatoryName": legalname.text,
                                "designation": designation.text,
                                "authSignatoryEmailAddress": email.text,
                                "authSignatoryPhoneNumber": phonenumber.text,
                                'signatureImageData': base64Image,
                              }),
                            );

                            if (response.statusCode == 200) {
                              // Download the generated PDF with signature
                              // final pdfData = response.bodyBytes;
                              // // Save the PDF to a file or show it in the WebView
                              // final String filename =
                              //     'Genareted contract with signature.pdf';

                              // final blob = html.Blob(
                              //     [Uint8List.fromList(pdfData)],
                              //     'application/pdf');
                              // final url =
                              //     html.Url.createObjectUrlFromBlob(blob);
                              // final anchor = html.AnchorElement(href: url)
                              //   ..setAttribute('download', filename);
                              // anchor.click();
                              // html.Url.revokeObjectUrl(url);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Signed PDF send to your mail")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Error generating agreement with signature')),
                              );
                            }
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Error generating agreement with signature: $error')));

                            print(
                                'Error generating agreement with signature: $error');
                          }
                          const String apiUrl =
                              'https://deals.yexah.com:3000/send-email-new-contract-is-for-approve';

                          final Map<String, String> bodyy = {
                            'email': "admin@yexah.com",
                            'text':
                                "A new customer has been successfully onboarded and their deal has been meticulously configured.\n\n  Thank You",
                          };

                          try {
                            final response = await http.post(Uri.parse(apiUrl),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': '*/*',
                                },
                                body: jsonEncode(bodyy));
                            print(response.statusCode);
                          } catch (er) {
                            print(er.toString());
                          }
                        }),
                    SizedBox(height: screenheight(context) * .05),
                    Text(
                      'On successfully affixing the signature at your end, a signed copy of the contract is sent to your email id. Do click on save and next button below, post affixing signature to move to the next screen',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          color: isdark
                              ? ColorConst.textdarkw
                              : ColorConst.textliteb,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobileView(context)
                              ? screenwidth(context) * .03
                              : screenwidth(context) * .01),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              isMobileView(context)
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(width: screenwidth(context) * .3),
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  showpage5 = true;
                                  initialtabs = ConfigPage.five;
                                });
                                pancontroller.clear();
                                gstcontroller.clear();
                                logocontroller.clear();
                                businessname.clear();
                                brandname.clear();
                                legalname.clear();
                                address.clear();
                                city.clear();
                                postalcode.clear();
                                country.clear();
                                website.clear();
                                designation.clear();
                                email.clear();
                                phonenumber.clear();
                                aadharnumber.clear();
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                try {
                                  final int userid = prefs.getInt('UserID')!;
                                  final response = await http.post(
                                    Uri.parse(
                                        'https://deals.yexah.com:3000/configureContract/$userid'),
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                  );
                                  print(response.body);
                                } catch (er) {
                                  throw Exception('Error on configure contact');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConst.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save and Continue',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: ColorConst.white))),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConst.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save as Draft',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: ColorConst.white)))
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        SizedBox(width: screenwidth(context) * .3),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                showpage5 = true;
                                initialtabs = ConfigPage.five;
                              });
                              pancontroller.clear();
                              gstcontroller.clear();
                              logocontroller.clear();
                              businessname.clear();
                              brandname.clear();
                              legalname.clear();
                              address.clear();
                              city.clear();
                              postalcode.clear();
                              country.clear();
                              website.clear();
                              designation.clear();
                              email.clear();
                              phonenumber.clear();
                              aadharnumber.clear();
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              try {
                                final int userid = prefs.getInt('UserID')!;
                                final response = await http.post(
                                  Uri.parse(
                                      'https://deals.yexah.com:3000/configureContract/$userid'),
                                  headers: {'Content-Type': 'application/json'},
                                );
                                print(response.body);
                              } catch (er) {
                                throw Exception('Error on configure contact');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Save and Continue',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: ColorConst.white))),
                        const SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Save as Draft',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: ColorConst.white)))
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget configPage5(BuildContext context) {
    check();
    return Container(
      width: isMobileView(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.78,
      height: screenheight(context) * .73,
      padding: EdgeInsets.all(screenwidth(context) * .01),
      color: isdark
          ? ColorConst.rightcontainerdark
          : ColorConst.rightcontainerlite,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      initialtabs = ConfigPage.zero;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: ColorConst.secondary,
                  ),
                  label: const Text(
                    'Go back to dashboard',
                    style: TextStyle(
                        fontFamily: 'Nunito', color: ColorConst.secondary),
                  )),
              SizedBox(
                width: screenwidth(context) * .78,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Gadget Repair.Partner < A2Z Gadget Repair >',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: isMobileView(context)
                                ? 12
                                : screenwidth(context) * 0.012,
                            color: ColorConst.primary),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: screenwidth(context) * .15,
                        height: screenheight(context) * .1,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/a2zlogo.png'))),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenheight(context) * .03),
              Text(
                "Review and sign your contract",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                  fontSize:
                      isMobileView(context) ? 12 : screenwidth(context) * 0.012,
                ),
              ),
              SizedBox(height: screenheight(context) * .01),
              Text(
                "We use digitaly signed contracts via Aadhar e-sign",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                  fontSize:
                      isMobileView(context) ? 12 : screenwidth(context) * 0.012,
                ),
              ),
              SizedBox(height: screenheight(context) * .05),
              Container(
                width: screenwidth(context),
                padding: EdgeInsets.all(screenwidth(context) * .025),
                decoration: BoxDecoration(
                    color: isdark ? ColorConst.scaffoldDark : Colors.white,
                    borderRadius: BorderRadius.circular(
                      screenwidth(context) * .005,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    approvelpending
                        ? UploadData(
                            controller: pancontroller,
                            tittle: 'My API Kit',
                            subtittle:
                                'Please wait your API kit will be ready soon',
                            buttontittle: 'Pending',
                            message: 'Approvel Pending',
                            ontap: () async {},
                          )
                        : UploadData(
                            controller: pancontroller,
                            tittle: 'My API Kit',
                            subtittle: 'Your API kit will be ready ',
                            buttontittle: 'Download',
                            message: 'Click to download',
                            ontap: () async {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const PdfViewerWeb(
                              //           filePath: 'assets/pdf/apikit.pdf',

                              ByteData bytess = await rootBundle
                                  .load('assets/pdf/apikit.pdf');
                              final buffer = bytess.buffer;
                              final String filename = 'apikit.pdf';
                              var blob =
                                  html.Blob([bytess], 'text/plain', 'native');

                              var anchorElement = html.AnchorElement(
                                href: html.Url.createObjectUrlFromBlob(blob)
                                    .toString(),
                              )
                                ..setAttribute("download", filename)
                                ..click();
                            },
                          ),
                    SizedBox(height: screenheight(context) * .02),
                    SizedBox(height: screenheight(context) * .02),
                    Text(
                      'We take 2 business days, from the date of your signing the contract to generate your custom API kit. A copy of the kit will be sent to your email and can also be accessed from:',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobileView(context)
                            ? 12
                            : screenwidth(context) * 0.012,
                      ),
                    ),
                    SizedBox(height: screenheight(context) * .02),
                    Text(
                      '- This Screen',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobileView(context)
                            ? 12
                            : screenwidth(context) * 0.012,
                      ),
                    ),
                    SizedBox(height: screenheight(context) * .02),
                    Text(
                      '- Downloads section on your Yexah! Portal',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobileView(context)
                            ? 12
                            : screenwidth(context) * 0.012,
                      ),
                    ),
                    SizedBox(height: screenheight(context) * .02),
                    Text(
                      'Been over 2 days and your and your API kit is not received',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: isMobileView(context)
                            ? 12
                            : screenwidth(context) * 0.012,
                      ),
                    ),
                    SizedBox(height: screenheight(context) * .02),
                    Text(
                      'Please write to us at techsupport@yexah.com . We will respond within the same day.',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobileView(context)
                            ? 12
                            : screenwidth(context) * 0.012,
                      ),
                    ),
                    SizedBox(height: screenheight(context) * .05),
                  ],
                ),
              ),
              const FooterCon(),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(width: screenwidth(context) * .2),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Successfully completed'),
                              content: const Text(
                                  'The download section contains a description of the contract.'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final int? userid = prefs.getInt('UserID');
                                    try {
                                      var url = Uri.parse(
                                          'https://deals.yexah.com:3000/insert_providerplanref');
                                      var body = jsonEncode({
                                        "user_id": userid.toString(),
                                        "how_often":
                                            initialpaymentvalue.toString(),
                                        "markupPercentage":
                                            markuppercentage.toString(),
                                        "repairRequest":
                                            reparerequest.toString(),
                                        " basePrice": total,
                                        " markupMoney": markupamount,
                                        " markup": markuppercentage,
                                        "confirmation_for_customer_support":
                                            customersupport.toString(),
                                        "party2Name": brandname.text,
                                        "party2Address": address.text,
                                        "city": city.text,
                                        "postalCode": postalcode.text,
                                        "country": country.text,
                                        "website": website.text,
                                        "party2PAN": pancontroller.text,
                                        "party2GST": gstcontroller.text,
                                        "authSignatoryName": legalname.text,
                                        "designation": designation.text,
                                        "authSignatoryEmailAddress": email.text,
                                        "authSignatoryPhoneNumber":
                                            phonenumber.text,
                                        "authSignatoryAadharNumber":
                                            aadharnumber.text,
                                        "selectedGadgets": products.toString(),
                                        "selectedNumberOfGadgets":
                                            products.length.toString(),
                                      });

                                      var response = await http
                                          .post(url, body: body, headers: {
                                        'Content-Type': 'application/json',
                                        'Accept': '*/*',
                                      });
                                      print(body);

                                      if (response.statusCode == 200) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePageWeb()),
                                            (route) => false);
                                      } else {
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //     const SnackBar(
                                        //         content: Text('Something went wrong!')));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    response.body.toString())));
                                      }
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(error.toString())));
                                    }

                                    setState(() {
                                      initialtabs = ConfigPage.zero;
                                      customersupport
                                          ? showcustomersupporttab = true
                                          : showcustomersupporttab = false;
                                    });
                                    Navigator.pop(context);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePageWeb()),
                                        (route) => false);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              screenwidth(context) * .005),
                        ),
                      ),
                      child: Text('Save and Continue',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: isMobileView(context)
                                  ? 12
                                  : screenwidth(context) * 0.012,
                              color: Colors.white))),
                  SizedBox(width: screenwidth(context) * .01),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              screenwidth(context) * .005),
                        ),
                      ),
                      child: Text('Save as Draft',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: isMobileView(context)
                                  ? 12
                                  : screenwidth(context) * 0.012,
                              color: Colors.white)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double markuptotal() {
    initialpaymentvalue == Payment.onetime
        ? total = 250 * products.length + (170 * reparerequest)
        : initialpaymentvalue == Payment.monthly
            ? total = 25 * products.length + (15 * reparerequest)
            : total = 0;
    markupamount = total * markuppercentage * .01;
    return total;
  }

  double totalzzz() {
    initialpaymentvalue == Payment.onetime
        ? totalfinal =
            250 * products.length + (170 * reparerequest) + markupamount
        : initialpaymentvalue == Payment.monthly
            ? totalfinal =
                25 * products.length + (15 * reparerequest) + markupamount
            : totalfinal = 0;
    print(totalfinal);
    return totalfinal;
  }

  List<String> productcount() {
    setState(() {
      mobile && !products.contains('Mobile')
          ? products.add('Mobile')
          : !mobile && products.contains('Mobile')
              ? products.remove('Mobile')
              : laptop && !products.contains('Laptop')
                  ? products.add('Laptop')
                  : !laptop && products.contains('Laptop')
                      ? products.remove('Laptop')
                      : tv && !products.contains('Tv')
                          ? products.add('Tv')
                          : !tv && products.contains('Tv')
                              ? products.remove('Tv')
                              : ac && !products.contains('Ac')
                                  ? products.add('Ac')
                                  : !ac && products.contains('Ac')
                                      ? products.remove('Ac')
                                      : fridge && !products.contains('Fridge')
                                          ? products.add('Fridge')
                                          : !fridge &&
                                                  products.contains('Fridge')
                                              ? products.remove('Fridge')
                                              : products;
      print(products);
    });
    return products;
  }

  String _removeStringAfterDotOrSpace(String text) {
    int index = text.indexOf(".");
    if (index == -1) {
      index = text.indexOf(" ");
    }
    if (index == -1) {
      return text;
    } else {
      return text.substring(0, index);
    }
  }

  Future<void> check() async {
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
        final configuretype = res["configuretype"];
        final approvedtype = res["approvedtype"].toString();
        // print(configuretype.toString());
        // print(approvedtype);
        setState(() {
          configuretype == 1 ? showpage5 = true : showpage5 = false;
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
