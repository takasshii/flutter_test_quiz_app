import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/models/Questions.dart';

import '../constants.dart';

class QuestionController extends ChangeNotifier {
  List<Question>? questions;
  static int numberCorrectAns = 0;
  int numberLearnedQuestionSum = 0;
  int numberCorrectQuestionSum = 0;
  Stopwatch s = Stopwatch();

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
