import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String id = 'splash_id';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    initTimer();
  }

  initTimer() {
    Timer(const Duration(seconds: 2), () {
      callSignInPage();
    });
  }

  callSignInPage() {
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(252, 175, 69, 1),
              Color.fromRGBO(245, 96, 64, 1),
            ],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Instagram",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontFamily: "Billabong",
                  ),
                ),
              ),
            ),
            Text(
              "All rights reserved",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
