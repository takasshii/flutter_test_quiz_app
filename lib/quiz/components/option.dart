import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key,
      required this.option,
      required this.number,
      required this.press})
      : super(key: key);

  final String option;
  final int number;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionController(),
      child: Consumer<QuestionController>(
        builder: (context, model, child) {
          Color ChangeColor() {
            if (model.isAnswered) {
              if (number == model.correctAns) {
                return kGreenColor;
              } else if (number == model.selectedAns &&
                  model.correctAns != model.selectedAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: ChangeColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$number, $option",
                    style: TextStyle(color: ChangeColor(), fontSize: 16),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: ChangeColor())),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
