import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/book_title_list.dart';
import '../../../domain/question_data_list.dart';

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
    questionDataListAll = [];
    for (var i = 0; i < pastPaperTitleList.length; i++) {
      List<Map<String, dynamic>>? listTemp = await db.query('QuestionData',
          where: 'pastTitle=?', whereArgs: [pastPaperTitleList[i].tag]);
      List<QuestionDataList> questionDataList = [];
      if (listTemp.length > 0) {
        questionDataList = listTemp.map((data) {
          final int? pastTitle = data['pastTitle'];
          final int questionId = data['questionId'];
          final int answeredTimes = data['answeredTimes'];
          final int correctTimes = data['correctTimes'];
          final int wrongTimes = data['wrongTimes'];
          final int continuousCorrectTimes = data['continuousCorrectTimes'];
          final int latestCorrect = data['latestCorrect'];
          return QuestionDataList(
            pastTitle,
            questionId,
            answeredTimes,
            correctTimes,
            wrongTimes,
            continuousCorrectTimes,
            latestCorrect,
          );
        }).toList();
      }
      this.questionDataListAll!.add(questionDataList);
    }
    notifyListeners();
  }
}
