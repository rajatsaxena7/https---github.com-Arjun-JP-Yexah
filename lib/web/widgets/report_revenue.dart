import 'package:flutter/material.dart';
import 'package:yexah/web/widgets/text.dart';

import '../const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'button.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';

class ReportRevenue extends StatefulWidget {
  final BuildContext ctx;
  const ReportRevenue({super.key, required this.ctx});

  @override
  State<ReportRevenue> createState() => _ReportRevenueState();
}

class _ReportRevenueState extends State<ReportRevenue> {
  String selectedProviderValue = 'Customer Purchase \nsummary';
  List<String> providerdropdownItems = [
    'Customer Purchase \nsummary',
    'Service request Type'
  ];
  String selectedPeriod = 'Yesterday';
  List<String> selectedPeriodIteams = [
    'Yesterday',
    'Last month',
    'Last 7 Days',
    'Custom'
  ];
  String selectedFormat = 'Excel';
  List<String> selectedFormatIteams = [
    'Excel',
    'PDF',
    'CSV',
  ];
  bool isChecked = false;
  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
  }

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
          height: screenheight(widget.ctx) * 0.85,
          color: isdark
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: EdgeInsets.all(screenwidth(context) * .01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                ),
                SizedBox(
                  height: screenheight(context) * 0.08,
                ),
                const Center(
                  child: Texttxt(
                      color: Color.fromARGB(255, 243, 36, 78),
                      fontsize: 20,
                      text:
                          'You can generate reports or download from the list of recently generated report',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenheight(context) * 0.08,
                ),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                SizedBox(
                  width: isMobileView(context)
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width * .78,
                  child: isMobileView(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _selectPeriodType(context),
                            const SizedBox(height: 10),
                            _selectReportType(context),
                            const SizedBox(height: 10),
                            _selectFormatType(context),
                            const SizedBox(height: 10),
                            _selectReportTO(context),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _selectPeriodType(context),
                            _selectReportType(context),
                            _selectFormatType(context),
                            _selectReportTO(context),
                          ],
                        ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .78,
                  child: isMobileView(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                Center(
                  child: SizedBox(
                    width: isMobileView(context)
                        ? screenwidth(context) * 0.3
                        : screenwidth(context) * 0.15,
                    child: PrimaryBtn(
                      btnText: 'Generate',
                      onpressed: () {},
                      height: screenheight(context) * 0.06,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenheight(context) * 0.05,
                ),
                _table(),
              ],
            ),
          ),
        ),
        const FooterCon()
      ],
    );
  }

  // Widget recentReporttable() => Padding(
  //       padding: const EdgeInsets.only(left: 20, right: 20),
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: ColorConst.white,
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Texttxt(
  //                 color: isdark? ColorConst.textdarkw: ColorConst.textliteb,,
  //                 fontsize: 23,
  //                 text: 'Purchased Policy Report',
  //                 fontWeight: FontWeight.w400),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             Center(
  //               child: SingleChildScrollView(
  //                 scrollDirection: Axis.horizontal,
  //                 child: DataTable(
  //                   columnSpacing: 20,
  //                   columns: const [],
  //                   rows: dataList.map((data) {
  //                     return DataRow(
  //                       cells: [
  //                         DataCell(Text('${data['Sno']}')),
  //                         DataCell(Text('${data['Channel']}')),
  //                         DataCell(Text('${data['CustomerName']}')),
  //                         DataCell(Text('${data['EmailID']}')),
  //                         DataCell(Text('${data['InsuranceCertificateNo']}')),
  //                         DataCell(Text('${data['PlanCertificateNo']}')),
  //                         DataCell(Text('${data['Insurer']}')),
  //                         DataCell(Text('${data['SubscriptionAmount']}')),
  //                         DataCell(Text('${data['PlanType']}')),
  //                       ],
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );

  Widget _table() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texttxt(
                  color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                  fontsize: 23,
                  text: 'Purchased Policy Report',
                  fontWeight: FontWeight.w400),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: [
                      DataColumn(
                          label: Text(
                        'Sno.',
                        style: TextStyle(
                          color: isdark
                              ? ColorConst.textdarkw
                              : ColorConst.textliteb,
                        ),
                      )),
                      DataColumn(
                          label: Text('Channel',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Customer\nName',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Email ID',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Insurance\nCertificate\nNo.',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Plan\nCertificate\nNo.',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Insurer',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Subscription\nAmount',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                      DataColumn(
                          label: Text('Plan Type',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                    ],
                    rows: dataList.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text('${data['Sno']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['Channel']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['CustomerName']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['EmailID']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['InsuranceCertificateNo']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['PlanCertificateNo']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['Insurer']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['SubscriptionAmount']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                          DataCell(Text('${data['PlanType']}',
                              style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                              ))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  final List<Map<String, String>> dataList = [
    // {
    //   'Sno': '1',
    //   'Channel': 'Mobile App',
    //   'CustomerName': 'Tarun Singh',
    //   'EmailID': 'tarun@gmail.com',
    //   'InsuranceCertificateNo.': '5004/2030/1920',
    //   'PlanCertificateNo.': '162221932',
    //   'Insurer': 'ICIC',
    //   'SubscriptionAmount': '200',
    //   'PlanType': 'Extended Warranty',
    // },
    // {
    //   'Sno': '2',
    //   'Channel': 'Store POS',
    //   'CustomerName': 'Smarth',
    //   'EmailID': 'smarth@gmail.com',
    //   'InsuranceCertificateNo.': '5904/2030/1920',
    //   'PlanCertificateNo.': '172221932',
    //   'Insurer': 'ICIC',
    //   'SubscriptionAmount': '300',
    //   'PlanType': 'All Type Insurance ',
    // },
    // Add more data as needed
  ];

  Widget _selectReportTO(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
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
                fontsize: isMobileView(context)
                    ? screenwidth(context) * 0.030
                    : screenwidth(context) * .011,
                text: 'Select report to',
                fontWeight: FontWeight.w500),
            SizedBox(
              height: screenheight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Texttxt(
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontsize: isMobileView(context)
                        ? screenwidth(context) * 0.022
                        : screenwidth(context) * .01,
                    text: 'Tarun@gmail.com',
                    fontWeight: FontWeight.w400),
                Center(
                  child: GestureDetector(
                    onTap: _toggleCheckbox,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isChecked ? ColorConst.primary : Colors.grey,
                      ),
                      child: isChecked
                          ? Icon(
                              Icons.check,
                              size: 15,
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb,
                            )
                          : Container(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenheight(context) * 0.03,
            )
          ],
        ),
      );

  Widget _selectFormatType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
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
                fontsize: isMobileView(context)
                    ? screenwidth(context) * 0.030
                    : screenwidth(context) * .011,
                text: 'Select Format',
                fontWeight: FontWeight.w500),
            Center(
              child: DropdownButton<String>(
                dropdownColor:
                    isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                value: selectedFormat,
                onChanged: (newValue) {
                  setState(() {
                    selectedFormat = newValue!;
                  });
                },
                underline: const SizedBox(),
                items: selectedFormatIteams.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontSize: isMobileView(context)
                                ? screenwidth(context) * 0.02
                                : screenwidth(context) * 0.01,
                            fontFamily: 'Nunito')),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );

  Widget _selectPeriodType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
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
              fontsize: isMobileView(context)
                  ? screenwidth(context) * 0.03
                  : screenwidth(context) * .011,
              text: 'Select  period',
              fontWeight: FontWeight.w500,
            ),
            Center(
              child: DropdownButton<String>(
                dropdownColor:
                    isdark ? ColorConst.scaffoldDarklite : ColorConst.white,
                value: selectedPeriod,
                onChanged: (newValue) {
                  setState(() {
                    selectedPeriod = newValue!;
                  });
                },
                underline: const SizedBox(),
                items: selectedPeriodIteams.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: isdark
                                ? ColorConst.textdarkw
                                : ColorConst.textliteb,
                            fontSize: isMobileView(context)
                                ? 12
                                : screenwidth(context) * 0.01,
                            fontFamily: 'Nunito')),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );

  Widget _selectReportType(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        width: isMobileView(context)
            ? screenwidth(context)
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
                fontsize: isMobileView(context)
                    ? screenwidth(context) * 0.020
                    : screenwidth(context) * .011,
                text: 'Select  Provider',
                fontWeight: FontWeight.w500),
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
                        fontSize: isMobileView(context)
                            ? 12
                            : screenwidth(context) * 0.01,
                        color: isdark
                            ? ColorConst.textdarkw
                            : ColorConst.textliteb,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
}
