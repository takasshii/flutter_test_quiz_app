import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';

import '../../constants.dart';
import 'components/pieChart/pie_chart_sample_2.dart';
import 'components/reviewtwo_middle_button.dart';
import 'components/title_with_two_icon.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 10,
        child: TabBarView(
          children: [
            BuildReviewScreen(title: "2021"),
            BuildReviewScreen(title: "2020"),
            BuildReviewScreen(title: "2019"),
            BuildReviewScreen(title: "2018"),
            BuildReviewScreen(title: "2017"),
            BuildReviewScreen(title: "2016"),
            BuildReviewScreen(title: "2015"),
            BuildReviewScreen(title: "2014"),
            BuildReviewScreen(title: "2013"),
            BuildReviewScreen(title: "2012"),
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
