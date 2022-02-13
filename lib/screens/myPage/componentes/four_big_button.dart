import 'package:flutter/material.dart';

import '../../../constants.dart';

class FourBigButton extends StatelessWidget {
  const FourBigButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SomeFunctionBigButton(title: "設定", icon: Icon(Icons.settings)),
        SomeFunctionBigButton(title: "お知らせ", icon: Icon(Icons.notifications)),
        SomeFunctionBigButton(
            title: "よくある質問・お問い合わせ", icon: Icon(Icons.contact_support)),
        SomeFunctionBigButton(title: "利用規約", icon: Icon(Icons.book_rounded)),
      ],
    );
  }
}

class SomeFunctionBigButton extends StatelessWidget {
  const SomeFunctionBigButton(
      {Key? key, required this.title, required this.icon})
      : super(key: key);

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: size.width,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: icon),
              Text(
                "${title}",
                style: TextStyle(fontSize: 16, color: kBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
