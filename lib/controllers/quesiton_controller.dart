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

  void checkAns(Question question, int selectedIndex) {
    isAnswered = true;
    int correctAns = question.answer;
    int selectedAns = selectedIndex;
    if (correctAns == selectedAns) {
      numberCorrectAns++;
      color = kGreenColor;
    } else if (selectedAns != correctAns) {
      color = kRedColor;
    }
    notifyListeners();
  }

  void nextQuestion() {
    isAnswered = false;
  }
}
