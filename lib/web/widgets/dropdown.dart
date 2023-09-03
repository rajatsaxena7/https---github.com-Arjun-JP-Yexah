import 'package:flutter/material.dart';

class DropDown1 extends StatelessWidget {
  final double width;

  final String tittle;
  final String value1;
  final String value2;
  final String value3;
  const DropDown1(
      {super.key,
      required this.width,
      required this.tittle,
      required this.value1,
      required this.value2,
      required this.value3});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: width,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          title: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                tittle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: [
            ListTile(
              title: Text(value1),
            ),
            ListTile(
              title: Text(value2),
            ),
            ListTile(
              title: Text(value3),
            ),
          ],
        ),
      ),
    );
  }
}
