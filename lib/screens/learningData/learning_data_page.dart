import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/domain/learning_data_get.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/learningData/model/learning_data_model.dart';
import 'package:provider/provider.dart';

import 'componentes/bubble_with_image.dart';
import 'componentes/count_down.dart';
import 'componentes/show_big_data_area.dart';
import 'componentes/show_data_area.dart';

class LearningDataPage extends StatelessWidget {
  const LearningDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LearningDataModel>(
      create: (_) => LearningDataModel()..fetchLearningDataList(),
      child: Scaffold(
        backgroundColor: kBackGroundColor.withOpacity(0.97),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(kDefaultPadding),
              child: Consumer<LearningDataModel>(
                builder: (context, model, child) {
                  final LearningDataGet? learningData = model.learningDateList;
                  if (learningData == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      CountDown(),
                      BubbleWithImage(),
                      Row(
                        children: [
                          ShowDataArea(
                              title: "現在の連続日数",
                              data: learningData.currentContinuousRecord,
                              unit: "日"),
                          Container(
                            width: 15,
                          ),
                          ShowDataArea(
                              title: "最長連続日数",
                              data: learningData.continuousRecord,
                              unit: "日"),
                        ],
                      ),
                      Row(
                        children: [
                          ShowDataArea(
                              title: "学習した日数",
                              data: learningData.totalDay,
                              unit: "日"),
                          Container(
                            width: 15,
                          ),
                          ShowDataArea(
                              title: "本日の学習時間",
                              data: learningData.todayTime,
                              unit: "分"),
                        ],
                      ),
                      Row(
                        children: [
                          ShowDataArea(
                              title: "累計学習問題数",
                              data: learningData.totalQuestion,
                              unit: "問"),
                          Container(
                            width: 15,
                          ),
                          ShowDataArea(
                              title: "習得した問題数",
                              data: learningData.learnedQuestion,
                              unit: "問"),
                        ],
                      ),
                      ShowBigDataArea(
                          title: "合計学習時間", data: learningData.learnedQuestion),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}
