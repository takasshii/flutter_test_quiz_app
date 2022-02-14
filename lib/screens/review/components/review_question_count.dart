import 'package:flutter/material.dart';

import '../../../constants.dart';

class ReviewQuestionCount extends StatelessWidget {
  const ReviewQuestionCount({Key? key, required this.questionCount})
      : super(key: key);

  final int questionCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
            text: TextSpan(
                text: "${questionCount}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: kBlackColor))),
        Container(
          height: 20,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: kDefaultPadding / 4),
          child: RichText(
            text: TextSpan(
              text: "問",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: kGrayColor),
            ),
          ),
        ),
      ],
    );
  }
}
