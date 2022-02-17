import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../review_question_count.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  //statefulでの値の受け渡し調べてここ直しておく
  int percentage = 25;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding * 2),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                      startDegreeOffset: 270,
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: size.width / 4,
                      sections: showingSections()),
                ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "${percentage}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width / 6,
                                  color: kBlackColor))),
                      Container(
                        height: size.width / 6,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(left: kDefaultPadding / 4),
                        child: RichText(
                          text: TextSpan(
                            text: "%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width / 10,
                                color: kGrayColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  ReviewQuestionCount(
                    questionCount: 0,
                  ),
                  Indicator(
                    color: kGreenColor,
                    text: '習得済',
                    isSquare: false,
                  ),
                ],
              ),
              SizedBox(
                width: 4,
              ),
              Column(
                children: [
                  ReviewQuestionCount(
                    questionCount: 0,
                  ),
                  Indicator(
                    color: kRedColor,
                    text: '要復習',
                    isSquare: false,
                  ),
                ],
              ),
              SizedBox(
                width: 4,
              ),
              Column(
                children: [
                  ReviewQuestionCount(
                    questionCount: 0,
                  ),
                  Indicator(
                    color: kGrayColor,
                    text: '未学習',
                    isSquare: false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 10.0 : 0.0;
      final radius = isTouched ? 30.0 : 20.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kGreenColor,
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: kRedColor,
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: kGrayColor,
            value: 50,
            title: '50%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
