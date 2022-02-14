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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(kDefaultPadding),
          width: size.width - 40,
          child: Column(
            children: [
              TitleWithTwoIcon(),
              PieChartSample2(),
              ReviewTwoMiddleButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
