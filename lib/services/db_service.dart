import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_myinsta/models/member_model.dart';
import 'package:flutter_myinsta/services/auth_service.dart';
import 'package:flutter_myinsta/services/utils.dart';

import '../models/post_model.dart';

class DBService {
  static final fireStorage = FirebaseFirestore.instance;
  static String folderUsers = 'users';
  static String folderPosts = 'posts';
  static String folderFeeds = 'feeds';

  // Member related
  static Future storeMember(Member member) async {
    member.uId = AuthService.currentUserId();
    return fireStorage
        .collection(folderUsers)
        .doc(member.uId)
        .set(member.toJson());
  }

  static Future<Member> loadMember() async {
    String uid = AuthService.currentUserId();
    var value = await fireStorage.collection(folderUsers).doc(uid).get();
    Member member = Member.fromJson(value.data()!);
    return member;
  }

  static Future updateMember(Member member) async {
    String uid = AuthService.currentUserId();
    return fireStorage.collection(folderUsers).doc(uid).update(member.toJson());
  }

  static Future<List<Member>> searchMember(String keyword) async {
    List<Member> members = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await fireStorage
        .collection(folderUsers)
        .orderBy("email")
        .startAt([keyword]).get();
    print(querySnapshot.docs.length);
    querySnapshot.docs.forEach((result) {
      Member newMember = Member.fromJson(result.data());
      members.add(newMember);
    });

    return members;
  }

  //Post related
  static Future<Post> storePost(Post post) async {
    Member me = await loadMember();
    post.uid = me.uId!;
    post.fullName = me.fullName;
    post.imgUser = me.imgUrl;
    post.date = Utils.currentDate();

    String postId = fireStorage
        .collection(folderUsers)
        .doc(me.uId)
        .collection(folderPosts)
        .doc()
        .id;
    post.id = postId;
    await fireStorage
        .collection(folderUsers)
        .doc(me.uId)
        .collection(folderPosts)
        .doc(postId)
        .set(post.toJson());
    return post;
  }

  static Future<Post> storeFeed(Post post) async {
    String uid = AuthService.currentUserId();

    await fireStorage
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await fireStorage
        .collection(folderUsers)
        .doc(uid)
        .collection(folderPosts)
        .get();
    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });

    return posts;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await fireStorage
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .get();
    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });

    return posts;
  }
}
