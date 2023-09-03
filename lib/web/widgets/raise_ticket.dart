// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';
import 'package:http/http.dart' as http;

class RaiseTicket extends StatefulWidget {
  final BuildContext ctx;
  const RaiseTicket({super.key, required this.ctx});

  @override
  State<RaiseTicket> createState() => _RaiseTicketState();
}

final issuedisc = TextEditingController();
final invoicedate = TextEditingController();
final providerrefno = TextEditingController();
// final status = TextEditingController();
final date = TextEditingController();
final planstart = TextEditingController();
final planvalidity = TextEditingController();
final customer = TextEditingController();
final invoiceno = TextEditingController();
final riseticketformKey = GlobalKey<FormState>();
bool isloading = false;
bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width <
      600; // You can adjust this threshold
}

class _RaiseTicketState extends State<RaiseTicket> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isMobileView(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.78,
          height: screenheight(widget.ctx) * .8,
          color: isdark
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: EdgeInsets.all(
            screenwidth(context) * .01,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: riseticketformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                  SizedBox(height: screenwidth(context) * .05),
                  isMobileView(context)
                      ? Column(
                          children: [
                            Column(
                              children: [
                                const Text('Provider Reference Number'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: providerrefno,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your Provider referance number.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                            SizedBox(width: screenwidth(context) * .02),
                            Column(
                              children: [
                                const Text('Status'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: invoiceno,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your invoice number.';
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
                                const Text('Provider Reference Number'),
                                SizedBox(
                                    width: screenwidth(context) * .2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: providerrefno,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your Provider referance number.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                            SizedBox(width: screenwidth(context) * .02),
                            Column(
                              children: [
                                const Text('Status'),
                                SizedBox(
                                    width: screenwidth(context) * .2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: invoiceno,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your invoice number.';
                                          }
                                          return null;
                                        }))
                              ],
                            )
                          ],
                        ),
                  SizedBox(
                      height: isMobileView(context)
                          ? screenwidth(context) * .02
                          : screenheight(context) * .04),
                  isMobileView(context)
                      ? Column(
                          children: [
                            Column(
                              children: [
                                const Text('Issue'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: customer,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter customer name.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                            SizedBox(width: screenwidth(context) * .02),
                            Column(
                              children: [
                                const Text('Issue'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: issuedisc,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your issue';
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
                                const Text('Isuue'),
                                SizedBox(
                                    width: screenwidth(context) * .2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: customer,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter customer name.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                            SizedBox(width: screenwidth(context) * .02),
                            Column(
                              children: [
                                const Text('Issue'),
                                SizedBox(
                                    width: screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: issuedisc,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your issue';
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
                                const Text('Plan Started date'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        onTap: () async {
                                          final DateTime? picked;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 31)),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 1830)),
                                          );
                                          String selectedDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(picked!);
                                          setState(() {
                                            planstart.text = selectedDate;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: planstart,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your plan started date.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                            SizedBox(width: screenwidth(context) * .02),
                            Column(
                              children: [
                                const Text('Plan validity'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        onTap: () async {
                                          final DateTime? picked;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 31)),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 1830)),
                                          );
                                          String selectedDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(picked!);
                                          setState(() {
                                            planvalidity.text = selectedDate;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: planvalidity,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your plan ending date.';
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
                                const Text('Plan Started date'),
                                SizedBox(
                                    width: screenwidth(context) * .2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        onTap: () async {
                                          final DateTime? picked;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 31)),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 1830)),
                                          );
                                          String selectedDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(picked!);
                                          setState(() {
                                            planstart.text = selectedDate;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: planstart,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your plan started date.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                            SizedBox(width: screenwidth(context) * .02),
                            Column(
                              children: [
                                const Text('Plan validity'),
                                SizedBox(
                                    width: screenwidth(context) * .2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        onTap: () async {
                                          final DateTime? picked;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 31)),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 1830)),
                                          );
                                          String selectedDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(picked!);
                                          setState(() {
                                            planvalidity.text = selectedDate;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: planvalidity,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your plan ending date.';
                                          }
                                          return null;
                                        }))
                              ],
                            )
                          ],
                        ),
                  SizedBox(
                      height: isMobileView(context)
                          ? screenwidth(context) * .02
                          : screenheight(context) * .04),
                  isMobileView(context)
                      ? Column(
                          children: [
                            Column(
                              children: [
                                const Text('Invoice Date'),
                                SizedBox(
                                    width: isMobileView(context)
                                        ? screenwidth(context) * 0.8
                                        : screenwidth(context) * 0.2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        onTap: () async {
                                          final DateTime? picked;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 31)),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 1830)),
                                          );
                                          String selectedDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(picked!);
                                          setState(() {
                                            invoicedate.text = selectedDate;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: invoicedate,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your invoice date.';
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
                                const Text('Invoice Date'),
                                SizedBox(
                                    width: screenwidth(context) * .2,
                                    height: screenheight(context) * .08,
                                    child: TextFormField(
                                        onTap: () async {
                                          final DateTime? picked;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 31)),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 1830)),
                                          );
                                          String selectedDate =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(picked!);
                                          setState(() {
                                            invoicedate.text = selectedDate;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConst.primary,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: invoicedate,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your invoice date.';
                                          }
                                          return null;
                                        }))
                              ],
                            ),
                          ],
                        ),
                  SizedBox(
                      height: isMobileView(context)
                          ? screenwidth(context) * .02
                          : screenheight(context) * .04),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });

                        if (riseticketformKey.currentState!.validate()) {
                          riseticketformKey.currentState!.save();
                          try {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final int? userid = prefs.getInt('UserID');
                            var url = Uri.parse(
                                'https://deals.yexah.com:3000/servicetickets');
                            var body = jsonEncode({
                              "providerrefno": providerrefno.text,
                              "status": true,
                              "date": DateTime.now().toString(),
                              "issue": issuedisc.text,
                              "planstart": planstart.text,
                              "planvalidity": planvalidity.text,
                              "customer": customer.text,
                              "myinvoiceno": invoiceno.text,
                              "myinvoicedate": invoicedate.text,
                              "user_id": userid.toString()
                            });

                            var responselogin =
                                await http.post(url, body: body, headers: {
                              'Content-Type': 'application/json',
                              'Accept': '*/*',
                            });
                            // print(responselogin.statusCode);
                            // print(responselogin.body);

                            if (responselogin.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Your Issue is Noted')));
                            } else {
                              setState(() {
                                isloading = false;
                              });
                              Map error = jsonDecode(responselogin.body);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error["message"])));
                            }
                          } catch (error) {
                            setState(() {
                              isloading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Something Went Wrong!!')));
                          }

                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Submit Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobileView(context)
                              ? screenwidth(context) * .025
                              : screenwidth(context) * .01,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        const FooterCon()
      ],
    );
  }
}
