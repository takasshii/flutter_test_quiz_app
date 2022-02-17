import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithTwoIcon extends StatelessWidget {
  const TitleWithTwoIcon({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {},
        ),
        Spacer(),
        RichText(
            text: TextSpan(
                text: "${title}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kBlackColor))),
        Spacer(),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {},
        ),
      ],
    );
  }
}
