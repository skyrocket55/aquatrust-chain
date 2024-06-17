import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NgoRegistrationScreen extends StatefulWidget {
  const NgoRegistrationScreen({super.key});

  @override
  State<NgoRegistrationScreen> createState() => _NgoRegistrationScreenState();
}

class _NgoRegistrationScreenState extends State<NgoRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "NGO Registration",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("NGO Name"),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Country Name"),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Region you serve"),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Water Demand/Month"),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Water served till now"),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Email"),
              ),
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                label: Text("Create Password"),
              ),
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                label: Text("Confirm Password"),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
