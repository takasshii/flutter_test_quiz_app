import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/screens/books/components/search_box.dart';

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
        body: Column(
          children: [
            TitleOfBooks(
              title: "過去問一覧",
              icon_left: Icon(
                Icons.book_outlined,
                color: kPrimaryColor,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecommendCard(
                      image: "assets/images/ピンクのエイリアン.png",
                      title: "2022",
                      country: "JP",
                      price: 200,
                      press: () {}),
                  RecommendCard(
                      image: "assets/images/紫のエイリアン.png",
                      title: "2021",
                      country: "JP",
                      price: 200,
                      press: () {}),
                  RecommendCard(
                      image: "assets/images/緑のエイリアン.png",
                      title: "2020",
                      country: "JP",
                      price: 200,
                      press: () {}),
                  RecommendCard(
                      image: "assets/images/黄色のエイリアン.png",
                      title: "2019",
                      country: "JP",
                      price: 200,
                      press: () {}),
                ],
              ),
            ),
            TitleOfBooks(
              title: "おすすめの問題",
              icon_left: Icon(
                Icons.library_add_check_outlined,
                color: kPrimaryColor,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecommendCard(
                      image: "assets/images/エジプト神（イヌ型）.png",
                      title: "2021",
                      country: "JP",
                      price: 200,
                      press: () {}),
                  RecommendCard(
                      image: "assets/images/エジプト神（トリ型）.png",
                      title: "2021",
                      country: "JP",
                      price: 200,
                      press: () {}),
                  RecommendCard(
                      image: "assets/images/エジプト神（ヒト型）.png",
                      title: "2021",
                      country: "JP",
                      price: 200,
                      press: () {}),
                  RecommendCard(
                      image: "assets/images/ピラミッド.png",
                      title: "2021",
                      country: "JP",
                      price: 200,
                      press: () {}),
                ],
              ),
            ),
          ],
        ));
  }
}
