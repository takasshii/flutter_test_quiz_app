import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/learning_data_get.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContinuousDaysUpdate extends ChangeNotifier {
  LearningDataGet? learningDateList;

  //取得したデータの格納用
  UserGet? userDetailList;

  Future<void> fetchLearningDataList() async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    const String insertSql = 'SELECT * FROM LearningData';
    final List<Map<String, dynamic>> map = await db.rawQuery(insertSql);

    final int currentContinuousRecord = map[0]['currentContinuousRecord'];
    final int continuousRecord = map[0]['continuousRecord'];
    final int totalDay = map[0]['totalDay'];
    final int todayTime = map[0]['todayTime'];
    final int totalQuestion = map[0]['totalQuestion'];
    final int learnedQuestion = map[0]['learnedQuestion'];
    final int totalLearningTime = map[0]['totalLearningTime'];
    final DateTime loginAt = DateTime.parse(map[0]['loginAt']).toLocal();
    final DateTime createdAt = DateTime.parse(map[0]['createdAt']).toLocal();
    final DateTime updatedAt = DateTime.parse(map[0]['updatedAt']).toLocal();
    this.learningDateList = LearningDataGet(
        currentContinuousRecord,
        continuousRecord,
        totalDay,
        todayTime,
        totalQuestion,
        learnedQuestion,
        totalLearningTime,
        loginAt,
        createdAt,
        updatedAt);
  }

  void UpdateContinuousDaysUpdate(LearningDataGet? learningDateList) async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    WidgetsFlutterBinding.ensureInitialized();

    const String tableName = 'LearningData';
    //学習した日数の更新
    int totalDay = learningDateList!.totalDay++;
    int currentContinuousRecord = learningDateList.currentContinuousRecord;
    int continuousRecord = learningDateList.continuousRecord;

    //現在の連続日数の更新
    if (DateTime.now().day - learningDateList.loginAt.day == 1) {
      currentContinuousRecord++;
      //最長連続日数の更新
      if (currentContinuousRecord > continuousRecord) {
        continuousRecord = currentContinuousRecord;
      }
    }
    Map<String, dynamic> record = {
      'totalDay': totalDay,
      'currentContinuousRecord': currentContinuousRecord,
      'continuousRecord': continuousRecord,
      'loginAt': DateTime.now().toUtc().toIso8601String(),
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };

    await db.update(
      tableName,
      record,
    );
    notifyListeners();
  }

  void LoginCheck() async {
    await fetchLearningDataList();
    //ログインの日程が異なる場合のみトリガーが発動
    final bool isSameDay =
        (DateTime.now().day - learningDateList!.loginAt.day).abs() == 0;

    if (isSameDay == false) {
      UpdateContinuousDaysUpdate(learningDateList);
    }
  }
}
