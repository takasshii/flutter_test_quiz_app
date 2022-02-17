import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key, required this.questionLength}) : super(key: key);

  final int questionLength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kBackGroundColor,
        iconTheme: IconThemeData(color: kBlackColor),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            int count = 0;
            Navigator.popUntil(context, (_) => count++ >= 2);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Spacer(),
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
              Spacer(
                flex: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
