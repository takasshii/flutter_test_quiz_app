import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';

import '../../constants.dart';

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
              Row(
                children: [
                  Icon(Icons.chevron_left),
                  Spacer(),
                  RichText(
                      text: TextSpan(
                          text: "〜分野",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kBlackColor))),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
