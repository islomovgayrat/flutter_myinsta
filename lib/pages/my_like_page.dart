import 'package:flutter/material.dart';

class MyLikePage extends StatefulWidget {
  const MyLikePage({super.key});
  static const String id = 'like_id';

  @override
  State<MyLikePage> createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Likes"),
      ),
    );
  }
}
