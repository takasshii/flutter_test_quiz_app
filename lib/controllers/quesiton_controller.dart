import 'package:flutter/material.dart';
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
  late int correctAns;
  late int selectedAns;

  void checkAns(Question question, int selectedIndex) {
    isAnswered = true;
    correctAns = question.answer;
    selectedAns = selectedIndex;
    if (correctAns == selectedIndex) numberCorrectAns++;
    notifyListeners();
  }

  void nextQuestion() {
    isAnswered = false;
  }
}
