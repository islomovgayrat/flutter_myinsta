import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_myinsta/models/member_model.dart';
import 'package:flutter_myinsta/services/auth_service.dart';

class DBService {
  static final fireStorage = FirebaseFirestore.instance;
  static String folderUsers = 'users';

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
}
