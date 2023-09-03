import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yexah/web/widgets/text.dart';

import '../const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'button.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';

import 'package:http/http.dart' as http;

class ServiceTickets extends StatefulWidget {
  final BuildContext ctx;
  const ServiceTickets({super.key, required this.ctx});

  @override
  State<ServiceTickets> createState() => _ServiceTicketsState();
}

List<Map<String, dynamic>> dataList = [];
String selectedValue = 'Deal 1';
List<String> dropdownItems = ['Deal 1', 'Deal 2', 'Deal 3'];
String selectedProviderValue = 'Provider 1';
List<String> providerdropdownItems = ['Provider 1', 'Provider 2', 'Provider 3'];
String currentstatus = 'Open';
List<String> ticketstatus = ['Open', 'Close'];

bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width <
      600; // You can adjust this threshold
}

class _ServiceTicketsState extends State<ServiceTickets> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final userid = prefs.getInt('UserID');
    try {
      final response = await http.get(
          Uri.parse('https://deals.yexah.com:3000/servicetickets/$userid'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            dataList = List.from(data['serviceTickets']);
          });
        }
      } else {
        // Handle error if needed
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (er) {
      throw Exception('Error to rise survice ticket');
    }
  }

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
          padding: EdgeInsets.all(screenwidth(context) * .01),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 35),
                  child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                ),
                SizedBox(
                  height: screenheight(context) * 0.06,
                ),
                SizedBox(
                  width: screenwidth(context) * .78,
                  child: isMobileView(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 20),
                            _selectDealType(context),
                            const SizedBox(height: 20),
                            _selectProviderType(context),
                            const SizedBox(height: 20),
                            _selectTicketStatus(context)
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            _selectDealType(context),
                            const SizedBox(width: 20),
                            _selectProviderType(context),
                            const SizedBox(width: 20),
                            _selectTicketStatus(context)
                          ],
                        ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.04,
                ),
                SizedBox(
                  width: isMobileView(context)
                      ? screenwidth(context)
                      : screenwidth(context) * .78,
                  child: isMobileView(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextAndTextfromFld(
                                text: 'Customer Email id', isdarkk: isdark),
                            SizedBox(
                              height: screenheight(context) * 0.02,
                            ),
                            TextAndTextfromFld(
                                text: 'Duration (In days)', isdarkk: isdark),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            TextAndTextfromFld(
                                text: 'Customer Email id', isdarkk: isdark),
                            const SizedBox(width: 20),
                            TextAndTextfromFld(
                                text: 'Duration (In days)', isdarkk: isdark),
                          ],
                        ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.04,
                ),
                ClearSearchBtns(
                  clearOnpressed: () {},
                  searchOnpressed: () {},
                ),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                _table(),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
              ],
            ),
          ),
        ),
        const FooterCon(),
      ],
    );
  }

  Widget _table() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
          ),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection:
                  isMobileView(context) ? Axis.horizontal : Axis.vertical,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(
                      label: Text('Provider',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Status',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Issue',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Plan start',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Plan validity',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Name',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Your invoice No.',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Your invoice Date',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                ],
                rows: dataList.map((data) {
                  // print("print my data list");
                  // print(data);
                  return DataRow(
                    cells: [
                      DataCell(Text('${data['providerrefno']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(data['status'] == 'open'
                          ? TextButton(
                              onPressed: () {},
                              child: Text(
                                data['status'],
                                style:
                                    const TextStyle(color: ColorConst.primary),
                              ))
                          : TextButton(
                              onPressed: () {},
                              child: Text(
                                data['status'],
                                style:
                                    const TextStyle(color: ColorConst.lightRed),
                              ))),
                      DataCell(Text('${data['issue']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['planstart']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['planvalidity']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['customer']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['myinvoiceno']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['myinvoicedate']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );

  Widget _selectDealType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * .175,
        height: screenheight(context) * .16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Texttxt(
                color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                fontsize:
                    isMobileView(context) ? 12 : screenwidth(context) * 0.012,
                text: 'Select Deal Type',
                fontWeight: FontWeight.w300),
            Center(
              child: DropdownButton<String>(
                dropdownColor:
                    isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                underline: const SizedBox(),
                items: dropdownItems.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );

  Widget _selectTicketStatus(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * .175,
        height: screenheight(context) * .16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Texttxt(
                color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                fontsize:
                    isMobileView(context) ? 12 : screenwidth(context) * 0.012,
                text: 'Ticket Status',
                fontWeight: FontWeight.w300),
            Center(
              child: DropdownButton<String>(
                dropdownColor:
                    isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                value: currentstatus,
                onChanged: (newValue) {
                  setState(() {
                    currentstatus = newValue!;
                  });
                },
                underline: const SizedBox(),
                items: ticketstatus.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
  Widget _selectProviderType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * .175,
        height: screenheight(context) * .16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Texttxt(
                color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                fontsize:
                    isMobileView(context) ? 12 : screenwidth(context) * 0.012,
                text: 'Select  Provider',
                fontWeight: FontWeight.w300),
            Center(
              child: DropdownButton<String>(
                dropdownColor:
                    isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                value: selectedProviderValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedProviderValue = newValue!;
                  });
                },
                underline: const SizedBox(),
                items: providerdropdownItems.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: isdark
                              ? ColorConst.textdarkw
                              : ColorConst.textliteb),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
}

class TextAndTextfromFld extends StatelessWidget {
  final bool isdarkk;
  final String text;
  const TextAndTextfromFld(
      {super.key, required this.text, required this.isdarkk});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      width: isMobileView(context)
          ? screenwidth(context)
          : screenwidth(context) * .175,
      height: screenheight(context) * .16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isdarkk ? ColorConst.scaffoldDarklite : ColorConst.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Texttxt(
              color: isdarkk ? ColorConst.textdarkw : ColorConst.textliteb,
              fontsize:
                  isMobileView(context) ? 12 : screenwidth(context) * 0.012,
              text: text,
              fontWeight: FontWeight.w300),
          SizedBox(
              height: screenheight(context) * 0.05,
              child: TextFormField(
                style: TextStyle(
                    fontSize: isMobileView(context)
                        ? 12
                        : screenwidth(context) * 0.012,
                    color:
                        isdarkk ? ColorConst.textdarkw : ColorConst.textliteb),
              )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ClearSearchBtns extends StatelessWidget {
  final Function()? clearOnpressed;
  final Function()? searchOnpressed;
  const ClearSearchBtns(
      {super.key, required this.clearOnpressed, required this.searchOnpressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: isMobileView(context)
              ? screenwidth(context) * 0.22
              : screenwidth(context) * 0.1,
          child: PrimaryBtn(
            btnText: 'Clear',
            onpressed: clearOnpressed,
            height: screenheight(context) * 0.06,
          ),
        ),
        SizedBox(
          width: screenwidth(context) * 0.02,
        ),
        SizedBox(
          width: isMobileView(context)
              ? screenwidth(context) * 0.22
              : screenwidth(context) * 0.1,
          child: PrimaryBtn(
            btnText: 'Search',
            onpressed: searchOnpressed,
            height: screenheight(context) * 0.06,
          ),
        )
      ],
    );
  }
}
