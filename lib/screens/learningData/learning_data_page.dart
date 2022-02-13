import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';

import 'componentes/bubble_with_image.dart';
import 'componentes/count_down.dart';
import 'componentes/show_big_data_area.dart';
import 'componentes/show_data_area.dart';

class LearningDataPage extends StatelessWidget {
  const LearningDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor.withOpacity(0.97),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                CountDown(),
                BubbleWithImage(),
                Row(
                  children: [
                    ShowDataArea(title: "現在の連続日数", data: 1, unit: "日"),
                    Container(
                      width: 15,
                    ),
                    ShowDataArea(title: "最長連続日数", data: 1, unit: "日"),
                  ],
                ),
                Row(
                  children: [
                    ShowDataArea(title: "学習した日数", data: 1, unit: "日"),
                    Container(
                      width: 15,
                    ),
                    ShowDataArea(title: "習得した問題数", data: 1, unit: "問"),
                  ],
                ),
                Row(
                  children: [
                    ShowDataArea(title: "累計学習問題数", data: 1, unit: "問"),
                    Container(
                      width: 15,
                    ),
                    ShowDataArea(title: "本日の学習時間", data: 1, unit: "分"),
                  ],
                ),
                ShowBigDataArea(title: "合計学習時間", data: 1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
