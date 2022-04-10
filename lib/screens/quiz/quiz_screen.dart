import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:provider/provider.dart';

import '../../domain/past_problem.dart';
import 'components/progress_bar.dart';
import 'components/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return ChangeNotifierProvider<QuestionController>(
      create: (_) => QuestionController()..fetchQuestionList(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          title: PreferredSize(
              preferredSize: const Size.fromHeight(20), child: ProgressBar()),
          titleSpacing: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Consumer<QuestionController>(
          builder: (context, model, child) {
            final List<PastProblem>? questions = model.questions;
            if (questions == null) {
              return Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
                    child: Text.rich(
                      TextSpan(
                        text: "${model.questionIndex}",
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: "/${model.questions?.length}",
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                        //前に戻れなくなる
                        physics: NeverScrollableScrollPhysics(),
                        controller: pageController,
                        itemCount: questions.length,
                        itemBuilder: (context, index) => QuestionCard(
                            questionIndex: index,
                            question: questions[index],
                            pageController: pageController,
                            questionLength: questions.length)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
