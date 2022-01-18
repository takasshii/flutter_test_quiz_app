import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:flutter_test_takashii/quiz/components/option.dart';

import '../../constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(BuildContext context, {Key? key}) : super(key: key);

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
            sample_data[0]['question'],
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Option(),
          Option(),
          Option(),
          Option(),
        ],
      ),
    );
  }
}
