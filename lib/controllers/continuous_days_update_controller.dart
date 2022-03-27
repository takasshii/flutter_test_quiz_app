import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/learning_data_get.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContinuousDaysUpdate extends ChangeNotifier {
  LearningDataGet? learningDateList;
  //取得したデータの格納用
  UserGet? userDetailList;

  void fetchLearningDataList() async {
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
    notifyListeners();
  }

  void fetchUserList() async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    const String insertSql = 'SELECT * FROM User';
    final List<Map<String, dynamic>> map = await db.rawQuery(insertSql);

    final String name = map[0]['name'];
    final int? grade = map[0]['grade'];
    bool graduation = false;
    if (map[0]['graduation'] == 1) {
      graduation = true;
    }
    bool open = true;
    if (map[0]['open'] == 0) {
      open = false;
    }
    String image = "assets/images/エジプト神（イヌ型）.png";
    if (map[0]['image'] != null) {
      image = map[0]['image'];
    }
    this.userDetailList = UserGet(name, grade, graduation, open, image);
    notifyListeners();
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
  }
}
