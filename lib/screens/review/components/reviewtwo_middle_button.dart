import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:flutter_test_takashii/screens/quiz/quiz_screen.dart';

import '../../../constants.dart';
import '../../../domain/question_data_list.dart';

class ReviewTwoMiddleButton extends StatelessWidget {
  const ReviewTwoMiddleButton({Key? key, required this.questionDataList})
      : super(key: key);

  final List<QuestionDataList> questionDataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        children: [
          BuildOutlinedButton(
              title: "ランダム",
              icon: Icons.question_answer,
              questionDataList: questionDataList,
              learningType: 0),
          Spacer(flex: 1),
          BuildOutlinedButton(
              title: "復習",
              icon: Icons.military_tech,
              questionDataList: questionDataList,
              learningType: 1),
        ],
      ),
    );
  }
}

class BuildOutlinedButton extends StatelessWidget {
  const BuildOutlinedButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.questionDataList,
      required this.learningType})
      : super(key: key);

  final String title;
  final IconData icon;
  final List<QuestionDataList> questionDataList;
  final int learningType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            QuestionController.startStopWatch();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (QuizScreen(
                        questionDataList: questionDataList,
                        learningType: learningType))));
          },
          child: Text("${title}",
              style: TextStyle(color: kBlackColor, fontSize: 16)),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: kGrayColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: kGrayColor),
          ),
        ),
      ),
    );
  }
}
