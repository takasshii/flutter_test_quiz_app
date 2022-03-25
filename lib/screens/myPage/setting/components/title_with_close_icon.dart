import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TitleWithCloseIcon extends StatelessWidget {
  const TitleWithCloseIcon({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 4),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: kGrayColor,
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            "${title}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
      ],
    );
  }
}
