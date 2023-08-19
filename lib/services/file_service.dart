import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_myinsta/services/auth_service.dart';

class FileService {
  static final storage = FirebaseStorage.instance.ref();
  static const folderUser = "user_images";
  static const folderPost = "post_images";

  static Future<String> uploadUserImage(File image) async {
    String uid = AuthService.currentUserId();
    String imageName = uid;
    var firebaseStorageRef = storage.child(folderUser).child(imageName);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  static Future<String> uploadPostImage(File image) async {
    String uid = AuthService.currentUserId();
    String imageName = '${uid}_${DateTime.now()}';
    var firebaseStorageRef = storage.child(folderPost).child(imageName);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}
