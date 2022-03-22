import 'package:flutter/material.dart';

import '../../../constants.dart';

class BuildShowModalBottomSheet extends StatelessWidget {
  const BuildShowModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
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
      child: Column(
        children: [
          TitleWithCloseIcon(),
          SelectIconWithName(
              size, "エジプト神（イヌ型）", "assets/images/エジプト神（イヌ型）.png"),
          SelectIconWithName(
              size, "エジプト神（トリ型）", "assets/images/エジプト神（トリ型）.png"),
          SelectIconWithName(
              size, "エジプト神（ヒト型）", "assets/images/エジプト神（ヒト型）.png"),
          SelectIconWithName(size, "ピラミッド", "assets/images/ピラミッド.png"),
        ],
      ),
    );
  }

  Container SelectIconWithName(Size size, String title, String image) {
    return Container(
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
    );
  }

  Row TitleWithCloseIcon() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          child: IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.close,
                color: kGrayColor,
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            "アイコン変更",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
      ],
    );
  }
}
