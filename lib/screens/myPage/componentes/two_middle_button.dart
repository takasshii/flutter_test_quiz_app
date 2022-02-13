import 'package:flutter/material.dart';

import '../../../constants.dart';

class TwoMiddleButton extends StatelessWidget {
  const TwoMiddleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        children: [
          BuildOutlinedButton(title: "なんか入るよ", icon: Icons.question_answer),
          Spacer(flex: 1),
          BuildOutlinedButton(title: "ランキング", icon: Icons.military_tech),
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
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(
            icon,
            color: kBlackColor,
            size: 18,
          ),
          label: Text("${title}",
              style: TextStyle(color: kBlackColor, fontSize: 16)),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: kGrayColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: kGrayColor.withOpacity(0.5))),
        ),
      ),
    );
  }
}
