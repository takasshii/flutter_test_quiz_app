import 'package:flutter/material.dart';

import '../../../constants.dart';

class ReviewTwoMiddleButton extends StatelessWidget {
  const ReviewTwoMiddleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        children: [
          BuildOutlinedButton(title: "ランダム", icon: Icons.question_answer),
          Spacer(flex: 1),
          BuildOutlinedButton(title: "復習", icon: Icons.military_tech),
        ],
      ),
    );
  }
}

class BuildOutlinedButton extends StatelessWidget {
  const BuildOutlinedButton({Key? key, required this.title, required this.icon})
      : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          child: Text("${title}",
              style: TextStyle(color: kBlackColor, fontSize: 16)),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: kGrayColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: kGrayColor),
          ),
        ),
      ),
    );
  }
}
