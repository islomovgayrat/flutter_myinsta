import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_myinsta/services/utils.dart';

import '../models/member_model.dart';
import '../models/post_model.dart';
import 'auth_service.dart';

class DBService {
  static final fireStore = FirebaseFirestore.instance;

  static String folderUsers = 'users';
  static String folderPosts = 'posts';
  static String folderFeeds = 'feeds';
  static String folderFollowing = 'following';
  static String folderFollowers = 'followers';

  //Member related
  static Future storeMember(Member member) async {
    member.uId = AuthService.currentUserId();
    // Map<String, dynamic> params = await Utils.deviceParams();
    // print(params);
    //
    // member.deviceId = params['deviceId'];
    // member.deviceType = params['deviceType'];
    // member.deviceToken = params['deviceToken'];

    return fireStore
        .collection(folderUsers)
        .doc(member.uId)
        .set(member.toJson());
  }

  static Future<Member> loadMember() async {
    String uId = AuthService.currentUserId();
    var value = await fireStore.collection(folderUsers).doc(uId).get();
    Member member = Member.fromJson(value.data()!);
    var querySnapshot1 = await fireStore
        .collection(folderUsers)
        .doc(uId)
        .collection(folderFollowers)
        .get();
    member.followerCount = querySnapshot1.docs.length;

    var querySnapshot2 = await fireStore
        .collection(folderUsers)
        .doc(uId)
        .collection(folderFollowing)
        .get();
    member.followingCount = querySnapshot2.docs.length;
    return member;
  }

  static Future updateMember(Member member) async {
    String uId = AuthService.currentUserId();
    return fireStore.collection(folderUsers).doc(uId).update(member.toJson());
  }

  static Future<List<Member>> searchMember(String keyword) async {
    List<Member> members = [];
    String uId = AuthService.currentUserId();
    var querySnapshot = await fireStore
        .collection(folderUsers)
        .orderBy('email')
        .startAt([keyword]).get();
    print(querySnapshot.docs.length);
    querySnapshot.docs.forEach((result) {
      Member newMember = Member.fromJson(result.data());
      if (newMember.uId != uId) {
        members.add(newMember);
      }
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

    String postId = fireStore
        .collection(folderUsers)
        .doc(me.uId)
        .collection(folderPosts)
        .doc()
        .id;
    post.id = postId;

    await fireStore
        .collection(folderUsers)
        .doc(me.uId)
        .collection(folderPosts)
        .doc(postId)
        .set(post.toJson());
    return post;
  }

  static Future<Post> storeFeed(Post post) async {
    String uid = AuthService.currentUserId();
    await fireStore
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadPost() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await fireStore
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
    var querySnapshot = await fireStore
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .get();

    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });
    return posts;
  }

  static Future likePost(Post post, bool liked) async {
    String uid = AuthService.currentUserId();
    post.liked = liked;
    await fireStore
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .doc(post.id)
        .set(post.toJson());

    if (uid == post.uid) {
      await fireStore
          .collection(folderUsers)
          .doc(uid)
          .collection(folderPosts)
          .doc(post.id)
          .set(post.toJson());
    }
  }

  static Future<List<Post>> loadLikes() async {
    String uid = AuthService.currentUserId();
    List<Post> posts = [];
    var querySnapshot = await fireStore
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .where('liked', isEqualTo: true)
        .get();

    querySnapshot.docs.forEach((result) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) post.mine = true;
      posts.add(post);
    });

    return posts;
  }

  static Future<Member> followMember(Member someone) async {
    Member me = await loadMember();
    //I followed someone
    await fireStore
        .collection(folderUsers)
        .doc(me.uId)
        .collection(folderFollowing)
        .doc(someone.uId)
        .set(someone.toJson());
    //I am in someone's followers
    await fireStore
        .collection(folderUsers)
        .doc(someone.uId)
        .collection(folderFollowers)
        .doc(me.uId)
        .set(me.toJson());
    return someone;
  }

  static Future<Member> unFollowMember(Member someone) async {
    Member me = await loadMember();
    //I unfollowed someone
    await fireStore
        .collection(folderUsers)
        .doc(me.uId)
        .collection(folderFollowing)
        .doc(someone.uId)
        .delete();
    //I am not in someone's followers
    await fireStore
        .collection(folderUsers)
        .doc(someone.uId)
        .collection(folderFollowers)
        .doc(me.uId)
        .delete();
    return someone;
  }

  static Future storePostToMyFeed(Member someone) async {
    List<Post> posts = [];
    var querySnapshot = await fireStore
        .collection(folderUsers)
        .doc(someone.uId)
        .collection(folderPosts)
        .get();
    querySnapshot.docs.forEach((result) {
      var post = Post.fromJson(result.data());
      post.liked = false;
      posts.add(post);
    });

    for (Post post in posts) {
      storeFeed(post);
    }
  }

  // static Future removeFeed(Post post) async {
  //   String uid = AuthService.currentUserId();
  //   return await fireStore
  //       .collection(folderUsers)
  //       .doc(uid)
  //       .collection(folderFeeds)
  //       .doc(post.id)
  //       .set(post.toJson());
  // }

  static Future removePostFromMyFeed(Member someone) async {
    List<Post> posts = [];
    var querySnapshot = await fireStore
        .collection(folderUsers)
        .doc(someone.uId)
        .collection(folderPosts)
        .get();
    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });
    for (Post post in posts) {
      removeFeed(post);
    }
  }

  static Future removeFeed(Post post) async {
    String uid = AuthService.currentUserId();
    var querySnapshot = await fireStore
        .collection(folderUsers)
        .doc(uid)
        .collection(folderFeeds)
        .doc(post.id)
        .delete();
  }
}
