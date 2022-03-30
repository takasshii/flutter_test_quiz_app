import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/ranking_data_get.dart';

class RankingModel extends ChangeNotifier {
  List<RankingDataGet>? rankingTotalAllTop10;
  List<RankingDataGet>? rankingTodayAllTop10;

  //初期化
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //userのuidを取得
  final user_uid = FirebaseAuth.instance.currentUser!.uid;

  //最後に取得された後から1時間後に更新？？

  void fetchRankingList() async {
    final totalTimeAllTop10 = await firestore
        .collection('public-profiles')
        .orderBy('total_time', descending: true)
        .limit(10)
        .get();

    final todayTimeAllTop10 = await firestore
        .collection('public-profiles')
        .orderBy('today_time', descending: true)
        .limit(10)
        .get();

    final List<RankingDataGet> lists1 =
        totalTimeAllTop10.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String name = data['name'];
      final int? grade = data['grade'];
      final String image = data['image'];
      final bool open = data['open'];
      final bool graduation = data['graduation'];
      final int totalTime = data['total_time'];
      final int todayTime = data['today_time'];
      return RankingDataGet(
          name, grade, image, open, graduation, totalTime, todayTime);
    }).toList();
    this.rankingTotalAllTop10 = lists1;

    final List<RankingDataGet> lists3 =
        todayTimeAllTop10.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String name = data['name'];
      final int? grade = data['grade'];
      final String image = data['image'];
      final bool open = data['open'];
      final bool graduation = data['graduation'];
      final int totalTime = data['total_time'];
      final int todayTime = data['today_time'];
      return RankingDataGet(
          name, grade, image, open, graduation, totalTime, todayTime);
    }).toList();
    this.rankingTodayAllTop10 = lists3;

    print('きてるで');
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
