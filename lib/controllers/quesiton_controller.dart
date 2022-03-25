import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/learning_data_get.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class QuestionController extends ChangeNotifier {
  List<Question>? questions;
  static int numberCorrectAns = 0;
  int numberLearnedQuestionSum = 0;
  int numberCorrectQuestionSum = 0;

  //ストップウォッチ
  static var swatch = Stopwatch();
  static final duration = const Duration(seconds: 1);
  Stopwatch s = Stopwatch();

  //タイマーを起動
  static startTimer() {
    Timer(duration, keepRunning);
  }

  //走ってるか
  static keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
  }

  //スタート
  static startStopWatch() {
    swatch.start();
    startTimer();
  }

  //ストップ
  stopStopWatch() {
    swatch.stop();
    print(swatch.elapsed.inSeconds.toString());
    notifyListeners();
  }

  //リセット
  resetStopWatch() {
    swatch.reset();
    notifyListeners();
  }

  //読み込み
  LearningDataGet? learningDateList;
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

  //書き込み
  void UpdateContinuousDaysUpdate(
      int questionLength, int questionCorrect) async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    WidgetsFlutterBinding.ensureInitialized();

    const String tableName = 'LearningData';
    //学習した時間の更新
    //本日の学習時間(秒)
    int todayTime = learningDateList!.totalDay + swatch.elapsed.inSeconds;
    //合計の学習時間
    int totalLearningTime =
        learningDateList!.totalLearningTime + swatch.elapsed.inSeconds;
    //合計の問題数
    int totalQuestion = learningDateList!.totalQuestion + questionLength;
    //合計の正解問題数
    int learnedQuestion = learningDateList!.learnedQuestion + questionCorrect;

    Map<String, dynamic> record = {
      'todayTime': todayTime,
      'totalLearningTime': totalLearningTime,
      'totalQuestion': totalQuestion,
      'learnedQuestion': learnedQuestion,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };

    await db.update(
      tableName,
      record,
    );
  }

  void fetchQuestionList() async {
    numberCorrectAns = 0;
    s.start();
    List<Question> _questions = await sample_data
        .map(
          (question) => Question(
            id: question['id'],
            question: question['question'],
            answer: question['answer_index'],
            options: question['options'],
          ),
        )
        .toList();
    this.questions = _questions;
    notifyListeners();
  }

  bool isAnswered = false;
  Color color = kGrayColor;
  int selectedAns = -1;
  int questionNumber = -1;
  List<bool> storageResult = [];

  void checkAns(Question question, int selectedIndex) {
    isAnswered = true;
    questionNumber = question.id;
    int correctAns = question.answer;
    selectedAns = selectedIndex;
    numberLearnedQuestionSum++;
    if (correctAns == selectedAns) {
      numberCorrectAns++;
      numberCorrectQuestionSum++;
      color = kGreenColor;
      storageResult.add(true);
    } else if (selectedAns != correctAns) {
      color = kRedColor;
      storageResult.add(false);
    }
    notifyListeners();
  }

  void updateQuestionNumber(int index) {
    questionNumber = index + 1;
    notifyListeners();
  }
}
