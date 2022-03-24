import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';

import '../../constants.dart';
import 'components/pieChart/pie_chart_sample_2.dart';
import 'components/reviewtwo_middle_button.dart';
import 'components/title_with_two_icon.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key, required this.initialIndex}) : super(key: key);

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        PageController(initialPage: initialIndex);
    final pastPaperList = [
      "105回",
      "104回",
      "103回",
      "102回",
      "101回",
      "2022",
      "2022",
      "2022",
      "2022",
      "2022"
    ];
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: pastPaperList.length,
        itemBuilder: (context, index) => (BuildReviewScreen(
          title: pastPaperList[index],
          pageController: pageController,
          paperLength: pastPaperList.length,
          index: index,
        )),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
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
