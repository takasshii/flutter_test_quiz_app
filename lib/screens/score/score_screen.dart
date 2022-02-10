import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key, required this.questionLength}) : super(key: key);

  final int questionLength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text("${QuestionController.numberCorrectAns}/${questionLength}",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: kSecondaryColor)),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
