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
        print(
            "選択したもの:${model.selectedAns},番号${number + 1}, 正解:${model.correctAns}");
        print(model.questionNumber == questionNumber);
        print("モデルの問題番号${model.questionNumber}");
        print("受け取った問題番号${questionNumber}");
        //問題番号かつ選択+正解の選択肢が光る
        if (model.questionNumber == questionNumber &&
            (model.selectedAns.contains(number + 1) ||
                model.correctAns.contains(number + 1))) {
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
