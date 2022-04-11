import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../domain/book_title_list.dart';
import '../../domain/question_data_list.dart';
import 'components/pieChart/pie_chart_sample_2.dart';
import 'components/reviewtwo_middle_button.dart';
import 'components/title_with_two_icon.dart';
import 'model/review_model.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key, required this.initialIndex}) : super(key: key);

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        PageController(initialPage: initialIndex);
    return ChangeNotifierProvider<ReviewModel>(
      create: (_) => ReviewModel()..fetchQuestionDataList(),
      child: Consumer<ReviewModel>(builder: (context, model, child) {
        final List<List<QuestionDataList>>? questionDataListAll =
            model.questionDataListAll;
        if (questionDataListAll == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: PageView.builder(
            controller: pageController,
            itemCount: past_paper_title_list.length,
            itemBuilder: (context, index) => (BuildReviewScreen(
              title: past_paper_title_list[index].title,
              pageController: pageController,
              paperLength: past_paper_title_list.length,
              index: index,
            )),
          ),
          bottomNavigationBar: BuildBottomNavigationBar(),
        );
      }),
    );
  }
}

class BuildReviewScreen extends StatelessWidget {
  const BuildReviewScreen(
      {Key? key,
      required this.title,
      required this.pageController,
      required this.paperLength,
      required this.index})
      : super(key: key);

  final int index;
  final String title;
  final PageController pageController;
  final int paperLength;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(kDefaultPadding),
        width: size.width - 40,
        child: Column(
          children: [
            TitleWithTwoIcon(
                title: title,
                pageController: pageController,
                paperLength: paperLength,
                index: index),
            PieChartSample2(),
            ReviewTwoMiddleButton(),
          ],
        ),
      ),
    );
  }
}
