import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TextWithDot extends StatelessWidget {
  const TextWithDot({Key? key, required this.text, required this.dot})
      : super(key: key);

  final String text;
  final String dot;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dot,
          style: TextStyle(
            color: kBlackColor,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: kBlackColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
