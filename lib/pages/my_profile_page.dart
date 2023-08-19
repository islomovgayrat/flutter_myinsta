import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_myinsta/models/member_model.dart';
import 'package:flutter_myinsta/services/auth_service.dart';
import 'package:flutter_myinsta/services/db_service.dart';
import 'package:flutter_myinsta/services/file_service.dart';

import '../models/post_model.dart';
import '../services/utils.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int axisCount = 2;

  var isLoading = false;
  File? image;
  List<Post> items = [];
  final ImagePicker picker = ImagePicker();

  String fullName = '', email = '', imgUrl = '';
  int countPosts = 0, countFollowers = 0, countFollowing = 0;

  imgFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      image = File(pickedFile!.path);
    });
    apiChangePhoto();
  }

  imgFromGallery2() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      image = File(pickedFile!.path);
    });
    apiChangePhoto();
  }

  void apiChangePhoto() {
    if (image == null) return;
    setState(() {
      isLoading = true;
    });
    FileService.uploadUserImage(image!).then((downloadUrl) => {
          apiUpdateUser(downloadUrl),
        });
  }

  apiUpdateUser(String downloadUrl) async {
    Member member = await DBService.loadMember();
    member.imgUrl = downloadUrl;
    await DBService.updateMember(member);
    apiLoadMember();
  }

  apiLoadMember() {
    setState(() {
      isLoading = true;
    });
    DBService.loadMember().then((value) => {
          showMemberInfo(value),
        });
  }

  void showMemberInfo(Member member) {
    setState(() {
      isLoading = false;
      fullName = member.fullName;
      email = member.email;
      imgUrl = member.imgUrl;
      countFollowing = member.followingCount;
      countFollowers = member.followerCount;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apiLoadMember();
    apiLoadPosts();
  }

  apiLoadPosts() {
    DBService.loadPost().then((value) => {
          resLoadPost(value),
        });
  }

  resLoadPost(List<Post> posts) {
    setState(() {
      items = posts;
      countPosts = posts.length;
    });
  }

  dialogRemovePost(Post post) async {
    var result = await Utils.dialogCommon(
        context, 'Insta Clone', 'Do you want to delete this post?', false);
    if (result) {
      setState(() {
        isLoading = true;
      });
      DBService.removePost(post).then((value) => {
            apiLoadPosts(),
          });
    }
  }

  dialogLogOut() async {
    var result = await Utils.dialogCommon(
        context, 'Insta Clone', 'Do you want to Log Out?', false);
    if (result) {
      setState(() {
        isLoading = true;
      });
      AuthService.signOutUser(context);
    }
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
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "Billabong",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              dialogLogOut();
            },
            icon: const Icon(Icons.exit_to_app),
            color: const Color.fromRGBO(245, 96, 64, 1),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //my photo
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: imgFromGallery,
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.photo,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                        SizedBox(width: 25),
                                        Text(
                                          'Pick Photo',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: imgFromGallery2,
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.photo_camera,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                        SizedBox(width: 25),
                                        Text(
                                          'Take Photo',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                            width: 1.5,
                            color: const Color.fromRGBO(245, 96, 64, 1),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: imgUrl == null || imgUrl.isEmpty
                              ? Image.asset(
                                  'assets/images/img.png',
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                )
                              : Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                      width: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                //my information
                Text(
                  fullName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),

                //my counts
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 50,
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                countPosts.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                "POSTS",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                countFollowers.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                "FOLLOWERS",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                countFollowing.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                "FOLLOWING",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //list or grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            axisCount = 1;
                          });
                        },
                        icon: const Icon(Icons.list_alt)),
                    const SizedBox(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            axisCount = 2;
                          });
                        },
                        icon: const Icon(Icons.grid_view)),
                    const SizedBox(),
                  ],
                ),

                //my posts
                Expanded(
                  child: GridView.builder(
                    itemBuilder: (ctx, index) {
                      return itemOfPost(items[index]);
                    },
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisCount,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return GestureDetector(
      onLongPress: () {
        dialogRemovePost(post);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: post.imgPost,
                width: double.infinity,
                placeholder: (ctx, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (ctx, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              post.caption,
              style: TextStyle(color: Colors.black87.withOpacity(0.7)),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
