import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/quesiton_controller.dart';
import 'package:provider/provider.dart';

import '../../domain/past_problem.dart';
import '../../domain/question_data_list.dart';
import 'components/progress_bar.dart';
import 'components/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen(
      {Key? key, required this.questionDataList, required this.learningType})
      : super(key: key);

  final List<QuestionDataList> questionDataList;
  final int learningType;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return ChangeNotifierProvider<QuestionController>(
      create: (_) => QuestionController()
        ..fetchQuestionList(questionDataList, learningType),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 24,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 24,
              padding: EdgeInsets.only(left: kDefaultPadding / 2),
              child: Icon(
                Icons.clear,
                size: 24,
              ),
            ),
          ),
          title: Row(
            children: [
              Container(
                alignment: Alignment.bottomRight,
                child: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: ProgressBar()),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 24,
                  padding: EdgeInsets.only(right: kDefaultPadding / 2),
                  child: Icon(
                    Icons.more_vert,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Consumer<QuestionController>(
          builder: (context, model, child) {
            final List<PastProblem>? questions = model.questions;
            if (questions == null) {
              return Center(child: CircularProgressIndicator());
            } else if (questions.length == 0) {
              return Center(child: Text("復習が完了したよ！"));
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
                            text: "/${model.questions!.length}",
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
