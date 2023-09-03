import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/widgets/faqs.dart';
import 'package:yexah/web/widgets/my_account.dart';
import '../widgets/customer_intraction.dart';
import '../widgets/dashboard.dart';
import '../widgets/deals.dart';
import '../widgets/downloads.dart';
import '../widgets/excel_upload.dart';
import '../widgets/raise_ticket.dart';
import '../widgets/report_customer.dart';
import '../widgets/report_revenue.dart';
import '../widgets/service_tickets.dart';
import '../widgets/settings.dart';
import '../widgets/transaction_customer.dart';
import '../widgets/transaction_data.dart';
import '../widgets/transaction_revenue.dart';
import '../const/const.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'notification.dart';
import 'package:http/http.dart' as http;

bool isdark = false;
int isadmin = 0;

enum Tabz {
  deals,
  revenueDashbord,
  revenueTransaction,
  revenueReports,
  customerServiceticket,
  customerTransaction,
  customerReports,
  customerIntraction,
  myaccount,
  settings,
  downloads,
  faq,
  raiseticket,
  excelupload,
  dataentry
}

Enum initialtab = Tabz.deals;

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key});

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

final namecontroller = TextEditingController();
final yexarefnocontroller = TextEditingController();
final providerplanrefcontroller = TextEditingController();
final planstartcontroller = TextEditingController();
final planvaliditycontroller = TextEditingController();
final invoicecontroller = TextEditingController();
final invoicedatecontroller = TextEditingController();

final List<Map<String, String>> dataList = [
  {
    'providerplanref': 'Plan 1',
    'Yexahrefno': 'Ref 1',
    'planstart': 'Start 1',
    'planvalidity': 'Validity 1',
    'invoicedate': 'Date 1',
    'invoiced': 'Invoice 1',
    'customername': 'Customer 1',
  },
  {
    'providerplanref': 'Plan 2',
    'Yexahrefno': 'Ref 2',
    'planstart': 'Start 2',
    'planvalidity': 'Validity 2',
    'invoicedate': 'Date 2',
    'invoiced': 'Invoice 2',
    'customername': 'Customer 2',
  },
];

class _HomePageWebState extends State<HomePageWeb> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width <
        600; // You can adjust this threshold
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checksupport();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          isdark ? ColorConst.scaffoldDark : ColorConst.scaffoldlite,
      drawer: Drawer(
          backgroundColor:
              isdark ? ColorConst.scaffoldDark : ColorConst.scaffoldlite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        initialtab = Tabz.deals;
                        initialtabs = ConfigPage.zero;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobileView(context) ? 10 : 30),
                      decoration: BoxDecoration(
                        color: isdark
                            ? ColorConst.scaffoldDark
                            : ColorConst.scaffoldlite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: isMobileView(context) ? double.infinity : 300,
                      height: isMobileView(context) ? 120 : 90,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: isMobileView(context) ? 40 : 80,
                              height: isMobileView(context) ? 40 : 80,
                              child: Image.asset(
                                'assets/images/yexah_fire_logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: isMobileView(context) ? 5 : 10,
                            ),
                            Expanded(
                              child: Text(
                                'Deals @ YEXAH!',
                                style: TextStyle(
                                  fontSize: initialtab == Tabz.deals
                                      ? isMobileView(context)
                                          ? 18
                                          : 16
                                      : isMobileView(context)
                                          ? 18
                                          : 16,
                                  color: initialtab == Tabz.deals
                                      ? isdark
                                          ? ColorConst.dealdark
                                          : ColorConst.deallite
                                      : isdark
                                          ? ColorConst.white
                                          : ColorConst.black,
                                  fontWeight: initialtab == Tabz.deals
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  title: Row(
                    children: [
                      SizedBox(width: screenwidth(context) * .011),
                      SizedBox(
                          width: isMobileView(context) ? 40 : 80,
                          height: isMobileView(context) ? 40 : 80,
                          child: Image.asset(
                            'assets/images/increase.png',
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Yexah! Revenue',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb,
                              fontFamily: 'Nunito'),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          initialtab = Tabz.revenueDashbord;
                        });
                      },
                      child: ListTile(
                        leading: SizedBox(
                          width: screenwidth(context) * .011,
                        ),
                        title: Text(
                          'Dashboard',
                          style: TextStyle(
                            color: initialtab == Tabz.revenueDashbord
                                ? ColorConst.secondary
                                : isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                            fontSize: isMobileView(context)
                                ? (initialtab == Tabz.revenueDashbord ? 14 : 12)
                                : (initialtab == Tabz.revenueDashbord
                                    ? 18
                                    : 14),
                            fontFamily: 'Nunito',
                            fontWeight: initialtab == Tabz.revenueDashbord
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          initialtab = Tabz.revenueTransaction;
                        });
                      },
                      child: ListTile(
                          leading: SizedBox(
                            width: screenwidth(context) * .011,
                          ),
                          title: Text('Transaction',
                              style: TextStyle(
                                  color: initialtab == Tabz.revenueTransaction
                                      ? ColorConst.secondary
                                      : isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? (initialtab == Tabz.revenueDashbord
                                          ? 14
                                          : 12)
                                      : (initialtab == Tabz.revenueDashbord
                                          ? 18
                                          : 14),
                                  fontFamily: 'Nunito',
                                  fontWeight:
                                      initialtab == Tabz.revenueTransaction
                                          ? FontWeight.bold
                                          : FontWeight.normal))),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          initialtab = Tabz.revenueReports;
                        });
                      },
                      child: ListTile(
                          leading: SizedBox(
                            width: screenwidth(context) * .011,
                          ),
                          title: Text('Reports',
                              style: TextStyle(
                                  color: initialtab == Tabz.revenueReports
                                      ? ColorConst.secondary
                                      : isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? (initialtab == Tabz.revenueDashbord
                                          ? 14
                                          : 12)
                                      : (initialtab == Tabz.revenueDashbord
                                          ? 18
                                          : 14),
                                  fontFamily: 'Nunito',
                                  fontWeight: initialtab == Tabz.revenueReports
                                      ? FontWeight.bold
                                      : FontWeight.normal))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      ExpansionTile(
                        shape: Border.all(color: Colors.transparent),
                        title: Row(
                          children: [
                            SizedBox(width: screenwidth(context) * .011),
                            SizedBox(
                                width: isMobileView(context) ? 40 : 80,
                                height: isMobileView(context) ? 40 : 80,
                                child: Image.asset(
                                  'assets/images/customer_support_logo.png',
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Customer Support\nModule',
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb,
                                    fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          showcustomersupporttab
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      initialtab = Tabz.customerServiceticket;
                                    });
                                  },
                                  child: ListTile(
                                    leading: SizedBox(
                                      width: screenwidth(context) * .011,
                                    ),
                                    title: Text(
                                      'Service Ticket',
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: initialtab ==
                                                  Tabz.customerServiceticket
                                              ? ColorConst.secondary
                                              : isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                          fontSize: isMobileView(context)
                                              ? (initialtab ==
                                                      Tabz.revenueDashbord
                                                  ? 14
                                                  : 12)
                                              : (initialtab ==
                                                      Tabz.revenueDashbord
                                                  ? 18
                                                  : 14),
                                          fontWeight: initialtab ==
                                                  Tabz.customerServiceticket
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.customerTransaction;
                              });
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: screenwidth(context) * .011,
                              ),
                              title: Text(
                                'Transaction',
                                style: TextStyle(
                                    fontSize: isMobileView(context)
                                        ? (initialtab == Tabz.revenueDashbord
                                            ? 14
                                            : 12)
                                        : (initialtab == Tabz.revenueDashbord
                                            ? 18
                                            : 14),
                                    fontWeight:
                                        initialtab == Tabz.customerTransaction
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        initialtab == Tabz.customerTransaction
                                            ? ColorConst.secondary
                                            : isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                    fontFamily: 'Nunito'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.customerReports;
                              });
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: screenwidth(context) * .011,
                              ),
                              title: Text(
                                'Reports',
                                style: TextStyle(
                                  fontWeight: initialtab == Tabz.customerReports
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: initialtab == Tabz.customerReports
                                      ? ColorConst.secondary
                                      : isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? (initialtab == Tabz.revenueDashbord
                                          ? 14
                                          : 12)
                                      : (initialtab == Tabz.revenueDashbord
                                          ? 18
                                          : 14),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.customerIntraction;
                              });
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: screenwidth(context) * .011,
                              ),
                              title: Text(
                                'Customer Interaction',
                                style: TextStyle(
                                    fontWeight:
                                        initialtab == Tabz.customerIntraction
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color: initialtab == Tabz.customerIntraction
                                        ? ColorConst.secondary
                                        : isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb,
                                    fontSize: isMobileView(context)
                                        ? (initialtab == Tabz.revenueDashbord
                                            ? 14
                                            : 12)
                                        : (initialtab == Tabz.revenueDashbord
                                            ? 18
                                            : 14),
                                    fontFamily: 'Nunito'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.dataentry;
                              });
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: screenwidth(context) * .011,
                              ),
                              title: Text(
                                'Transaction Datas',
                                style: TextStyle(
                                    fontWeight: initialtab == Tabz.dataentry
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: initialtab == Tabz.dataentry
                                        ? ColorConst.secondary
                                        : isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb,
                                    fontSize: isMobileView(context)
                                        ? (initialtab == Tabz.revenueDashbord
                                            ? 14
                                            : 12)
                                        : (initialtab == Tabz.revenueDashbord
                                            ? 18
                                            : 14),
                                    fontFamily: 'Nunito'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.excelupload;
                              });
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: screenwidth(context) * .011,
                              ),
                              title: Text(
                                'Upload Excel',
                                style: TextStyle(
                                    fontWeight: initialtab == Tabz.excelupload
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: initialtab == Tabz.excelupload
                                        ? ColorConst.secondary
                                        : isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb,
                                    fontSize: isMobileView(context)
                                        ? (initialtab == Tabz.revenueDashbord
                                            ? 14
                                            : 12)
                                        : (initialtab == Tabz.revenueDashbord
                                            ? 18
                                            : 14),
                                    fontFamily: 'Nunito'),
                              ),
                            ),
                          ),
                          showcustomersupporttab
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      initialtab = Tabz.raiseticket;
                                    });
                                  },
                                  child: ListTile(
                                    leading: SizedBox(
                                      width: screenwidth(context) * .011,
                                    ),
                                    title: Text(
                                      'Raise Service Tickets',
                                      style: TextStyle(
                                          color: initialtab == Tabz.raiseticket
                                              ? ColorConst.secondary
                                              : isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                          fontSize: isMobileView(context)
                                              ? (initialtab ==
                                                      Tabz.revenueDashbord
                                                  ? 14
                                                  : 12)
                                              : (initialtab ==
                                                      Tabz.revenueDashbord
                                                  ? 18
                                                  : 14),
                                          fontWeight:
                                              initialtab == Tabz.raiseticket
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          fontFamily: 'Nunito'),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initialtab = Tabz.myaccount;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(left: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .6,
                      height: 50,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                                width: isMobileView(context) ? 40 : 80,
                                height: isMobileView(context) ? 40 : 80,
                                child: Image.asset(
                                  'assets/images/my_account_logo.png',
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'My Account',
                                style: TextStyle(
                                    fontSize: isMobileView(context)
                                        ? screenwidth(context) * .035
                                        : screenwidth(context) * .006,
                                    color: initialtab == Tabz.myaccount
                                        ? ColorConst.secondary
                                        : isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb,
                                    fontFamily: 'Nunito',
                                    fontWeight: initialtab == Tabz.myaccount
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: isMobileView(context) ? 10 : 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initialtab = Tabz.settings;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(
                        left: 13,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .6,
                      height: 40,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                                width: isMobileView(context) ? 40 : 80,
                                height: isMobileView(context) ? 40 : 80,
                                child: Image.asset(
                                  'assets/images/my_account_logo_new.png',
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: isMobileView(context)
                                      ? screenwidth(context) * .035
                                      : screenwidth(context) * .006,
                                  color: initialtab == Tabz.settings
                                      ? ColorConst.secondary
                                      : isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                  fontWeight: initialtab == Tabz.downloads
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontFamily: 'Nunito'),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initialtab = Tabz.downloads;
                      initialdownloadtab = Downloadtab.main;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(
                        left: 13,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .6,
                      height: 40,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                                width: isMobileView(context) ? 40 : 80,
                                height: isMobileView(context) ? 40 : 80,
                                child: Image.asset(
                                  'assets/images/download_logo.png',
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Downloads',
                              style: TextStyle(
                                  fontSize: isMobileView(context)
                                      ? screenwidth(context) * .035
                                      : screenwidth(context) * .006,
                                  color: initialtab == Tabz.downloads
                                      ? ColorConst.secondary
                                      : isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                  fontWeight: initialtab == Tabz.downloads
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontFamily: 'Nunito'),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initialtab = Tabz.faq;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .6,
                      height: 40,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                                width: isMobileView(context) ? 40 : 80,
                                height: isMobileView(context) ? 40 : 80,
                                child: Image.asset(
                                  'assets/images/faqs_logo.png',
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'FAQs',
                              style: TextStyle(
                                  fontSize: isMobileView(context)
                                      ? screenwidth(context) * .035
                                      : screenwidth(context) * .006,
                                  color: initialtab == Tabz.faq
                                      ? ColorConst.secondary
                                      : isdark
                                          ? ColorConst.textdarkw
                                          : ColorConst.textliteb,
                                  fontFamily: 'Nunito',
                                  fontWeight: initialtab == Tabz.faq
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )),
      body: SizedBox(
        height: screenheight(context),
        child: Column(
          children: [
            Row(
              children: [
                Visibility(
                  visible: screenwidth(context) <= 600,
                  child: SizedBox(
                    width: screenwidth(context) * .22,
                    height: screenheight(context) * .08,
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState
                            ?.openDrawer(); // Open the drawer
                      },
                    ),
                  ),
                ),
                SizedBox(
                    width: screenwidth(context) * .2,
                    height: screenheight(context) * .09,
                    child: Image.asset('assets/images/yexah_logo_home.png')),
                const Spacer(),
                SizedBox(
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                isdark = !isdark;
                              });
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              await prefs.setBool('darkmode', isdark);
                            },
                            icon: isdark
                                ? const Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.dark_mode_outlined,
                                    color: ColorConst.scaffoldDark,
                                  )),
                        IconButton(
                          onPressed: () {
                            if (isadmin == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationPage()));
                            } else {
                              return;
                            }
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/notification-1.svg",
                            color:
                                isdark ? Colors.white : ColorConst.scaffoldDark,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                  screenwidth(context) * .92,
                                  screenheight(context) * .09,
                                  0,
                                  0),
                              items: [
                                const PopupMenuItem(
                                  value: 'Profile',
                                  child: Text('Profile'),
                                ),
                                const PopupMenuItem(
                                  value: 'Settings',
                                  child: Text('Settings'),
                                ),
                                const PopupMenuItem(
                                  value: 'Logout',
                                  child: Text('Logout'),
                                ),
                              ],
                              elevation: 8,
                            ).then((value) async {
                              if (value != null) {
                                if (value == 'Profile') {
                                  setState(() {
                                    initialtab = Tabz.myaccount;
                                  });
                                } else if (value == 'Settings') {
                                  setState(() {
                                    initialtab = Tabz.settings;
                                  });
                                } else if (value == 'Logout') {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('UserID');
                                  await prefs.remove('Token');
                                  await prefs.remove('Admin');
                                  initialtab = Tabz.deals;
                                  await prefs.remove('Configuretype');
                                  await prefs.remove('Approvedtype');

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreenWeb(),
                                      ),
                                      (route) => false);
                                }
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: isMobileView(context)
                                ? screenwidth(context) * 0.019
                                : screenwidth(context) * 0.010,
                            backgroundImage: const AssetImage(
                                'assets/my_account_logo_new.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenwidth(context) * .025)
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: screenwidth(context) >= 600,
                  child: Container(
                    color: Colors.transparent,
                    width: screenwidth(context) * .211,
                    height: screenheight(context) * 0.91,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.deals;
                                initialtabs = ConfigPage.zero;
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 90,
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth(context) * .03,
                                          height: screenwidth(context) * .0255,
                                          child: Image.asset(
                                              'assets/images/yexah_fire_logo.png')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Deals @YEXAH!',
                                          style: TextStyle(
                                              fontSize: initialtab == Tabz.deals
                                                  ? screenwidth(context) * .013
                                                  : screenwidth(context) * .009,
                                              color: initialtab == Tabz.deals
                                                  ? isdark
                                                      ? ColorConst.dealdark
                                                      : ColorConst.deallite
                                                  : isdark
                                                      ? ColorConst.white
                                                      : ColorConst.black,
                                              fontWeight:
                                                  initialtab == Tabz.deals
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontFamily: 'Nunito'),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          ExpansionTile(
                            shape: Border.all(color: Colors.transparent),
                            title: Row(
                              children: [
                                SizedBox(width: screenwidth(context) * .011),
                                SizedBox(
                                    width: screenwidth(context) * .03,
                                    height: screenwidth(context) * .0255,
                                    child: Image.asset(
                                        'assets/images/increase.png')),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    'Yexah! Revenue',
                                    style: TextStyle(
                                        color: isdark
                                            ? ColorConst.textdarkw
                                            : ColorConst.textliteb,
                                        fontFamily: 'Nunito'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    initialtab = Tabz.revenueDashbord;
                                  });
                                },
                                child: ListTile(
                                    leading: SizedBox(
                                      width: screenwidth(context) * .011,
                                    ),
                                    title: Text('Dashboard',
                                        style: TextStyle(
                                            color: initialtab ==
                                                    Tabz.revenueDashbord
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontSize: initialtab ==
                                                    Tabz.revenueDashbord
                                                ? screenwidth(context) * .012
                                                : screenwidth(context) * .009,
                                            fontFamily: 'Nunito',
                                            fontWeight: initialtab ==
                                                    Tabz.revenueDashbord
                                                ? FontWeight.bold
                                                : FontWeight.normal))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    initialtab = Tabz.revenueTransaction;
                                  });
                                },
                                child: ListTile(
                                    leading: SizedBox(
                                      width: screenwidth(context) * .011,
                                    ),
                                    title: Text('Transaction',
                                        style: TextStyle(
                                            color: initialtab ==
                                                    Tabz.revenueTransaction
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontSize: initialtab ==
                                                    Tabz.revenueTransaction
                                                ? screenwidth(context) * .012
                                                : screenwidth(context) * .009,
                                            fontFamily: 'Nunito',
                                            fontWeight: initialtab ==
                                                    Tabz.revenueTransaction
                                                ? FontWeight.bold
                                                : FontWeight.normal))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    initialtab = Tabz.revenueReports;
                                  });
                                },
                                child: ListTile(
                                    leading: SizedBox(
                                      width: screenwidth(context) * .011,
                                    ),
                                    title: Text('Reports',
                                        style: TextStyle(
                                            color: initialtab ==
                                                    Tabz.revenueReports
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontSize: initialtab ==
                                                    Tabz.revenueReports
                                                ? screenwidth(context) * .012
                                                : screenwidth(context) * .009,
                                            fontFamily: 'Nunito',
                                            fontWeight: initialtab ==
                                                    Tabz.revenueReports
                                                ? FontWeight.bold
                                                : FontWeight.normal))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                ExpansionTile(
                                  shape: Border.all(color: Colors.transparent),
                                  title: Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth(context) * .013),
                                      SizedBox(
                                          width: screenwidth(context) * .03,
                                          height: screenwidth(context) * .0255,
                                          child: Image.asset(
                                              'assets/images/customer_support_logo.png')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Customer Support\nModule',
                                          style: TextStyle(
                                              fontSize:
                                                  screenwidth(context) * .009,
                                              color: isdark
                                                  ? ColorConst.textdarkw
                                                  : ColorConst.textliteb,
                                              fontFamily: 'Nunito'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    showcustomersupporttab
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                initialtab =
                                                    Tabz.customerServiceticket;
                                              });
                                            },
                                            child: ListTile(
                                              leading: SizedBox(
                                                width:
                                                    screenwidth(context) * .011,
                                              ),
                                              title: Text(
                                                'Service Ticket',
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: initialtab ==
                                                            Tabz
                                                                .customerServiceticket
                                                        ? ColorConst.secondary
                                                        : isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                    fontSize: initialtab ==
                                                            Tabz
                                                                .customerServiceticket
                                                        ? screenwidth(context) *
                                                            .012
                                                        : screenwidth(context) *
                                                            .009,
                                                    fontWeight: initialtab ==
                                                            Tabz.customerServiceticket
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          initialtab = Tabz.customerTransaction;
                                        });
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: screenwidth(context) * .011,
                                        ),
                                        title: Text(
                                          'Transaction',
                                          style: TextStyle(
                                              fontSize: initialtab ==
                                                      Tabz.customerTransaction
                                                  ? screenwidth(context) * .012
                                                  : screenwidth(context) * .009,
                                              fontWeight: initialtab ==
                                                      Tabz.customerTransaction
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: initialtab ==
                                                      Tabz.customerTransaction
                                                  ? ColorConst.secondary
                                                  : isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb,
                                              fontFamily: 'Nunito'),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          initialtab = Tabz.customerReports;
                                        });
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: screenwidth(context) * .011,
                                        ),
                                        title: Text(
                                          'Reports',
                                          style: TextStyle(
                                            fontWeight: initialtab ==
                                                    Tabz.customerReports
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: initialtab ==
                                                    Tabz.customerReports
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontSize: initialtab ==
                                                    Tabz.customerReports
                                                ? screenwidth(context) * .012
                                                : screenwidth(context) * .009,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          initialtab = Tabz.customerIntraction;
                                        });
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: screenwidth(context) * .011,
                                        ),
                                        title: Text(
                                          'Customer Interaction',
                                          style: TextStyle(
                                              fontWeight: initialtab ==
                                                      Tabz.customerIntraction
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: initialtab ==
                                                      Tabz.customerIntraction
                                                  ? ColorConst.secondary
                                                  : isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb,
                                              fontSize: initialtab ==
                                                      Tabz.customerIntraction
                                                  ? screenwidth(context) * .012
                                                  : screenwidth(context) * .009,
                                              fontFamily: 'Nunito'),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          initialtab = Tabz.dataentry;
                                        });
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: screenwidth(context) * .011,
                                        ),
                                        title: Text(
                                          'Transaction Datas',
                                          style: TextStyle(
                                              fontWeight:
                                                  initialtab == Tabz.dataentry
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              color: initialtab ==
                                                      Tabz.dataentry
                                                  ? ColorConst.secondary
                                                  : isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb,
                                              fontSize: initialtab ==
                                                      Tabz.dataentry
                                                  ? screenwidth(context) * .012
                                                  : screenwidth(context) * .009,
                                              fontFamily: 'Nunito'),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          initialtab = Tabz.excelupload;
                                        });
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: screenwidth(context) * .011,
                                        ),
                                        title: Text(
                                          'Upload Excel',
                                          style: TextStyle(
                                              fontWeight:
                                                  initialtab == Tabz.excelupload
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              color: initialtab ==
                                                      Tabz.excelupload
                                                  ? ColorConst.secondary
                                                  : isdark
                                                      ? ColorConst.textdarkw
                                                      : ColorConst.textliteb,
                                              fontSize: initialtab ==
                                                      Tabz.excelupload
                                                  ? screenwidth(context) * .012
                                                  : screenwidth(context) * .009,
                                              fontFamily: 'Nunito'),
                                        ),
                                      ),
                                    ),
                                    showcustomersupporttab
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                initialtab = Tabz.raiseticket;
                                              });
                                            },
                                            child: ListTile(
                                              leading: SizedBox(
                                                width:
                                                    screenwidth(context) * .011,
                                              ),
                                              title: Text(
                                                'Raise Service Tickets',
                                                style: TextStyle(
                                                    color: initialtab ==
                                                            Tabz.raiseticket
                                                        ? ColorConst.secondary
                                                        : isdark
                                                            ? ColorConst
                                                                .textdarkw
                                                            : ColorConst
                                                                .textliteb,
                                                    fontSize: initialtab ==
                                                            Tabz.raiseticket
                                                        ? screenwidth(context) *
                                                            .012
                                                        : screenwidth(context) *
                                                            .009,
                                                    fontWeight: initialtab ==
                                                            Tabz.raiseticket
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    fontFamily: 'Nunito'),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.myaccount;
                              });
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 50,
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth(context) * .05,
                                          height: screenwidth(context) * .025,
                                          child: Image.asset(
                                              'assets/images/my_account_logo_new.png')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'My account',
                                        style: TextStyle(
                                            fontSize:
                                                screenwidth(context) * .009,
                                            color: initialtab == Tabz.myaccount
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontFamily: 'Nunito',
                                            fontWeight:
                                                initialtab == Tabz.myaccount
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(width: screenwidth(context) * .011),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.settings;
                              });
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 50,
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth(context) * .05,
                                          height: screenwidth(context) * .025,
                                          child: Image.asset(
                                              'assets/images/my_account_logo.png')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Settings',
                                        style: TextStyle(
                                            fontSize: initialtab ==
                                                    Tabz.settings
                                                ? screenwidth(context) * .012
                                                : screenwidth(context) * .009,
                                            color: initialtab == Tabz.settings
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontFamily: 'Nunito',
                                            fontWeight:
                                                initialtab == Tabz.settings
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(height: isMobileView(context) ? 10 : 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.downloads;
                                initialdownloadtab = Downloadtab.main;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: isMobileView(context) ? 8 : 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: isMobileView(context)
                                  ? double.infinity
                                  : MediaQuery.of(context).size.width * 0.3,
                              height: 40,
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenwidth(context) * .05,
                                      height: screenwidth(context) * .025,
                                      child: Image.asset(
                                          'assets/images/download_logo.png'),
                                    ),
                                    SizedBox(
                                        width: isMobileView(context) ? 5 : 10),
                                    Text(
                                      'Downloads',
                                      style: TextStyle(
                                        fontSize: isMobileView(context)
                                            ? (initialtab == Tabz.downloads
                                                ? 14
                                                : 12)
                                            : (initialtab == Tabz.downloads
                                                ? 18
                                                : 14),
                                        color: initialtab == Tabz.downloads
                                            ? ColorConst.secondary
                                            : isdark
                                                ? ColorConst.textdarkw
                                                : ColorConst.textliteb,
                                        fontWeight: initialtab == Tabz.downloads
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                initialtab = Tabz.faq;
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 40,
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: screenwidth(context) * .05,
                                          height: screenwidth(context) * .025,
                                          child: Image.asset(
                                              'assets/images/faqs_logo.png')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'FAQs',
                                        style: TextStyle(
                                            fontSize: initialtab == Tabz.faq
                                                ? screenwidth(context) * .012
                                                : screenwidth(context) * .009,
                                            color: initialtab == Tabz.faq
                                                ? ColorConst.secondary
                                                : isdark
                                                    ? ColorConst.textdarkw
                                                    : ColorConst.textliteb,
                                            fontFamily: 'Nunito',
                                            fontWeight: initialtab == Tabz.faq
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                initialtab == Tabz.deals
                    ? Deals(ctx: context)
                    : initialtab == Tabz.revenueDashbord
                        ? DashBoard(ctx: context)
                        : initialtab == Tabz.revenueTransaction
                            ? TransactionRevenue(ctx: context)
                            : initialtab == Tabz.revenueReports
                                ? ReportRevenue(ctx: context)
                                : initialtab == Tabz.customerServiceticket
                                    ? ServiceTickets(ctx: context)
                                    : initialtab == Tabz.customerTransaction
                                        ? TransactionCustomer(ctx: context)
                                        : initialtab == Tabz.customerReports
                                            ? ReportCustomer(ctx: context)
                                            : initialtab ==
                                                    Tabz.customerIntraction
                                                ? CustomerIntraction(
                                                    ctx: context)
                                                : initialtab == Tabz.myaccount
                                                    ? MyAccounts(ctx: context)
                                                    : initialtab ==
                                                            Tabz.settings
                                                        ? Settings(ctx: context)
                                                        : initialtab ==
                                                                Tabz.downloads
                                                            ? Downloads(
                                                                ctx: context)
                                                            : initialtab ==
                                                                    Tabz
                                                                        .excelupload
                                                                ? ExcelUpload(
                                                                    ctx:
                                                                        context)
                                                                : initialtab ==
                                                                        Tabz
                                                                            .raiseticket
                                                                    ? RaiseTicket(
                                                                        ctx:
                                                                            context)
                                                                    : initialtab ==
                                                                            Tabz
                                                                                .dataentry
                                                                        ? TransactionData(
                                                                            isdark:
                                                                                isdark)
                                                                        : Faqs(
                                                                            isdarkk:
                                                                                isdark,
                                                                          ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChatScreenWeb(),
          ));
        },
        backgroundColor: ColorConst.primary,
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> checksupport() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = await prefs.getInt('UserID');
      var url =
          Uri.parse('https://deals.yexah.com:3000/get_providerplanref/$id');

      var respon = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      });

      if (respon.statusCode == 200) {
        final Data = jsonDecode(respon.body);

        final customersupprt = Data["providerData"]
                ["confirmation_for_customer_support"]
            .toString();

        await prefs.setString('Customersupport', customersupprt);
        setState(() {
          customersupprt == '1'
              ? showcustomersupporttab = true
              : showcustomersupporttab = false;
        });
      } else {
        final customersupprt = '0';

        await prefs.setString('Customersupport', customersupprt);
        setState(() {
          customersupprt == '1'
              ? showcustomersupporttab = true
              : showcustomersupporttab = false;
        });
      }
    } catch (er) {
      print("customersupport$er");
    }
  }

  // logout(context) async {
  //   print('logoutcalled');
  //   Future.delayed(const Duration(hours: 1)).then((value) async {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.remove('Token');
  //     // final taction = prefs.getString('Token');
  //     // print(taction);
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const LoginScreenWeb()),
  //         (route) => false);
  //   });
  // }
}
