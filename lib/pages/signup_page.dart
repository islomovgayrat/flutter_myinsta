import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String id = 'signUp_id';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cPasswordController = TextEditingController();

  doSignUp() {
    String fullName = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cPassword = cPasswordController.text.toString().trim();
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) return;

    if (cPassword != password) return;

    Navigator.pushReplacementNamed(context, HomePage.id);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Instagram",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: "Billabong",
                    ),
                  ),

                  //fullName
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFFAA269),
                    ),
                    child: TextField(
                      controller: fullNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Fullname",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),

                  //email
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFFAA269),
                    ),
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),

                  //password
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFFAA269),
                    ),
                    child: TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),

                  //cPassword
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFFAA269),
                    ),
                    child: TextField(
                      controller: cPasswordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),

                  //signUp - button
                  GestureDetector(
                    onTap: doSignUp,
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        //color: const Color(0xFFFAA269),
                        border: Border.all(
                          color: const Color(0xFFFAA269),
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: callSignInPage,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
