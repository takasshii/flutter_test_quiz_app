import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:flutter_test_takashii/quiz/components/option.dart';

import '../../constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Option(number: 1, option: question.options[0]),
          Option(number: 2, option: question.options[1]),
          Option(number: 3, option: question.options[2]),
          Option(number: 4, option: question.options[3]),
        ],
      ),
    );
  }
}
