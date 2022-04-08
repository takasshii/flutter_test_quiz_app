import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:provider/provider.dart';

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
    Size size = MediaQuery.of(context).size;
    final model = Provider.of<QuestionController>(context);
    Color color() {
      if (model.isAnswered) {
        //自身の問題番号と選択番号が一致する場合のみ色を変える
        print("${model.selectedAns},${number + 1}");
        print(model.selectedAns.contains(number + 1));
        if (model.questionNumber == questionNumber &&
            model.selectedAns.contains(number + 1)) {
          return model.color;
        } else {
          return kGrayColor;
        }
      }
      return kGrayColor;
    }

    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding / 1.5),
        padding: EdgeInsets.all(kDefaultPadding / 2),
        decoration: BoxDecoration(
          border: Border.all(color: color()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: size.width - kDefaultPadding,
          child: Text(
            "${number + 1}. $option",
            style: TextStyle(color: color(), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
