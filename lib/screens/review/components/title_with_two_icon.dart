import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithTwoIcon extends StatelessWidget {
  const TitleWithTwoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chevron_left),
        Spacer(),
        RichText(
            text: TextSpan(
                text: "〜分野",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kBlackColor))),
        Spacer(),
        Icon(Icons.chevron_right),
      ],
    );
  }
}
