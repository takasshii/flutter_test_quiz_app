import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/progressbar_controller.dart';
import 'package:flutter_test_takashii/models/Questions.dart';

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

  void checkAns(Question question, int selectedIndex,
      ProgressControllerState _animationController) {
    isAnswered = true;
    _animationController.stop();
    if (selectedIndex == question.answer) numberCorrectAns++;
  }

  void nextQuestion() {
    isAnswered = false;
  }
}
