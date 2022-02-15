import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/userGet.dart';

class MyPageModel extends ChangeNotifier {
  //初期化
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //userのuidを取得
  final user_uid = FirebaseAuth.instance.currentUser!.uid;

  //取得したデータの格納用
  UserGet? userDetailList;

  void fetchUserList() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user_uid)
        .get();

    final String name = snapShot.get('name');
    final int? grade = snapShot.get('grade');
    final bool graduation = snapShot.get('graduation');
    final bool open = snapShot.get('graduation');
    this.userDetailList = UserGet(name, grade, graduation, open);
    notifyListeners();
  }
}
