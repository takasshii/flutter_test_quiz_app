import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleOfBooks extends StatelessWidget {
  const TitleOfBooks(
      {Key? key,
      required this.title,
      required this.icon_left,
      required this.press})
      : super(key: key);

  final String title;
  final Icon icon_left;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
      child: Row(
        children: <Widget>[
          icon_left,
          TitleWithCustomUnderline(text: title),
          Spacer(),
          Container(
            height: 24,
            width: 24,
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: press,
              icon: Icon(Icons.chevron_right_rounded),
              color: kGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key? key, required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 3,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
