import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/learning_data_get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';
import '../data/past_paper_100.dart';
import '../domain/book_title_list.dart';
import '../domain/past_problem.dart';
import '../domain/question_data_list.dart';

class QuestionController extends ChangeNotifier {
  List<PastProblem>? questions;
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
    notifyListeners();
  }

  //リセット
  resetStopWatch() {
    swatch.reset();
    notifyListeners();
  }

  //学習データの読み込み
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

    //Publicのアップデート
    imageUpdate(todayTime, totalLearningTime);
  }

  //Publicの学習時間のアップデート
  Future<void> imageUpdate(int todayTime, int totalLearningTime) async {
    //初期化
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //userのuidを取得
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user_uid = _auth.currentUser!.uid;

    //public-profileのreferenceを取得
    var publicUserReference =
        firestore.collection('public-profiles').doc(user_uid);

    publicUserReference.update({
      'today_time': todayTime,
      'total_time': totalLearningTime,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  final pastPaperTitleList = past_paper_title_list;

  //問題データの取得
  QuestionDataList? questionData;

  //見つかったかどうかを検知
  bool isSearched = false;

  //1問ごとに取得したいので、Listには分けない
  //問題取得時によぶ
  Future<void> fetchQuestionDataList(int tag, int id) async {
    isSearched = false;
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;

    List<Map<String, dynamic>>? listTemp =
        await db.query('QuestionData', where: 'questionId=?', whereArgs: [id]);

    //何も格納されていないとき
    if (listTemp.length == 0) {
      isSearched = false;
      final int pastTitle = tag;
      final int questionId = id;
      final int answeredTimes = 0;
      final int correctTimes = 0;
      final int wrongTimes = 0;
      final int continuousCorrectTimes = 0;
      final int latestCorrect = 0;
      this.questionData = QuestionDataList(pastTitle, questionId, answeredTimes,
          correctTimes, wrongTimes, continuousCorrectTimes, latestCorrect);
    } else {
      isSearched = true;
      final int pastTitle = listTemp[0]['pastTitle'];
      final int questionId = id;
      final int answeredTimes = listTemp[0]['answeredTimes'];
      final int correctTimes = listTemp[0]['correctTimes'];
      final int wrongTimes = listTemp[0]['wrongTimes'];
      final int continuousCorrectTimes = listTemp[0]['continuousCorrectTimes'];
      final int latestCorrect = listTemp[0]['latestCorrect'];
      this.questionData = QuestionDataList(pastTitle, questionId, answeredTimes,
          correctTimes, wrongTimes, continuousCorrectTimes, latestCorrect);
    }
  }

  //書き込み
  //正解の場合
  Future<void> UpdateQuestionDataCorrect(PastProblem question) async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    WidgetsFlutterBinding.ensureInitialized();

    const String tableName = 'QuestionData';

    int answeredTimes = questionData!.answeredTimes + 1;
    int correctTimes = questionData!.correctTimes + 1;
    int continuousCorrectTimes = questionData!.continuousCorrectTimes + 1;
    Map<String, dynamic> record = {
      'pastTitle': question.tag.toInt(),
      'questionId': question.id.toInt(),
      'answeredTimes': answeredTimes,
      'correctTimes': correctTimes,
      'wrongTimes': questionData!.wrongTimes.toInt(),
      'continuousCorrectTimes': continuousCorrectTimes,
      'latestCorrect': 1,
    };

    //データがある場合はupdate
    if (isSearched) {
      await db.update(
        tableName,
        record,
        where: 'questionId=?',
        whereArgs: [question.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //ない場合はinsert
    } else {
      await db.insert(
        tableName,
        record,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  //書き込み
  //不正解の場合
  Future<void> UpdateQuestionDataWrong(PastProblem question) async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    WidgetsFlutterBinding.ensureInitialized();

    const String tableName = 'QuestionData';

    int answeredTimes = questionData!.answeredTimes + 1;
    int wrongTimes = questionData!.wrongTimes + 1;
    Map<String, dynamic> record = {
      'pastTitle': question.tag.toInt(),
      'questionId': question.id.toInt(),
      'answeredTimes': answeredTimes,
      'correctTimes': questionData!.correctTimes.toInt(),
      'wrongTimes': wrongTimes,
      'continuousCorrectTimes': 0,
      'latestCorrect': 0,
    };

    if (isSearched) {
      await db.update(
        tableName,
        record,
        where: 'questionId=?',
        whereArgs: [question.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //ない場合はinsert
    } else {
      await db.insert(
        tableName,
        record,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  void fetchQuestionList(
      List<QuestionDataList> questionDataList, int learningType) async {
    numberCorrectAns = 0;
    resetStopWatch();
    s.start();
    //間違えたリストの抽出
    List<int> wrongIdList = [];
    List<int> correctIdList = [];

    questionDataList.forEach((data) {
      if (data.latestCorrect == 0) {
        wrongIdList.add(data.questionId);
      } else if (data.latestCorrect == 1) {
        correctIdList.add(data.questionId);
      }
    });
    //ランダムを選択した場合
    if (learningType == 0) {
      //問題リスト 正解してないものを抽出する
      List<PastProblem>? _questions = [];
      pastPaper100.map((question) {
        int id = question['id'];
        if (!correctIdList.contains(id)) {
          _questions!.add(PastProblem(
            id: question['id'],
            tag: question['tag'],
            question: question['question'],
            options: question['options'],
            answerIndex: question['answer_index'],
            score: question['score'],
            image: question['image'],
          ));
        }
      }).toList();
      //シャッフル
      _questions.shuffle();
      //n問切り出す
      int finalIndex = _questions.length < 5 ? _questions.length : 5;
      _questions = _questions.sublist(0, finalIndex);
      this.questions = _questions;
      //何も取得できない場合
      if (_questions.length == 0) {
        List<PastProblem> _questions = await pastPaper100
            .map(
              (question) => PastProblem(
                id: question['id'],
                tag: question['tag'],
                question: question['question'],
                options: question['options'],
                answerIndex: question['answer_index'],
                score: question['score'],
                image: question['image'],
              ),
            )
            .toList();
        //シャッフル
        _questions.shuffle();
        //n問切り出す
        int finalIndex = _questions.length < 5 ? _questions.length : 5;
        _questions = _questions.sublist(0, finalIndex);
        this.questions = _questions;
      }
    }
    //復習を選択したとき
    else if (learningType == 1) {
      //問題リスト 間違ってるものを抽出
      List<PastProblem>? _questions = [];
      pastPaper100.map((question) {
        int id = question['id'];
        if (wrongIdList.contains(id)) {
          _questions!.add(PastProblem(
            id: question['id'],
            tag: question['tag'],
            question: question['question'],
            options: question['options'],
            answerIndex: question['answer_index'],
            score: question['score'],
            image: question['image'],
          ));
        }
      }).toList();
      //シャッフル
      _questions.shuffle();
      //n問切り出す
      int finalIndex = _questions.length < 5 ? _questions.length : 5;
      _questions = _questions.sublist(0, finalIndex);
      this.questions = _questions;
      //何も取得できない場合
      if (_questions.length == 0) {
        this.questions = _questions;
      }
    }
    if (questions!.length != 0) {
      //初回の問題を設定
      initQuestion(questions![0]);
      await fetchQuestionDataList(questions![0].tag, questions![0].id);
    }
    notifyListeners();
  }

  bool isAnswered = false;
  Color color = kGrayColor;

  //現在の問題数
  int questionIndex = 1;
  List<bool> storageResult = [];

  //選択肢格納用
  List<int> selectedAns = [];

  //解答格納用
  List<int> correctAns = [];

  //解答の数
  int? answerSum;

  //questionの初期設定
  void initQuestion(PastProblem question) {
    //選択した選択肢
    selectedAns = [];
    //解答
    correctAns = question.answerIndex;
    //わからないの色を戻す
    isFailedTapped = false;
    notifyListeners();
  }

  //全て選択し終えたかチェック
  bool isCompleted(PastProblem question, selectedIndex) {
    answerSum = question.answerIndex.length;
    selectedAns.add(selectedIndex + 1);
    int selectedSum = selectedAns.length;
    //全て選択していた場合は、checkAnsに
    if (answerSum == selectedSum) {
      checkAns(question);
      return true;
    } else {
      return false;
    }
  }

  void checkAns(PastProblem question) async {
    //まだ選択途中の処理
    isAnswered = true;
    numberLearnedQuestionSum++;
    //正解の処理
    if (DeepCollectionEquality().equals(correctAns, selectedAns)) {
      numberCorrectAns++;
      numberCorrectQuestionSum++;
      storageResult.add(true);
      await UpdateQuestionDataCorrect(question);
    } else {
      storageResult.add(false);
      await UpdateQuestionDataWrong(question);
    }
    notifyListeners();
  }

  //問題番号を更新
  void updateIndex() {
    questionIndex++;
    notifyListeners();
  }

  //わからないを選択した際
  bool isFailedTapped = false;

  Color changeRedColor() {
    if (isFailedTapped) {
      return kRedColor;
    }
    return kGrayColor;
  }
}
