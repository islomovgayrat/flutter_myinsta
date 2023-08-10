import 'package:flutter/material.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});
  static const String id = 'search_id';

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Search"),
      ),
    );
  }
}
