import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/book_title_list.dart';
import '../../../domain/quesiton_data_list.dart';

class ReviewModel extends ChangeNotifier {
  List<List<QuestionDataList>>? questionDataListAll;
  final pastPaperTitleList = past_paper_title_list;

  void fetchQuestionDataList() async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;

    //初期化
    List<List<Map<String, dynamic>>> listAll = [];
    for (var i = 0; i < pastPaperTitleList.length; i++) {
      List<Map<String, dynamic>>? listTemp = await db.query('QuestionData',
          where: 'pastTitle=?', whereArgs: [pastPaperTitleList[i].tag]);
      listAll[i] = listTemp;
      int j = 0;
      listTemp.forEach((map) {
        final int questionId = map[j]['questionId'];
        final int answeredTimes = map[j]['answeredTimes'];
        final int correctTimes = map[j]['correctTimes'];
        final int wrongTimes = map[j]['wrongTimes'];
        final int continuousCorrectTimes = map[j]['continuousCorrectTimes'];
        final int latestCorrect = map[j]['latestCorrect'];
        this.questionDataListAll![i][j] = QuestionDataList(
          questionId,
          answeredTimes,
          correctTimes,
          wrongTimes,
          continuousCorrectTimes,
          latestCorrect,
        );
        j++;
      });
    }
    notifyListeners();
  }
}
