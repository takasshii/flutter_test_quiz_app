import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/progressbar_controller.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:flutter_test_takashii/screens/quiz/components/option.dart';
import 'package:flutter_test_takashii/screens/score/score_screen.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {Key? key,
      required this.question,
      required this.index,
      required this.pageController,
      required this.questionLength})
      : super(key: key);

  final Question question;
  final int index;
  final PageController pageController;
  final int questionLength;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<QuestionController>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kGrayColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 4,
            color: kGrayColor.withOpacity(0.23),
          ),
        ],
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
              press: () async {
                model.checkAns(question, index);
                model.fetchLearningDataList();
                ProgressControllerState.stop();
                if (question.id != questionLength)
                  pageScrollModel(model);
                else {
                  model.fetchLearningDataList();
                  if (model.learningDateList != null) {
                    model.stopStopWatch();
                    //データの更新
                    //learningData
                    model.UpdateContinuousDaysUpdate(
                        questionLength, QuestionController.numberCorrectAns);
                    //public

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScoreScreen(questionLength: questionLength),
                      ),
                    );
                  }
                }
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
      Duration(seconds: 1),
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
