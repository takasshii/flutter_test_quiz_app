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
      required this.questionNumber,
      required this.questionIndex})
      : super(key: key);

  final String option;
  final int questionNumber;
  final int number;
  final int questionIndex;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final model = Provider.of<QuestionController>(context);
    Color color() {
      if (model.isAnswered) {
        //自身の問題番号と選択番号、正解番号
        print("選択した番号: ${model.selectedAns}");
        print("正解: ${model.correctAns}");
        print("押した番号: ${number + 1}");
        print(model.questionIndex == questionIndex + 1);
        if (model.questionIndex == questionIndex + 1 &&
            (model.selectedAns.contains(number + 1) ||
                model.correctAns.contains(number + 1))) {
          //正解の場合
          if (model.correctAns.contains(number + 1)) {
            return kGreenCorrectColor;
            //不正解の場合
          } else {
            return kRedColor;
          }
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  //全角入れないと上がずれる
                  Text(
                    '${number + 1}．',
                    style: TextStyle(
                      color: color(),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  "$option",
                  style: TextStyle(
                    color: color(),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
