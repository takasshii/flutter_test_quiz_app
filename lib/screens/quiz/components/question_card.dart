import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/progressbar_controller.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:flutter_test_takashii/screens/quiz/components/option.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {Key? key,
      required this.question,
      required this.index,
      required this.pageController})
      : super(key: key);

  final Question question;
  final int index;
  final PageController pageController;

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
      child: Column(
        children: [
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
              questionNumber: question.id,
              number: index,
              press: () {
                model.checkAns(question, index);
                pageScrollModel(model);
              },
            ),
          ),
        ],
      ),
    );
  }

  //スクロールを行うため
  //modelに移すと、statefulが必要になるためやむを得ずここに挿入
  Future<Null> pageScrollModel(QuestionController model) {
    return Future.delayed(
      //２秒後に行う
      Duration(seconds: 2),
      () {
        model.isAnswered = false;
        if (pageController.hasClients) {
          pageController.nextPage(
              //100msかけてページを動かす
              duration: Duration(milliseconds: 100),
              curve: Curves.ease);
        }
        ProgressControllerState.start();
      },
    );
  }
}
