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

class TransactionRevenue extends StatefulWidget {
  final BuildContext ctx;
  const TransactionRevenue({super.key, required this.ctx});

  @override
  State<TransactionRevenue> createState() => _TransactionRevenueState();
}

List<Map<String, dynamic>> dataList = [];
String selectedValue = 'Deal 1';
List<String> dropdownItems = ['Deal 1', 'Deal 2', 'Deal 3'];
String selectedProviderValue = 'Provider 1';
List<String> providerdropdownItems = ['Provider 1', 'Provider 2', 'Provider 3'];
bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width <
      600; // You can adjust this threshold
}

class _TransactionRevenueState extends State<TransactionRevenue> {
  @override
  void initState() {
    fetchData();
    super.initState();
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
                SizedBox(
                  height: screenheight(context) * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                ),
                SizedBox(
                  height: screenheight(context) * 0.06,
                ),
                SizedBox(
                  width: isMobileView(context)
                      ? screenwidth(context)
                      : screenwidth(context) * .78,
                  child: isMobileView(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _selectDealType(context),
                            SizedBox(
                              height: screenwidth(context) * .10,
                            ),
                            _ConsumerEmailIDType(context, 'Customer Email id'),
                            SizedBox(
                              height: screenwidth(context) * .10,
                            ),
                            _ConsumerEmailIDType(
                                context, ' Duration (In days)'),
                            isadmin == 1
                                ? _selectProviderType(context)
                                : SizedBox(
                                    width: screenwidth(context) * .16,
                                  ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _selectDealType(context),
                            _ConsumerEmailIDType(context, 'Customer Email id'),
                            _ConsumerEmailIDType(
                                context, ' Duration (In days)'),
                            isadmin == 1
                                ? _selectProviderType(context)
                                : SizedBox(
                                    width: screenwidth(context) * .16,
                                  ),
                          ],
                        ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: _btns(),
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
        const FooterCon()
      ],
    );
  }

  Widget _table() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
          ),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(
                      label: Text(
                    'Provider Plan Ref',
                    style: TextStyle(
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb),
                  )),
                  DataColumn(
                      label: Text('Yexah Ref No',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Plan Start',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Plan Validity',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Invoice Date',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Invoice',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Customer Name',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                ],
                rows: dataList.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text('${data['providerefno']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['yexahrefno']}',
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
                      DataCell(Text('${data['invoicedate']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['invoiced']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['customername']}',
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

  Widget _btns() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: isMobileView(context)
                ? screenwidth(context) * 0.25
                : screenwidth(context) * 0.1,
            child: PrimaryBtn(
              btnText: 'Clear',
              onpressed: () {},
              height: screenheight(context) * 0.06,
            ),
          ),
          SizedBox(
            width: screenwidth(context) * 0.04,
          ),
          SizedBox(
            width: isMobileView(context)
                ? screenwidth(context) * 0.25
                : screenwidth(context) * 0.1,
            child: PrimaryBtn(
              btnText: 'Search',
              onpressed: () {},
              height: screenheight(context) * 0.06,
            ),
          )
        ],
      );
  Widget _selectDealType(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: isMobileView(context)
              ? screenwidth(context)
              : screenwidth(context) * .175,
          height: isMobileView(context)
              ? screenheight(context) * .1
              : screenheight(context) * .16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
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
                  fontWeight: FontWeight.bold),
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
                                : ColorConst.textliteb,
                          )),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
  Widget _selectProviderType(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: isMobileView(context)
              ? screenwidth(context) * .30
              : screenwidth(context) * .175,
          height: screenheight(context) * .16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Texttxt(
                  color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                  fontsize: screenwidth(context) * .015,
                  text: 'Select  Provider',
                  fontWeight: FontWeight.bold),
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
                      child: Text(value,
                          style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                          )),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget _ConsumerEmailIDType(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: isMobileView(context)
              ? screenwidth(context) * .30
              : screenwidth(context) * .175,
          height: screenheight(context) * .16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
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
                  text: text,
                  fontWeight: FontWeight.bold),
              SizedBox(
                  height: screenheight(context) * 0.05, child: TextFormField()),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt('UserID');
    print(userid.toString());
    print(userid.runtimeType);
    try {
      final url = isadmin == 0
          ? 'https://deals.yexah.com:3000/get_transactions/$userid'
          : 'https://deals.yexah.com:3000/get_transactions';
      final response = await http.get(Uri.parse(url));
      // print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            dataList = List.from(data['transactionsData']);
          });
          print(dataList);
        }
      } else {
        // Handle error if needed
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (er) {
      throw Exception('error transaction data');
    }
  }
}
