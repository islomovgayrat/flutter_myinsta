import 'package:flutter/material.dart';

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({super.key});
  static const String id = 'feed_id';

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Feed"),
      ),
    );
  }
}
