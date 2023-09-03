import 'package:flutter/material.dart';
import 'package:yexah/web/widgets/service_tickets.dart';
import 'package:yexah/web/widgets/text.dart';

import '../const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'button.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';

class CustomerIntraction extends StatefulWidget {
  final BuildContext ctx;
  const CustomerIntraction({super.key, required this.ctx});

  @override
  State<CustomerIntraction> createState() => _CustomerIntractionState();
}

String selectedValue = 'Deal 1';
List<String> dropdownItems = ['Deal 1', 'Deal 2', 'Deal 3'];
String selectedProviderValue = 'Provider 1';
List<String> providerdropdownItems = ['Provider 1', 'Provider 2', 'Provider 3'];

bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width <
      600; // You can adjust this threshold
}

class _CustomerIntractionState extends State<CustomerIntraction> {
  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return Column(
      children: [
        Container(
          width: isMobileView(context)
              ? screenwidth(context)
              : MediaQuery.of(context).size.width * 0.789,
          height: screenheight(widget.ctx) * 0.9,
          color: isdark
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 35),
                  child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                ),
                SizedBox(
                  height: screenheight(context) * 0.09,
                ),
                SizedBox(
                  child: isMobileView(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _selectDealType(context),
                            const SizedBox(
                              height: 20,
                            ),
                            TextAndTextfromFld(
                              text: 'Customer Email id',
                              isdarkk: isdark,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextAndTextfromFld(
                              text: 'Duration (In days)',
                              isdarkk: isdark,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isadmin == 0
                                ? _selectProviderType(context)
                                : SizedBox(
                                    width: screenwidth(context) * .175,
                                  ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _selectDealType(context),
                            TextAndTextfromFld(
                              text: 'Customer Email id',
                              isdarkk: isdark,
                            ),
                            TextAndTextfromFld(
                              text: 'Duration (In days)',
                              isdarkk: isdark,
                            ),
                            isadmin == 1
                                ? _selectProviderType(context)
                                : SizedBox(width: screenwidth(context) * .17),
                          ],
                        ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.05,
                ),
                ClearSearchBtns(
                  clearOnpressed: () {},
                  searchOnpressed: () {},
                ),
                SizedBox(
                  height: screenheight(context) * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: isMobileView(context)
                        ? screenwidth(context)
                        : screenwidth(context) * .78,
                    child: isMobileView(context)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextAndTextfromFldSearchBtn(
                                  text: 'Search by Customer Name',
                                  searchOnpressed: () {}),
                              SizedBox(
                                height: screenheight(context) * 0.02,
                              ),
                              TextAndTextfromFldSearchBtn(
                                  text: 'Search by Ticket Number',
                                  searchOnpressed: () {}),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextAndTextfromFldSearchBtn(
                                  text: 'Search by Customer Name',
                                  searchOnpressed: () {}),
                              const SizedBox(width: 20),
                              TextAndTextfromFldSearchBtn(
                                  text: 'Search by Ticket Number',
                                  searchOnpressed: () {}),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                _table(),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                const FooterCon()
              ],
            ),
          ),
        ),
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
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(
                      label: Text(
                    'Ticket Status',
                    style: TextStyle(
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb),
                  )),
                  DataColumn(
                      label: Text('Tickets Number',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Ticket Date',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Customer Name ',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Customer email',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                  DataColumn(
                      label: Text('Active',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                ],
                rows: dataList.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        '${data['TicketStatus']}',
                        style: TextStyle(
                            color: data['TicketStatus'] == 'open'
                                ? ColorConst.primary
                                : ColorConst.lightRed),
                      )),
                      DataCell(Text('${data['TicketsNumber']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['TicketDate']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['CustomerName']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Text('${data['Customeremail']}',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb))),
                      DataCell(Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View',
                                style: TextStyle(color: ColorConst.primary),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Reply',
                                style: TextStyle(color: ColorConst.primary),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Close',
                                style: TextStyle(color: ColorConst.primary),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Reopen',
                                style: TextStyle(color: ColorConst.primary),
                              ))
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );

  final List<Map<String, String>> dataList = [
    {
      'TicketStatus': 'open',
      'TicketsNumber': '176543',
      'TicketDate': '10/02/2023',
      'CustomerName': 'Sandeep Kumar',
      'Customeremail': 'Sandeep@gmail.com',
      'Active': '16',
    },
    {
      'TicketStatus': 'Closed',
      'TicketsNumber': '17098765',
      'TicketDate': '05/1/2023',
      'CustomerName': 'Tarun Singh',
      'Customeremail': 'Trarun@gmail.com',
      'Active': '16',
    },
    // Add more data as needed
  ];

  Widget _selectDealType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * .175,
        height: screenheight(context) * .155,
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
                    isdark ? ColorConst.textdarkw : ColorConst.textliteb,
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

  Widget _selectProviderType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
            : screenwidth(context) * .175,
        height: screenheight(context) * .155,
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
                    isdark ? ColorConst.textdarkw : ColorConst.textliteb,
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

class TextAndTextfromFldSearchBtn extends StatelessWidget {
  final String text;
  final Function()? searchOnpressed;
  const TextAndTextfromFldSearchBtn(
      {super.key, required this.text, required this.searchOnpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      width: isMobileView(context)
          ? screenwidth(context)
          : screenwidth(context) * .175,
      height: screenheight(context) * .184,
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
              text: text,
              fontWeight: FontWeight.w300),
          SizedBox(
              height: screenheight(context) * 0.05, child: TextFormField()),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConst.primary,
                  borderRadius: BorderRadius.circular(10)),
              width: isMobileView(context)
                  ? screenwidth(context) * 0.20
                  : screenwidth(context) * 0.075,
              child: TextButton(
                onPressed: searchOnpressed,
                child: Text(
                  'Search',
                  style: TextStyle(
                      fontSize: screenwidth(context) * 0.012,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
