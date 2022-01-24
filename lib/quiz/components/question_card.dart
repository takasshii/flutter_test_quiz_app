import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:flutter_test_takashii/quiz/components/option.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.question, required this.index})
      : super(key: key);

  final Question question;
  final int index;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<QuestionController>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(children: [
        Text(
          question.question,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kBlackColor),
        ),
        SizedBox(height: kDefaultPadding / 2),
        ...List.generate(
            question.options.length,
            (index) => Option(
                option: question.options[index],
                number: index,
                press: () => model.checkAns(question, index))),
      ]),
    );
  }
}
