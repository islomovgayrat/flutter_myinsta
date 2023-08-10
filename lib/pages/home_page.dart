import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/my_feed_page.dart';
import 'package:flutter_myinsta/pages/my_like_page.dart';
import 'package:flutter_myinsta/pages/my_profile_page.dart';
import 'package:flutter_myinsta/pages/my_search_page.dart';
import 'package:flutter_myinsta/pages/my_upload_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'home_id';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageController = PageController();
  int currentTap = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          MyFeedPage(),
          MySearchPage(),
          MyUploadPage(),
          MyLikePage(),
          MyProfilePage(),
        ],
        onPageChanged: (int index) {
          setState(() {
            currentTap = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (int index) {
          setState(() {
            currentTap = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          });
        },
        currentIndex: currentTap,
        activeColor: const Color.fromRGBO(245, 96, 64, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Like'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
