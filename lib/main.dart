import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/home_page.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';
import 'package:flutter_myinsta/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
