import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/bottom_navigation_controller.dart';
import 'package:flutter_test_takashii/domain/book_title_list.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/review/review_screen.dart';

import '../../../constants.dart';

class BookListPastPaperVertical extends StatelessWidget {
  const BookListPastPaperVertical({Key? key, required this.pastPaperTitle})
      : super(key: key);

  final List<PastPaperTitle> pastPaperTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        toolbarHeight: 50,
        backgroundColor: kBackGroundColor,
        foregroundColor: kBlackColor,
        title: Text(
          "過去問一覧",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: pastPaperTitle.length,
          itemBuilder: (BuildContext context, int index) {
            return BookImageWithName(
                title: pastPaperTitle[index].title,
                image: pastPaperTitle[index].image,
                press: () async {
                  selectedIndex = 1;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewScreen(
                          initialIndex: pastPaperTitle[index].initialIndex),
                    ),
                  );
                });
          }),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
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
