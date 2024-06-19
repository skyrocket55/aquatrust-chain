import 'package:bwt_frontend/src/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextField(
              decoration: InputDecoration(label: Text("Username")),
            ),
            const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  label: Text("Password"),
                )),
            SizedBox(
              height: 50.h,
            ),
            TextButton(onPressed: () {
              Navigator.of(context).pushNamed(Routing.ngoRegistrationScreen);
            }, child: Text("Register as NGO")),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(onPressed: () {

              Navigator.of(context).pushNamed(Routing.donateMainPage);
            }, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
