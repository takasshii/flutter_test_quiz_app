import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key,
      required this.option,
      required this.number,
      required this.press,
      required this.questionNumber})
      : super(key: key);

  final String option;
  final int questionNumber;
  final int number;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<QuestionController>(context);
    Color color() {
      if (model.questionNumber == questionNumber &&
          number == model.selectedAns) {
        return model.color;
      } else {
        return kGrayColor;
      }
    }

    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: color()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$number, $option",
              style: TextStyle(color: color(), fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: color())),
            )
          ],
        ),
      ),
    );
  }
}
