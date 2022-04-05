import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:flutter_test_takashii/screens/myPage/ranking/ranking_page.dart';
import 'package:flutter_test_takashii/screens/myPage/support_developer/support_developer_page.dart';

import '../../../constants.dart';

class TwoMiddleButton extends StatelessWidget {
  const TwoMiddleButton({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        children: [
          BuildOutlinedButton(
              title: "開発者を支援",
              icon: Icons.boy,
              press: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDeveloperPage(),
                    ));
              }),
          Spacer(flex: 1),
          BuildOutlinedButton(
            title: "ランキング",
            icon: Icons.military_tech,
            press: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RankingPage(user: user),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class BuildOutlinedButton extends StatelessWidget {
  const BuildOutlinedButton(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  final String title;
  final IconData icon;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: press,
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
