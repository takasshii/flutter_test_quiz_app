import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyPageModel extends ChangeNotifier {
  //取得したデータの格納用
  UserGet? userDetailList;

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
    this.userDetailList = UserGet(name, grade, graduation, open);
    notifyListeners();
  }
}
