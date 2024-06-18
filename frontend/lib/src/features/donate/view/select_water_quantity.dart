import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectWaterQuantityScreen extends StatefulWidget {
  const SelectWaterQuantityScreen({super.key});

  @override
  State<SelectWaterQuantityScreen> createState() =>
      _SelectWaterQuantityScreenState();
}

class _SelectWaterQuantityScreenState extends State<SelectWaterQuantityScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220.h,
          width: 430.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  buildQuantityButton(),
                  buildQuantityButton(),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildQuantityButton(),
                  SizedBox(
                    height: 100.h,
                    width: 200.w,
                    child: TextFormField(
                      style: TextStyle(),
                      decoration: InputDecoration(hintText: "Custom"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  MaterialButton buildQuantityButton() {
    return MaterialButton(
      onPressed: () {},
      height: 100.h,
      minWidth: 200.w,
      color: Colors.grey,
      hoverColor: Colors.transparent,
      child: Center(
        child: Text("1000L"),
      ),
    );
  }
}
