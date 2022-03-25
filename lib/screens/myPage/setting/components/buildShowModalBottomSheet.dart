import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/myPage/setting/components/title_with_close_icon.dart';
import 'package:flutter_test_takashii/screens/myPage/setting/models/setting_image.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class BuildShowModalBottomSheet extends StatelessWidget {
  const BuildShowModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageUpdate>(
      create: (_) => ImageUpdate(),
      child: Container(
        margin: EdgeInsets.only(top: 64),
        decoration: BoxDecoration(
          //モーダル自体の色
          color: Colors.white,
          //角丸にする
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Consumer<ImageUpdate>(builder: (context, model, child) {
          return Column(
            children: [
              TitleWithCloseIcon(title: "アイコン変更"),
              SelectIconWithName(
                title: "エジプト神（イヌ型）",
                image: "assets/images/エジプト神（イヌ型）.png",
                press: () {
                  model.imageUpdate("assets/images/エジプト神（イヌ型）.png");
                  Navigator.pop(context, true);
                },
              ),
              SelectIconWithName(
                title: "エジプト神（トリ型）",
                image: "assets/images/エジプト神（トリ型）.png",
                press: () {
                  model.imageUpdate("assets/images/エジプト神（トリ型）.png");
                  Navigator.pop(context, true);
                },
              ),
              SelectIconWithName(
                title: "エジプト神（ヒト型）",
                image: "assets/images/エジプト神（ヒト型）.png",
                press: () {
                  model.imageUpdate("assets/images/エジプト神（ヒト型）.png");
                  Navigator.pop(context, true);
                },
              ),
              SelectIconWithName(
                title: "ピラミッド",
                image: "assets/images/ピラミッド.png",
                press: () {
                  model.imageUpdate("assets/images/ピラミッド.png");
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class SelectIconWithName extends StatelessWidget {
  const SelectIconWithName(
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
