import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/const/color.dart';
import 'package:yexah/web/const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';

class TransactionData extends StatefulWidget {
  final bool isdark;
  const TransactionData({super.key, required this.isdark});

  @override
  State<TransactionData> createState() => _TransactionDataState();
}

class _TransactionDataState extends State<TransactionData> {
  final namecontroller = TextEditingController();
  final yexarefnocontroller = TextEditingController();
  final providerplanrefcontroller = TextEditingController();
  final planstartcontroller = TextEditingController();
  final planvaliditycontroller = TextEditingController();
  final invoicecontroller = TextEditingController();
  final invoicedatecontroller = TextEditingController();
  final email = TextEditingController();
  final amount = TextEditingController();
  bool isloading = false;
  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width <
        600; // You can adjust this threshold
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isMobileView(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.789,
          height: screenheight(context) * 0.85,
          color: isdark
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMobileView(context)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Customer Name",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Name',
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: namecontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Provider Plan Ref",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Provider Ref',
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: providerplanrefcontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Customer Name",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Name',
                                width: isMobileView(context) ? 100 : 300,
                                controller: namecontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Provider Plan Ref",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Provider Ref',
                                width: isMobileView(context) ? 100 : 300,
                                controller: providerplanrefcontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
              isMobileView(context)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Customer Email ID",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Email ID',
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: email,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Transaction amount",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: 'Amount',
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: amount,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Customer Email ID",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Email ID',
                                width: isMobileView(context) ? 100 : 300,
                                controller: email,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Transaction amount",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: 'Amount',
                                width: isMobileView(context) ? 100 : 300,
                                controller: amount,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
              isMobileView(context)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              " Yexah Ref Number",
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb),
                            ),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Yexah Ref',
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: yexarefnocontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Plan Start Date",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: planstartcontroller.text.isEmpty
                                    ? 'Select Date'
                                    : planstartcontroller.text,
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: planstartcontroller,
                                keybordtype: TextInputType.name,
                                ontap: () async {
                                  final DateTime? picked;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 31)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 1830)),
                                  );
                                  String selectedDate =
                                      DateFormat('yyyy/MM/dd').format(picked!);
                                  setState(() {
                                    planstartcontroller.text = selectedDate;
                                  });
                                }),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              " Yexah Ref Number",
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb),
                            ),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Yexah Ref',
                                width: isMobileView(context) ? 100 : 300,
                                controller: yexarefnocontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Plan Start Date",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: planstartcontroller.text.isEmpty
                                    ? 'Select Date'
                                    : planstartcontroller.text,
                                width: isMobileView(context) ? 100 : 300,
                                controller: planstartcontroller,
                                keybordtype: TextInputType.name,
                                ontap: () async {
                                  final DateTime? picked;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 31)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 1830)),
                                  );
                                  String selectedDate =
                                      DateFormat('yyyy/MM/dd').format(picked!);
                                  setState(() {
                                    planstartcontroller.text = selectedDate;
                                  });
                                }),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
              isMobileView(context)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Plan Validity Till",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: planvaliditycontroller.text.isEmpty
                                    ? 'Select Date'
                                    : planstartcontroller.text,
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: planvaliditycontroller,
                                keybordtype: TextInputType.name,
                                ontap: () async {
                                  final DateTime? picked;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 31)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 1830)),
                                  );
                                  String selectedDate =
                                      DateFormat('yyyy/MM/dd').format(picked!);
                                  setState(() {
                                    planvaliditycontroller.text = selectedDate;
                                  });
                                }),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Invoice",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Invoice Number',
                                width: isMobileView(context)
                                    ? screenwidth(context) * 0.8
                                    : screenwidth(context) * 3,
                                controller: invoicecontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Plan Validity Till",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: planvaliditycontroller.text.isEmpty
                                    ? 'Select Date'
                                    : planstartcontroller.text,
                                width: isMobileView(context) ? 100 : 300,
                                controller: planvaliditycontroller,
                                keybordtype: TextInputType.name,
                                ontap: () async {
                                  final DateTime? picked;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 31)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 1830)),
                                  );
                                  String selectedDate =
                                      DateFormat('yyyy/MM/dd').format(picked!);
                                  setState(() {
                                    planvaliditycontroller.text = selectedDate;
                                  });
                                }),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Invoice",
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb)),
                            const SizedBox(height: 10),
                            InputField(
                                label: ' Invoice Number',
                                width: isMobileView(context) ? 100 : 300,
                                controller: invoicecontroller,
                                keybordtype: TextInputType.name),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
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

                          final int? userid = prefs.getInt('UserID');

                          var url = Uri.parse(
                              'https://deals.yexah.com:3000/transactions');

                          try {
                            var response = await http.post(url,
                                body: jsonEncode({
                                  "user_id": userid.toString(),
                                  "customername": namecontroller.text,
                                  "email": email.text,
                                  "transaction_value": amount.text,
                                  "providerefno":
                                      providerplanrefcontroller.text,
                                  "yexah_ref": yexarefnocontroller.text,
                                  "planstart": planstartcontroller.text,
                                  "planvalidity": planvaliditycontroller.text,
                                  "invoicedate": DateTime.now().toString(),
                                  "invoiced": invoicecontroller.text
                                }),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': '*/*',
                                });
                            print(response.body);
                            setState(() {
                              isloading = false;
                            });
                            if (response.statusCode == 200) {
                              namecontroller.clear();
                              providerplanrefcontroller.clear();
                              yexarefnocontroller.clear();
                              planstartcontroller.clear();
                              planvaliditycontroller.clear();
                              invoicecontroller.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Successfully Uploaded')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Something went wrong!!')));
                            }
                          } catch (error) {
                            print(error.toString());
                          }
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

class InputField extends StatelessWidget {
  final String label;
  final double width;
  final TextEditingController controller;
  final TextInputType keybordtype;

  final double borderradious;
  final Function(String)? onchanged;
  final Function()? ontap;
  bool search;
  InputField(
      {super.key,
      required this.label,
      required this.width,
      required this.controller,
      required this.keybordtype,
      this.borderradious = 0,
      this.onchanged,
      this.ontap,
      this.search = false});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: width,
        height: 48,
        decoration: BoxDecoration(
          color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              fontFamily: 'Sora',
              color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderradious),
                    bottomLeft: Radius.circular(borderradious))),
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          controller: controller,
          onChanged: onchanged,
          onTap: ontap,
          style: const TextStyle(
            fontFamily: 'Sora',
            color: Color(0xFFBBAACC),
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          keyboardType: keybordtype,
          strutStyle: const StrutStyle(
            fontFamily: 'Sora',
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ]);
  }
}
