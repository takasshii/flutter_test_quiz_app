import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/ranking_data_get.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/myPage/ranking/model/ranking_model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RankingModel>(
      create: (_) => RankingModel()..fetchRankingList(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            toolbarHeight: 50,
            foregroundColor: kBlackColor,
            backgroundColor: kBackGroundColor,
            title: const Text(
              'ランキング',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kBlackColor),
            ),
            bottom: const TabBar(
              indicatorColor: kPrimaryColor,
              tabs: <Widget>[
                Tab(
                  child: const Text(
                    '総合',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kBlackColor),
                  ),
                ),
                Tab(
                  child: const Text(
                    '1日',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kBlackColor),
                  ),
                ),
              ],
            ),
          ),
          body: Consumer<RankingModel>(builder: (context, model, child) {
            final List<RankingDataGet>? rankingTotalAllTop10 =
                model.rankingTotalAllTop10;
            final List<RankingDataGet>? rankingTodayAllTop10 =
                model.rankingTodayAllTop10;
            if (rankingTotalAllTop10 == null || rankingTodayAllTop10 == null) {
              return Center(child: CircularProgressIndicator());
            }
            return TabBarView(
              children: <Widget>[
                RankingList(
                    rankingTop10: rankingTotalAllTop10, dataName: 'totalTime'),
                RankingList(
                    rankingTop10: rankingTodayAllTop10, dataName: 'todayTime'),
              ],
            );
          }),
          bottomNavigationBar: BuildBottomNavigationBar(),
        ),
      ),
    );
  }
}

class RankingList extends StatelessWidget {
  const RankingList(
      {Key? key, required this.rankingTop10, required this.dataName})
      : super(key: key);

  final List<RankingDataGet> rankingTop10;
  final String dataName;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: rankingTop10.length,
        itemBuilder: (BuildContext context, int index) {
          return BookImageWithName(
            ranking: '${index + 1}',
            data: dataName != 'totalTime'
                ? rankingTop10[index].totalTime
                : rankingTop10[index].todayTime,
            user: rankingTop10[index],
            press: () {},
          );
        });
  }
}

class BookImageWithName extends StatelessWidget {
  const BookImageWithName(
      {Key? key,
      required this.user,
      required this.press,
      required this.ranking,
      required this.data})
      : super(key: key);

  final String ranking;
  final RankingDataGet user;
  final int data;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 8, horizontal: kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kGrayColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                  text: ranking,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kBlackColor)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              //写真のサイズを固定
              width: size.width * 0.23,
              height: size.width * 0.23,
              child: Image.asset(
                "${user.image}",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: size.width * 0.23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${user.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kBlackColor)),
                      TextSpan(
                          text: " さん",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: kGrayColor)),
                    ],
                  )),
                  RichText(
                    text: TextSpan(
                      text: user.grade == null ? "学年未設定" : "${user.grade}回生",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: kGrayColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "${data ~/ 3600}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kBlackColor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 4),
                        child: RichText(
                          text: TextSpan(
                            text: "時間",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kGrayColor),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${data ~/ 60}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kBlackColor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 4),
                        child: RichText(
                          text: TextSpan(
                            text: "分",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kGrayColor),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${data}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kBlackColor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(left: kDefaultPadding / 4),
                        child: RichText(
                          text: TextSpan(
                            text: "秒",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kGrayColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
