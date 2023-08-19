import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_myinsta/models/post_model.dart';
import 'package:flutter_myinsta/services/db_service.dart';
import 'package:flutter_myinsta/services/file_service.dart';

class MyUploadPage extends StatefulWidget {
  final PageController pageController;

  const MyUploadPage({super.key, required this.pageController});

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  bool isLoading = false;
  TextEditingController captionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? image;

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

  uploadPost() {
    String caption = captionController.text.toString().trim();
    if (image == null || caption.isEmpty) return;
    apiPostImage();
  }

  void apiPostImage() {
    setState(() {
      isLoading = true;
    });
    FileService.uploadPostImage(image!).then((downloadUrl) => {
          resPostImage(downloadUrl),
        });
  }

  resPostImage(String downloadUrl) {
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl);
    apiStorePost(post);
  }

  apiStorePost(Post post) async {
    //Post to posts
    Post posted = await DBService.storePost(post);
    //Post to feeds
    DBService.storeFeed(post).then((value) => {
          moveToFeed(),
        });
  }

  moveToFeed() {
    setState(() {
      isLoading = false;
    });
    captionController.text = '';
    image = null;
    widget.pageController!.animateToPage(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Upload",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              uploadPost();
            },
            icon: const Icon(Icons.drive_folder_upload),
            color: const Color.fromRGBO(245, 96, 64, 1),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Container(
                            height: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
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
                                ),
                                //SizedBox(height: 10),
                                Expanded(
                                  child: GestureDetector(
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
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.4),
                      child: image == null
                          ? const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                            )
                          : Stack(
                              children: [
                                Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.highlight_remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),

                  //caption
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextField(
                      controller: captionController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Caption',
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
}
