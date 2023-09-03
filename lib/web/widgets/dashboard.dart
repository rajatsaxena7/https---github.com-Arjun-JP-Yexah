import 'dart:convert';
import 'dart:html' as webFile;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yexah/web/widgets/customer_intraction.dart';
import 'package:yexah/web/widgets/text.dart';

import '../const/color.dart';
import '../const/const.dart';
import '../screen/home_page.dart';
import 'deals_at_yexah_banner.dart';

import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  final BuildContext ctx;
  const DashBoard({super.key, required this.ctx});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

String selectedValue = 'Deal 1';
List<String> dropdownItems = ['Deal 1', 'Deal 2', 'Deal 3'];
String selectedProviderValue = 'Provider 1';
List<String> providerdropdownItems = ['Provider 1', 'Provider 2', 'Provider 3'];

class _DashBoardState extends State<DashBoard> {
  double total = 0;
  int Totaluser = 0;

  @override
  void initState() {
    dashbordcalculation();
    super.initState();
  }

  Future<void> dashbordcalculation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('UserID');
    isadmin = prefs.getInt('Admin')!;
    print("UserID $user_id");
    print("isadmin $isadmin");
    if (isadmin == 0) {
      try {
        var response = await http.get(
          Uri.parse(
              "https://deals.yexah.com:3000/get_providerplanref/$user_id"),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        var res = jsonDecode(response.body);

        setState(() async {
          double basePrice = double.parse(res["providerData"]["markupMoney"]);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setDouble('Baseprice', basePrice);
          total = prefs.getDouble('Baseprice')!;
          Totaluser = 1;
        });
      } catch (er) {
        throw Exception('Error provider data $er');
      }
    } else {
      try {
        total = 0;
        var response = await http.get(
          Uri.parse("https://deals.yexah.com:3000/getproviderrefs"),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        var res = jsonDecode(response.body);
        Totaluser = res.length;
        // print(Totaluser.toString());
        for (var item in res) {
          if (item.containsKey('basePrice') && item['markupMoney'] != null) {
            total += item['basePrice'];
          }
        }
        print("total= $total");
        setState(() async {
          // final SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setInt('Totaluser', Totaluser);
          // await prefs.setDouble('Baseprice', total);
          // total = prefs.getDouble('Baseprice') ?? 0;
          // Totaluser = prefs.getInt('Totaluser') ?? 0;
        });
      } catch (er) {
        throw Exception('Error provider data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width < 600;
    }

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
          padding: EdgeInsets.only(
              left: screenwidth(context) * .015,
              right: screenwidth(context) * .015,
              top: screenwidth(context) * .018),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DealsAtYexahBanner(isdarkk: isdark, ctx: context),
                SizedBox(
                  height: screenheight(context) * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: isMobileView(context)
                          ? screenwidth(context) * 0.25
                          : screenwidth(context) * 0.115,
                      height: screenheight(context) * .075,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: isdark
                            ? ColorConst.scaffoldDarklite
                            : ColorConst.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          dropdownColor: isdark
                              ? ColorConst.scaffoldDarklite
                              : ColorConst.white,
                          value: selectedValue,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          isExpanded: true,
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
                    ),
                    SizedBox(width: screenwidth(context) * .03),
                    isadmin == 1
                        ? Container(
                            width: isMobileView(context)
                                ? screenwidth(context) * 0.35
                                : screenwidth(context) * 0.115,
                            height: screenheight(context) * .075,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: isdark
                                  ? ColorConst.scaffoldDarklite
                                  : ColorConst.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                dropdownColor: isdark
                                    ? ColorConst.scaffoldDarklite
                                    : ColorConst.white,
                                value: selectedProviderValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProviderValue = newValue!;
                                  });
                                },
                                isExpanded: true,
                                underline: const SizedBox(),
                                items: providerdropdownItems.map((value) {
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
                          )
                        : const SizedBox(),
                  ],
                ),
                SizedBox(height: screenheight(context) * 0.02),
                isMobileView(context)
                    ? Column(
                        children: [
                          SizedBox(
                            // width: screenwidth(context) * .25,
                            // height: screenheight(context) * .3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenwidth(context) * .01,
                                  right: screenwidth(context) * .03,
                                  top: screenwidth(context) * .01),
                              child: _listContainer(
                                context: context,
                                boxIcon: _listItem[0]['boxIcon'],
                                productTitle: isadmin == 1
                                    ? "Active Providers"
                                    : _listItem[0]['producTitle'],
                                value: Totaluser.toString(),
                                percentage: _listItem[0]['percentage'],
                                color: 0 == 3
                                    ? [
                                        Color(int.parse(
                                                '0xff${_listItem[0]['boxColor'][0]}'))
                                            .withOpacity(0.75),
                                        Color(int.parse(
                                                '0xff${_listItem[0]['boxColor'][1]}'))
                                            .withOpacity(0.75)
                                      ]
                                    : [
                                        Color(int.parse(
                                            '0xff${_listItem[0]['boxColor'][0]}')),
                                        Color(int.parse(
                                            '0xff${_listItem[0]['boxColor'][1]}'))
                                      ],
                                id: _listItem[0]['id'],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("INR $total");
                              print(Totaluser.toString());
                            },
                            child: SizedBox(
                              // width: screenwidth(context) * .25,
                              // height: screenheight(context) * .3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * .03,
                                    right: screenwidth(context) * .01,
                                    top: screenwidth(context) * .01),
                                child: _listContainer(
                                  context: context,
                                  boxIcon: _listItem[1]['boxIcon'],
                                  productTitle: _listItem[1]['producTitle'],
                                  value: "INR $total",
                                  percentage: _listItem[1]['percentage'],
                                  color: 0 == 3
                                      ? [
                                          Color(int.parse(
                                                  '0xff${_listItem[1]['boxColor'][0]}'))
                                              .withOpacity(0.75),
                                          Color(int.parse(
                                                  '0xff${_listItem[1]['boxColor'][1]}'))
                                              .withOpacity(0.75)
                                        ]
                                      : [
                                          Color(int.parse(
                                              '0xff${_listItem[1]['boxColor'][0]}')),
                                          Color(int.parse(
                                              '0xff${_listItem[1]['boxColor'][1]}'))
                                        ],
                                  id: _listItem[0]['id'],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: screenwidth(context) * .25,
                            height: screenheight(context) * .3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenwidth(context) * .01,
                                  right: screenwidth(context) * .03,
                                  top: screenwidth(context) * .01),
                              child: _listContainer(
                                context: context,
                                boxIcon: _listItem[0]['boxIcon'],
                                productTitle: isadmin == 1
                                    ? "Active Providers"
                                    : _listItem[0]['producTitle'],
                                value: Totaluser.toString(),
                                percentage: _listItem[0]['percentage'],
                                color: 0 == 3
                                    ? [
                                        Color(int.parse(
                                                '0xff${_listItem[0]['boxColor'][0]}'))
                                            .withOpacity(0.75),
                                        Color(int.parse(
                                                '0xff${_listItem[0]['boxColor'][1]}'))
                                            .withOpacity(0.75)
                                      ]
                                    : [
                                        Color(int.parse(
                                            '0xff${_listItem[0]['boxColor'][0]}')),
                                        Color(int.parse(
                                            '0xff${_listItem[0]['boxColor'][1]}'))
                                      ],
                                id: _listItem[0]['id'],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("INR $total");
                              print(Totaluser.toString());
                            },
                            child: SizedBox(
                              width: screenwidth(context) * .25,
                              height: screenheight(context) * .3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * .03,
                                    right: screenwidth(context) * .01,
                                    top: screenwidth(context) * .01),
                                child: _listContainer(
                                  context: context,
                                  boxIcon: _listItem[1]['boxIcon'],
                                  productTitle: _listItem[1]['producTitle'],
                                  value: "INR $total",
                                  percentage: _listItem[1]['percentage'],
                                  color: 0 == 3
                                      ? [
                                          Color(int.parse(
                                                  '0xff${_listItem[1]['boxColor'][0]}'))
                                              .withOpacity(0.75),
                                          Color(int.parse(
                                                  '0xff${_listItem[1]['boxColor'][1]}'))
                                              .withOpacity(0.75)
                                        ]
                                      : [
                                          Color(int.parse(
                                              '0xff${_listItem[1]['boxColor'][0]}')),
                                          Color(int.parse(
                                              '0xff${_listItem[1]['boxColor'][1]}'))
                                        ],
                                  id: _listItem[0]['id'],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: screenheight(context) * 0.06),
                ChartDemo(isdarkk: isdark),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const FooterCon()
      ],
    );
  }

  final List<Map<String, dynamic>> _listItem = [
    {
      'id': 0,
      'producTitle': 'Active Products',
      'value': '12',
      'boxIcon': Icons.shield,
      'boxColor': ['FEBE99', 'F66F94'],
      'percentage': 60,
    },
    {
      'id': 1,
      'producTitle': 'Till date revenue from all plans',
      'value': 'INR 18,26,800',
      'boxIcon': Icons.currency_rupee,
      'boxColor': ['43D5E7', '7DB1F0'],
      'percentage': 10,
    },
  ];

  Widget _listContainer(
      {required IconData boxIcon,
      required String productTitle,
      required String value,
      required List<Color> color,
      required int percentage,
      required int id,
      required BuildContext context}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Stack(
        children: [
          Container(
            width: isMobileView(context)
                ? screenwidth(context) * 0.85
                : screenwidth(context) * 0.22,
            height: screenheight(context) * 0.27,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              gradient: LinearGradient(colors: color),
            ),
            padding: EdgeInsets.all(
              screenwidth(context) * .028,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productTitle,
                      style: const TextStyle(
                        color: ColorConst.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(boxIcon, color: ColorConst.white),
                    const SizedBox(width: 10),
                    Text(
                      value,
                      style: const TextStyle(
                        color: ColorConst.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: -30.5,
            right: -80.5,
            child: Container(
              height: screenheight(context) * 0.18,
              width: screenwidth(context) * 0.18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConst.white.withOpacity(0.15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}

class ChartDemo extends StatefulWidget {
  final bool isdarkk;
  const ChartDemo({super.key, required this.isdarkk});

  @override
  State<ChartDemo> createState() => _ChartDemoState();
}

class _ChartDemoState extends State<ChartDemo> {
  late List<DataClass> _chartData;
  late List<ChannelDataClass> _channelData;
  @override
  void initState() {
    _chartData = getChartData();
    _channelData = getChannelChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isdark ? ColorConst.scaffoldDarklite : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Texttxt(
                  color: isdark ? ColorConst.white : ColorConst.black,
                  fontsize:
                      isMobileView(context) ? 11 : screenwidth(context) * 0.01,
                  text: 'Last 30 days, Number of Transactions',
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(
                  height: 10,
                ),
                PointLineChart(isdark: widget.isdarkk),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isMobileView(context)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: screenheight(context) * 0.42,
                      width: isMobileView(context)
                          ? screenwidth(context) * .85
                          : screenwidth(context) * .34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.isdarkk
                              ? ColorConst.scaffoldDark
                              : Colors.white),
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: 'Traffic channel by type',
                            textStyle: TextStyle(
                                color: widget.isdarkk
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context) ? 11 : 20,
                                fontFamily: 'Nunito'),
                            alignment: ChartAlignment.near),
                        series: <CircularSeries>[
                          DoughnutSeries<ChannelDataClass, String>(
                            dataSource: _channelData,
                            xValueMapper: (ChannelDataClass data, _) =>
                                data.channeName,
                            yValueMapper: (ChannelDataClass data, _) =>
                                data.persent,
                            pointColorMapper: (ChannelDataClass data, _) =>
                                data.color,
                            dataLabelMapper: (ChannelDataClass data, _) =>
                                data.channeName,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: isMobileView(context) ? 11 : 20,
                                    fontFamily: 'Nunito')),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isMobileView(context) ? 10 : 20,
                      height: isMobileView(context) ? 10 : 0,
                    ),
                    Container(
                      padding: isMobileView(context)
                          ? const EdgeInsets.only(left: 0)
                          : const EdgeInsets.only(left: 10),
                      height: screenheight(context) * 0.42,
                      width: isMobileView(context)
                          ? screenwidth(context) * .85
                          : screenwidth(context) * .34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.isdarkk
                            ? ColorConst.scaffoldDark
                            : Colors.white,
                      ),
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: 'Revenue Split by active Products',
                            textStyle: TextStyle(
                                color: widget.isdarkk
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context) ? 11 : 20,
                                fontFamily: 'Nunito'),
                            alignment: ChartAlignment.near),
                        series: <CircularSeries>[
                          PieSeries<DataClass, String>(
                              dataSource: _chartData,
                              xValueMapper: (DataClass data, _) => data.tag,
                              yValueMapper: (DataClass data, _) => data.persent,
                              pointColorMapper: (DataClass data, _) =>
                                  data.color,
                              dataLabelMapper: (DataClass data, _) =>
                                  data.name + ' ${data.persent}%',
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: isMobileView(context)
                          ? screenwidth(context) * .40
                          : screenwidth(context) * .34,
                      width: isMobileView(context)
                          ? screenwidth(context) * .40
                          : screenwidth(context) * .34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.isdarkk
                              ? ColorConst.scaffoldDarklite
                              : Colors.white),
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: 'Traffic channel by type',
                            textStyle: TextStyle(
                                color: widget.isdarkk
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context) ? 11 : 20,
                                fontFamily: 'Nunito'),
                            alignment: ChartAlignment.near),
                        series: <CircularSeries>[
                          DoughnutSeries<ChannelDataClass, String>(
                            dataSource: _channelData,
                            xValueMapper: (ChannelDataClass data, _) =>
                                data.channeName,
                            yValueMapper: (ChannelDataClass data, _) =>
                                data.persent,
                            pointColorMapper: (ChannelDataClass data, _) =>
                                data.color,
                            dataLabelMapper: (ChannelDataClass data, _) =>
                                data.channeName,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: isMobileView(context) ? 11 : 20,
                                    fontFamily: 'Nunito')),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isMobileView(context) ? 4 : 20,
                    ),
                    Container(
                      padding: isMobileView(context)
                          ? const EdgeInsets.only(left: 0)
                          : const EdgeInsets.only(left: 10),
                      height: isMobileView(context)
                          ? screenwidth(context) * .40
                          : screenwidth(context) * .34,
                      width: isMobileView(context)
                          ? screenwidth(context) * .40
                          : screenwidth(context) * .34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.isdarkk
                            ? ColorConst.scaffoldDarklite
                            : Colors.white,
                      ),
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: 'Revenue Split by active Products',
                            textStyle: TextStyle(
                                color: widget.isdarkk
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context) ? 11 : 20,
                                fontFamily: 'Nunito'),
                            alignment: ChartAlignment.near),
                        series: <CircularSeries>[
                          PieSeries<DataClass, String>(
                              dataSource: _chartData,
                              xValueMapper: (DataClass data, _) => data.tag,
                              yValueMapper: (DataClass data, _) => data.persent,
                              pointColorMapper: (DataClass data, _) =>
                                  data.color,
                              dataLabelMapper: (DataClass data, _) =>
                                  data.name + ' ${data.persent}%',
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  final List<SalesData> data = [
    SalesData('1', 650),
    SalesData('2', 75),
    SalesData('3', 150),
    SalesData('4', 250),
    SalesData('5', 300),
    SalesData('5', 700),
  ];
  List<DataClass> getChartData() {
    final List<DataClass> chartData = [
      DataClass('a', 45, Colors.orange, 'All Risk with\n ALD - Goddigit'),
      DataClass('a', 55, const Color.fromARGB(255, 139, 196, 243),
          'Extended warranty\nICIC'),
    ];
    return chartData;
  }

  List<ChannelDataClass> getChannelChartData() {
    final List<ChannelDataClass> channelChartData = [
      ChannelDataClass('Mobile', 20, Colors.green),
      ChannelDataClass('webside', 15, Colors.orange),
      ChannelDataClass(
          'store\nPos', 60, const Color.fromARGB(255, 139, 196, 243)),
    ];

    return channelChartData;
  }
}

class DataClass {
  final String tag;
  final String name;
  final int persent;
  final Color color;

  DataClass(this.tag, this.persent, this.color, this.name);
}

class ChannelDataClass {
  final String channeName;
  final int persent;
  final Color color;

  ChannelDataClass(this.channeName, this.persent, this.color);
}

class FooterCon extends StatelessWidget {
  const FooterCon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenheight(context) * 0.06,
      color: ColorConst.transparent,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextBtn(
              onpressed: () async {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const PdfViewerWeb(
                //           filePath:
                //               'assets/pdf/(July 21 2023) Yexah - Website Terms  Conditions - Vertices Draft_003 (Clean).pdf',
                //         )));

                ByteData bytess = await rootBundle.load(
                    'assets/pdf/(July 21 2023) Yexah - Website Terms  Conditions - Vertices Draft_003 (Clean).pdf');
                final buffer = bytess.buffer;
                final String filename =
                    ' Website Terms  Conditions - Vertices Draft_003 (Clean).pdf';
                var blob = webFile.Blob([bytess], 'text/plain', 'native');

                var anchorElement = webFile.AnchorElement(
                  href: webFile.Url.createObjectUrlFromBlob(blob).toString(),
                )
                  ..setAttribute("download", filename)
                  ..click();
              },
              text: 'Terms of use',
            ),
            const SizedBox(
              width: 35,
            ),
            TextBtn(
                onpressed: () async {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const PdfViewerWeb(
                  //           filePath:
                  //               'assets/pdf/(July 19 2023) - Yexah - Privacy Policy - Vertices Drafts 003 (Clean).pdf',
                  //         )));
                  ByteData bytess = await rootBundle.load(
                      'assets/pdf/(July 19 2023) - Yexah - Privacy Policy - Vertices Drafts 003 (Clean).pdf');
                  final buffer = bytess.buffer;
                  final String filename =
                      ' Yexah - Privacy Policy - Vertices Drafts 003 (Clean).pdf';
                  var blob = webFile.Blob([bytess], 'text/plain', 'native');

                  var anchorElement = webFile.AnchorElement(
                    href: webFile.Url.createObjectUrlFromBlob(blob).toString(),
                  )
                    ..setAttribute("download", filename)
                    ..click();
                },
                text: 'Privacy policy')
          ]),
    );
  }
}

class TextBtn extends StatelessWidget {
  final Function()? onpressed;
  final String text;
  const TextBtn({super.key, required this.onpressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onpressed,
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all<Color>(ColorConst.primary),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: ColorConst.primary, fontSize: 14, fontFamily: 'Nunito'),
        ));
  }
}

class PointLineChart extends StatelessWidget {
  final bool isdark;

  const PointLineChart({super.key, required this.isdark});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
            left: screenwidth(context) * 0.1,
            bottom: screenwidth(context) * 0.05),
        decoration: BoxDecoration(
            color: isdark ? Colors.transparent : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: SfCartesianChart(
          // title: ChartTitle(text: 'Point Line Chart'),
          primaryXAxis: NumericAxis(
            interval: 1,
            majorGridLines: const MajorGridLines(
              width: 1,
              dashArray: [10, 5],
            ),
            minorGridLines: const MinorGridLines(
              width: 1,
              dashArray: [10, 5],
            ),
            minorTickLines: const MinorTickLines(size: 0),
            axisLine: const AxisLine(width: 0),
          ),
          primaryYAxis: NumericAxis(
              minorTickLines: const MinorTickLines(size: 0),
              interval: 20,
              majorGridLines: const MajorGridLines(
                width: 1,
                dashArray: [10, 5],
              ),
              axisLine: const AxisLine(width: 0),
              minorGridLines: const MinorGridLines(
                width: 1,
                dashArray: [10, 5],
              )),
          series: <ChartSeries>[
            // Point series
            LineSeries<Point, double>(
              dataSource: <Point>[
                Point(0, 5),
                Point(1, 12),
                Point(2, 140),
                Point(8, 15),
                Point(15, 180),
                Point(30, 110),
              ],
              xValueMapper: (Point point, _) => point.x,
              yValueMapper: (Point point, _) => point.y,
              name: 'Point Line',
              markerSettings: const MarkerSettings(
                  isVisible: true,
                  color: Colors.blue,
                  borderColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}
