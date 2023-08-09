import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/home_page.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';
import 'package:flutter_myinsta/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MyInsta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        SplashPage.id: (_) => const SplashPage(),
        SignInPage.id: (_) => const SignInPage(),
        SignUpPage.id: (_) => const SignUpPage(),
        HomePage.id: (_) => const HomePage(),
      },
    );
  }
}
