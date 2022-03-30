import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:flutter_test_takashii/screens/myPage/askUs/ask_us_page.dart';
import 'package:flutter_test_takashii/screens/myPage/notification/notification_page.dart';
import 'package:flutter_test_takashii/screens/myPage/policy/policy_page.dart';
import 'package:flutter_test_takashii/screens/myPage/setting/setting_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class FiveBigButton extends StatelessWidget {
  const FiveBigButton({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    void Function() setting = () async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (SettingProfile(user: user))));
    };
    void Function() notification = () async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => (NotificationPage())));
    };
    void Function() question = () async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => (AskUsPage())));
    };

    _launchInBrowser() async {
      const url = 'https://twitter.com/takashiho_2';
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else {
        throw 'このURLにはアクセスできません';
      }
    }

    void Function() askUs = () {
      _launchInBrowser();
    };

    void Function() UserPolicy = () async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => (PolicyPage())));
    };
    return Column(
      children: [
        SomeFunctionBigButton(
          title: "設定",
          icon: Icon(Icons.settings),
          press: setting,
        ),
        SomeFunctionBigButton(
          title: "お知らせ",
          icon: Icon(Icons.notifications),
          press: notification,
        ),
        SomeFunctionBigButton(
          title: "よくある質問・使い方",
          icon: Icon(Icons.contact_support),
          press: question,
        ),
        SomeFunctionBigButton(
          title: "お問い合わせ・開発者に連絡",
          icon: Icon(Icons.call),
          press: askUs,
        ),
        SomeFunctionBigButton(
          title: "利用規約",
          icon: Icon(Icons.book_rounded),
          press: UserPolicy,
        ),
      ],
    );
  }
}

class SomeFunctionBigButton extends StatelessWidget {
  const SomeFunctionBigButton(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  final String title;
  final Icon icon;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: size.width,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: icon),
              Expanded(
                child: Text(
                  "${title}",
                  style: TextStyle(fontSize: 16, color: kBlackColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}