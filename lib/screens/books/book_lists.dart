import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/bottom_navigation_controller.dart';
import 'package:flutter_test_takashii/repository/ad_state.dart';
import 'package:flutter_test_takashii/screens/books/book_list_vertical/book_list_past_paper_vertical.dart';
import 'package:flutter_test_takashii/screens/books/components/search_box.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/review/review_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'components/recommend_card.dart';
import 'components/title_of_books.dart';
import 'model/past_paper_list_get.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.mediumRectangle,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<PastPaperListGet>(
      create: (_) => PastPaperListGet()..fetchTitleList(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 70,
          backgroundColor: kBackGroundColor,
          flexibleSpace: SearchBox(),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<PastPaperListGet>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TitleOfBooks(
                  title: "過去問一覧",
                  icon_left: Icon(
                    Icons.book_outlined,
                    color: kPrimaryColor,
                  ),
                  press: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookListPastPaperVertical(
                              pastPaperTitle: model.pastPaperTitle),
                        ));
                  },
                ),
                //上と揃えるために導入
                Container(
                  height: size.width * 0.55,
                  padding: EdgeInsets.only(
                      left: kDefaultPadding, top: kDefaultPadding / 2),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.pastPaperTitle.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RecommendCard(
                            image: model.pastPaperTitle[index].image,
                            title: model.pastPaperTitle[index].title,
                            country: "JP",
                            price: 0,
                            press: () async {
                              selectedIndex = 1;
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                      initialIndex: model
                                          .pastPaperTitle[index].initialIndex),
                                ),
                              );
                            });
                      }),
                ),
                TitleOfBooks(
                  title: "おすすめの問題",
                  icon_left: Icon(
                    Icons.library_add_check_outlined,
                    color: kPrimaryColor,
                  ),
                  press: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookListPastPaperVertical(
                              pastPaperTitle: model.pastPaperTitle),
                        ));
                  },
                ),
                Container(
                  height: size.width * 0.55,
                  padding: EdgeInsets.only(
                      left: kDefaultPadding, top: kDefaultPadding / 2),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.pastPaperTitle.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RecommendCard(
                            image: model.pastPaperTitle[index].image,
                            title: model.pastPaperTitle[index].title,
                            country: "JP",
                            price: 0,
                            press: () async {
                              selectedIndex = 1;
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                      initialIndex: model
                                          .pastPaperTitle[index].initialIndex),
                                ),
                              );
                            });
                      }),
                ),
                if (banner == null)
                  Container()
                else
                  Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        top: kDefaultPadding * 1.5,
                        bottom: kDefaultPadding * 1.5),
                    child: Container(
                      child: AdWidget(ad: banner!),
                      width: banner!.size.width.toDouble(),
                      height: banner!.size.height.toDouble(),
                      decoration: BoxDecoration(
                        color: kSecondBackGroundColor,
                        border: Border.all(color: kGrayColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 4,
                            color: kGrayColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}
