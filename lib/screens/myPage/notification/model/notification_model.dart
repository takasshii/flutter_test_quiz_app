import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/domain/notification_long.dart';

class NotificationModel extends ChangeNotifier {
  List<NotificationLong>? notifications;
  //初期化
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //userのuidを取得
  final user_uid = FirebaseAuth.instance.currentUser!.uid;

  //取得したデータの格納用

  void fetchNotificationList() async {
    final firstPage = await firestore
        .collection('notification')
        .orderBy('updatedAt', descending: true)
        .limit(10)
        .get();

    final List<NotificationLong> lists =
        firstPage.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data['title'];
      final String content = data['content'];
      final String tag = data['tag'];
      Color color = kPrimaryColor;
      if (tag == "インフォメーション") {
        color = Colors.pinkAccent;
      } else if (tag == "イベント") {
        color = Colors.redAccent;
      } else if (tag == "不具合") {
        color = Colors.blueAccent;
      }
      final Timestamp createdAt = data["createdAt"];
      final Timestamp updatedAt = data["updatedAt"];
      return NotificationLong(title, content, tag, color, createdAt, updatedAt);
    }).toList();
    this.notifications = lists;
    notifyListeners();
  }

  /*
  更新用 ページネーション
  void fetchAddNotificationList() async {
    final nextPage = await firestore.collection('notification')
      ..orderBy('updatedAt', descending: true)
          .startAfter(docs(currentPage.size - 1))
          .limit(10)
          .get();
  }
   */
}
