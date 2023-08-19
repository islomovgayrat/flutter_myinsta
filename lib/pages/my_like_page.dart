import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/services/db_service.dart';

import '../models/post_model.dart';
import '../services/utils.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({super.key});

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  bool isLoading = false;
  List<Post> items = [];

  apiLoadLikes() {
    setState(() {
      isLoading = true;
    });
    DBService.loadLikes().then((value) => {
          resLoadLikes(value),
        });
  }

  resLoadLikes(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  apiPostUnLikes(Post post) {
    setState(() {
      isLoading = true;
      post.liked = false;
    });
    DBService.likePost(post, false).then((value) => {
          apiLoadLikes(),
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiLoadLikes();
  }

  dialogRemovePost(Post post) async {
    var result = await Utils.dialogCommon(
        context, 'Insta Clone', 'Do you want to delete this post?', false);
    if (result) {
      setState(() {
        isLoading = true;
      });
      DBService.removePost(post).then((value) => {
            apiLoadLikes(),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "Billabong",
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(items[index]);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Divider(),
          //user info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: post.imgUser.isEmpty
                          ? const Image(
                              image: AssetImage(
                                'assets/images/img.png',
                              ),
                              width: 40,
                              height: 40,
                            )
                          : Image.network(
                              post.imgUser,
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.fullName.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          post.date,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    dialogRemovePost(post);
                  },
                  icon: post.mine
                      ? const Icon(Icons.more_horiz)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //post image
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            imageUrl: post.imgPost,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          //like share
          Row(
            children: [
              IconButton(
                onPressed: () {
                  apiPostUnLikes(post);
                },
                icon: post.liked
                    ? const Icon(
                        EvaIcons.heart,
                        color: Colors.red,
                      )
                    : const Icon(
                        EvaIcons.heartOutline,
                        color: Colors.black,
                      ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  EvaIcons.shareOutline,
                ),
              ),
            ],
          ),
          //caption
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                text: post.caption,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
