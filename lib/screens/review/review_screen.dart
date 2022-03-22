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
    return Scaffold(
      body: DefaultTabController(
        length: 10,
        initialIndex: initialIndex,
        child: TabBarView(
          children: [
            BuildReviewScreen(title: "105回"),
            BuildReviewScreen(title: "104回"),
            BuildReviewScreen(title: "103回"),
            BuildReviewScreen(title: "102回"),
            BuildReviewScreen(title: "101回"),
            BuildReviewScreen(title: "100回"),
            BuildReviewScreen(title: "105回"),
            BuildReviewScreen(title: "105回"),
            BuildReviewScreen(title: "105回"),
            BuildReviewScreen(title: "105回"),
          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}

class BuildReviewScreen extends StatelessWidget {
  const BuildReviewScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(kDefaultPadding),
        width: size.width - 40,
        child: Column(
          children: [
            TitleWithTwoIcon(title: title),
            PieChartSample2(),
            ReviewTwoMiddleButton(),
          ],
        ),
      ),
    );
  }
}
