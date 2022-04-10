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
      required this.questionIndex,
      required this.pageController,
      required this.questionLength})
      : super(key: key);

  final PastProblem question;
  final int questionIndex;
  final PageController pageController;
  final int questionLength;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<QuestionController>(context, listen: false);
    Size size = MediaQuery.of(context).size;
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
              style: TextStyle(color: kBlackColor, fontSize: 16),
            ),
            ...List.generate(
              question.options.length,
              (index) => Option(
                option: question.options[index],
                questionNumber: question.id,
                number: index,
                questionIndex: questionIndex,
                press: () async {
                  bool isCompleted = model.isCompleted(question, index);
                  if (isCompleted) {
                    ProgressControllerState.stop();
                    model.fetchLearningDataList();
                    if (questionIndex != questionLength) {
                      await pageScrollModel(model);
                      model.initQuestion(question);
                      model.updateIndex();
                    } else {
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
            GestureDetector(
              //上と同じ
              onTap: () async {
                model.isFailedTapped = true;
                model.changeRedColor();
                model.checkAns(question);
                ProgressControllerState.stop();
                model.fetchLearningDataList();
                if (questionIndex != questionLength) {
                  await pageScrollModel(model);
                  model.initQuestion(question);
                  model.updateIndex();
                } else {
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
              child: Container(
                margin: EdgeInsets.only(top: kDefaultPadding / 1.5),
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  border: Border.all(color: model.changeRedColor()),
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
                            '${question.options.length + 1}．',
                            style: TextStyle(
                              color: model.changeRedColor(),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          "わからない",
                          style: TextStyle(
                            color: model.changeRedColor(),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        print(model.questionIndex);
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
