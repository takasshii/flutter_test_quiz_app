import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/progressbar_controller.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:flutter_test_takashii/screens/quiz/components/option.dart';
import 'package:flutter_test_takashii/screens/score/score_screen.dart';
import 'package:provider/provider.dart';

import '../../../domain/past_problem.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {Key? key,
      required this.question,
      required this.index,
      required this.pageController,
      required this.questionLength})
      : super(key: key);

  final PastProblem question;
  final int index;
  final PageController pageController;
  final int questionLength;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<QuestionController>(context, listen: false)
      ..initQuestion(question);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: TextStyle(color: kBlackColor, fontSize: 18),
            ),
            ...List.generate(
              question.options.length,
              (index) => Option(
                option: question.options[index],
                questionNumber: question.id,
                number: index,
                press: () async {
                  bool isCompleted = model.isCompleted(question, index);
                  if (isCompleted) {
                    ProgressControllerState.stop();
                    model.fetchLearningDataList();
                    if (question.id != questionLength)
                      pageScrollModel(model);
                    else {
                      model.fetchLearningDataList();
                      if (model.learningDateList != null) {
                        model.stopStopWatch();
                        //データの更新
                        //learningData
                        model.UpdateContinuousDaysUpdate(questionLength,
                            QuestionController.numberCorrectAns);
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
                  }
                },
              ),
            ),
          ],
        ),
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
