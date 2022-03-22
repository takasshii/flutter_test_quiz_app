import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/bottom_navigation_controller.dart';
import 'package:flutter_test_takashii/screens/books/components/search_box.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/review/review_screen.dart';

import 'components/recommend_card.dart';
import 'components/title_of_books.dart';

class BookList extends StatelessWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        toolbarHeight: 70,
        backgroundColor: kBackGroundColor,
        flexibleSpace: SearchBox(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleOfBooks(
              title: "過去問一覧",
              icon_left: Icon(
                Icons.book_outlined,
                color: kPrimaryColor,
              ),
            ),
            //上と揃えるために導入
            Padding(
              padding: EdgeInsets.only(
                  left: kDefaultPadding, top: kDefaultPadding / 2),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    RecommendCard(
                        image: "assets/images/ピンクのエイリアン.png",
                        title: "105回",
                        country: "JP",
                        price: 0,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 0),
                              ));
                        }),
                    RecommendCard(
                        image: "assets/images/紫のエイリアン.png",
                        title: "104回",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 1),
                              ));
                        }),
                    RecommendCard(
                        image: "assets/images/緑のエイリアン.png",
                        title: "103回",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 2),
                              ));
                        }),
                    RecommendCard(
                        image: "assets/images/黄色のエイリアン.png",
                        title: "102回",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 3),
                              ));
                        }),
                  ],
                ),
              ),
            ),
            TitleOfBooks(
              title: "おすすめの問題",
              icon_left: Icon(
                Icons.library_add_check_outlined,
                color: kPrimaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: kDefaultPadding, top: kDefaultPadding / 2),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    RecommendCard(
                        image: "assets/images/エジプト神（イヌ型）.png",
                        title: "2021",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 4),
                              ));
                        }),
                    RecommendCard(
                        image: "assets/images/エジプト神（トリ型）.png",
                        title: "2021",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 5),
                              ));
                        }),
                    RecommendCard(
                        image: "assets/images/エジプト神（ヒト型）.png",
                        title: "2021",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 6),
                              ));
                        }),
                    RecommendCard(
                        image: "assets/images/ピラミッド.png",
                        title: "2021",
                        country: "JP",
                        price: 200,
                        press: () async {
                          selectedIndex = 1;
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(initialIndex: 7),
                              ));
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding * 1.5,
                  bottom: kDefaultPadding * 1.5),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: size.width,
                  height: 185,
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
