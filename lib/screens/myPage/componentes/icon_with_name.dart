import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/userGet.dart';

import '../../../constants.dart';

class IconWithName extends StatelessWidget {
  const IconWithName({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin:
              EdgeInsets.only(bottom: kDefaultPadding, right: kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kGrayColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(50),
          ),
          //写真のサイズを固定
          width: size.width * 0.2,
          height: size.width * 0.2,
          child: Image.asset(
            "assets/images/エジプト神（イヌ型）.png",
            fit: BoxFit.contain,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "${user.name}さん",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kBlackColor))),
            RichText(
              text: TextSpan(
                text: "${user.grade}回生",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: kGrayColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
