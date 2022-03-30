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
              tabs: <Widget>[
                Tab(
                    icon: Icon(
                  Icons.cloud_outlined,
                  color: kBlackColor,
                  size: 18,
                )),
                Tab(
                    icon: Icon(
                  Icons.brightness_5_sharp,
                  color: kBlackColor,
                  size: 18,
                )),
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
                RankingList(rankingTop10: rankingTotalAllTop10),
                RankingList(rankingTop10: rankingTodayAllTop10),
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
  const RankingList({Key? key, required this.rankingTop10}) : super(key: key);

  final List<RankingDataGet> rankingTop10;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: rankingTop10.length,
        itemBuilder: (BuildContext context, int index) {
          return BookImageWithName(
              title: rankingTop10[index].name,
              image: rankingTop10[index].image,
              press: () {});
        });
  }
}

class BookImageWithName extends StatelessWidget {
  const BookImageWithName(
      {Key? key, required this.title, required this.image, required this.press})
      : super(key: key);

  final String title;
  final String image;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 8, horizontal: kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kGrayColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: kDefaultPadding),
              //写真のサイズを固定
              width: size.width * 0.2,
              height: size.width * 0.2,
              child: Image.asset(
                "${image}",
                fit: BoxFit.contain,
              ),
            ),
            RichText(
              text: TextSpan(
                  text: title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kBlackColor)),
            ),
          ],
        ),
      ),
    );
  }
}
