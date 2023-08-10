import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/bottom_sheet.dart';

class MyUploadPage extends StatefulWidget {
  const MyUploadPage({super.key});
  static const String id = 'upload_id';

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  var isLoading = false;
  final ImagePicker picker = ImagePicker();
  File? image;

  TextEditingController captionController = TextEditingController();

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  //image
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

                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextField(
                      controller: captionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Caption",
                        hintStyle:
                            TextStyle(fontSize: 17, color: Colors.black38),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getAppBar() => AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Upload',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Billabong",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.drive_folder_upload,
              color: Color.fromRGBO(245, 96, 64, 1),
            ),
          ),
        ],
      );
}

class BottomSheetExample extends StatelessWidget {
  //const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Take Photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Take Photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}