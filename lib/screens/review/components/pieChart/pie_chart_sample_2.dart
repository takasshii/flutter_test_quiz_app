import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../data/past_paper_100.dart';
import '../../../../domain/question_data_list.dart';
import '../../model/review_model.dart';
import '../review_question_count.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final int index;

  const PieChartSample2({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PieChart2State();
}

class _PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ReviewModel>(
      create: (_) => ReviewModel()..fetchQuestionDataList(),
      child: Consumer<ReviewModel>(builder: (context, model, child) {
        final List<List<QuestionDataList>>? questionDataListAll =
            model.questionDataListAll;
        if (questionDataListAll == null) {
          return Center(child: CircularProgressIndicator());
        }
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
                          sections: showingSections(questionDataListAll)),
                    ),
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text:
                                      "${((questionDataListAll[widget.index].where((element) => element.latestCorrect == 1).length.toDouble() / pastPaper100.length) * 100).toInt()}",
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
                          questionCount: (questionDataListAll[widget.index]
                              .where((element) => element.latestCorrect == 1)
                              .length)),
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
                        questionCount: (questionDataListAll[widget.index]
                            .where((element) => element.latestCorrect == 0)
                            .length),
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
                        questionCount: (pastPaper100.length -
                            questionDataListAll[widget.index].length),
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
      }),
    );
  }

  List<PieChartSectionData> showingSections(
      List<List<QuestionDataList>> questionDataListAll) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 10.0 : 0.0;
      final radius = isTouched ? 30.0 : 20.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kGreenColor,
            value: (((questionDataListAll[i]
                        .where((element) => element.latestCorrect == 1)
                        .length
                        .toDouble()) /
                    pastPaper100.length) *
                100),
            title:
                '${(((questionDataListAll[i].where((element) => element.latestCorrect == 1).length.toDouble()) / pastPaper100.length) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: kRedColor,
            value: ((questionDataListAll[i]
                        .where((element) => element.latestCorrect == 0)
                        .length
                        .toDouble()) /
                    pastPaper100.length) *
                100,
            title:
                '${(((questionDataListAll[i].where((element) => element.latestCorrect == 0).length.toDouble()) / pastPaper100.length) * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: kGrayColor,
            value: ((pastPaper100.length -
                    questionDataListAll[i].length.toDouble() /
                        pastPaper100.length)) *
                100,
            title:
                '${(((pastPaper100.length - questionDataListAll[i].length.toDouble()) / pastPaper100.length) * 100).toInt()}%',
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
