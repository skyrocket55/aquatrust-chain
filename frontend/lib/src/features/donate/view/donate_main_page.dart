import 'package:bwt_frontend/src/features/donate/donate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonateMainPage extends StatefulWidget {
  const DonateMainPage({super.key});

  @override
  State<DonateMainPage> createState() => _DonateMainPageState();
}

class _DonateMainPageState extends State<DonateMainPage> {
  int currentIndex = 0;
  int count = 3;
  List<String> pageTitle = ["Select NGO", "Select Water Quantity", "Confirm"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 500.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: pageTitle.map((e) {
                  return Text(
                    e,
                    style: TextStyle(
                      fontWeight: pageTitle[currentIndex] == e
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SelectNgoScreen(),
          TextButton(
            onPressed: () {
              setState(() {
                if (currentIndex < count-1) currentIndex++;
              });
            },
            child: Text("Next"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (currentIndex >0 ) currentIndex--;
              });
            },
            child: Text("Back"),
          ),
        ],
      ),
    );
  }
}
