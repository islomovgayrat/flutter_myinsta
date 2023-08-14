import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class MyFeedPage extends StatefulWidget {
  PageController pageController = PageController();
  MyFeedPage({super.key, required this.pageController});
  static const String id = 'feed_id';

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  String image_1 =
      "https://cdn.pixabay.com/photo/2023/05/01/06/55/waterfall-7962263_640.jpg";
  String image_2 =
      "https://cdn.pixabay.com/photo/2015/02/24/15/41/wolf-647528_1280.jpg";
  String image_3 =
      "https://cdn.pixabay.com/photo/2019/08/19/07/45/corgi-4415649_640.jpg";

  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(Post(image_1, 'The best photo from Indonesia'));
    items.add(Post(image_2, 'The Wolf is my favorite animal'));
    items.add(Post(image_3, 'A happy puppy on a train track'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "Billabong",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            icon: const Icon(
              Icons.camera_alt,
              color: Color.fromRGBO(245, 96, 64, 1),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          return itemOfPost(items[index]);
        },
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 1.5),
          //user info
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: AssetImage('assets/images/img.png'),
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "David Johnson",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "July 12, 2023",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //network image
          CachedNetworkImage(
            imageUrl: post.imgPost!,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error),
            ),
          ),
          //like share
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  EvaIcons.heart,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  EvaIcons.share,
                ),
              ),
            ],
          ),
          //caption text
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text.rich(TextSpan(text: post.captionPost!)),
          )
        ],
      ),
    );
  }
}
