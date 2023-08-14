import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_model.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});
  static const String id = 'profile_id';

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int axisCount = 1;
  var isOne = false;

  var isLoading = false;
  File? image;
  List<Post> items = [];
  final ImagePicker picker = ImagePicker();

  String fullName = 'Gayrat', email = 'gayrat@gmail.com', imgUrl = '';
  int countPosts = 0, countFollowers = 0, countFollowing = 0;

  String image_1 =
      "https://www.rd.com/wp-content/uploads/2020/05/GettyImages-1153012691.jpg";
  String image_2 =
      "https://imgv3.fotor.com/images/blog-cover-image/8-Tips-on-How-to-Take-Good-Pictures-of-Yourself-2020-Updated.jpg";
  String image_3 =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfVHoY3QYwqjD32uLm_RDOcpOF8UzaWWtnlRdDso9O&s";

  imgFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      image = File(pickedFile!.path);
    });
  }

  imgFromGallery2() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      image = File(pickedFile!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(Post(image_1, 'The best photo I have ever seen'));
    items.add(Post(image_2, 'The best photo I have ever taken'));
    items.add(Post(image_3, 'The best photo I have ever shown'));
    items.add(Post(image_1, 'The best photo I have ever seen'));
    items.add(Post(image_2, 'The best photo I have ever taken'));
    items.add(Post(image_3, 'The best photo I have ever shown'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
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
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
            color: const Color.fromRGBO(193, 53, 132, 1),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
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
                          child: image == null
                              ? Image.asset(
                                  'assets/images/img.png',
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                )
                              : Image.file(
                                  image!,
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
                const SizedBox(height: 5),

                //fullName
                Text(
                  fullName.toString().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                //email
                Text(
                  email.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                //followers posts
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            countPosts.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            "POSTS",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
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
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            "FOLLOWERS",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
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
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            "FOLLOWING",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisCount,
                    ),
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return itemOfPost(items[index]);
                    },
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
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: post.imgPost.toString(),
              placeholder: (ctx, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (ctx, url, error) => const Center(
                child: Icon(Icons.error),
              ),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            post.captionPost.toString(),
            maxLines: 2,
            style: TextStyle(color: Colors.black87.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}
