import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/models/Questions.dart';

import '../constants.dart';

class QuestionController extends ChangeNotifier {
  List<Question>? questions;

  void fetchQuestionList() async {
    List<Question> _questions = sample_data
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
  int numberCorrectAns = 0;
  Color color = kGrayColor;
  int selectedAns = -1;
  int questionNumber = -1;
  List<bool> storageResult = [];

  void checkAns(Question question, int selectedIndex) {
    isAnswered = true;
    questionNumber = question.id;
    int correctAns = question.answer;
    selectedAns = selectedIndex;
    if (correctAns == selectedAns) {
      numberCorrectAns++;
      color = kGreenColor;
      storageResult.add(true);
    } else if (selectedAns != correctAns) {
      color = kRedColor;
      storageResult.add(false);
    }
    notifyListeners();
  }

  void nextQuestion() {
    isAnswered = false;
  }
}
