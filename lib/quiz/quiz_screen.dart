import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:flutter_test_takashii/models/Questions.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'components/progress_bar.dart';
import 'components/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //スクロールを行うコントローラー
    final PageController pageController = PageController();
    return ChangeNotifierProvider<QuestionController>(
      create: (_) => QuestionController()..fetchQuestionList(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              width: size.width,
              height: size.height,
              child: WebsafeSvg.asset("assets/icons/bg.svg", fit: BoxFit.fill),
            ),
            Consumer<QuestionController>(
              builder: (context, model, child) {
                final List<Question>? questions = model.questions;
                if (questions == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding)),
                      ProgressBar(),
                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Text.rich(
                          TextSpan(
                            text: "Question ${model.questionNumber}",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: kSecondaryColor),
                            children: [
                              TextSpan(
                                text: "/${model.questions?.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: kSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1.5),
                      SizedBox(height: kDefaultPadding),
                      Expanded(
                          child: PageView.builder(
                              //前に戻れなくなる
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              onPageChanged: model.updateQuestionNumber,
                              itemCount: questions.length,
                              itemBuilder: (context, index) => QuestionCard(
                                  index: index,
                                  question: questions[index],
                                  pageController: pageController))),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
