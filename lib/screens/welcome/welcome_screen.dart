import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/screens/books/book_lists.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "助産師国試対策アプリへようこそ！",
          body: "過去問を解いて\n国試対策ができるアプリです！",
          image: Container(
            width: size.width * 0.4,
            height: size.width * 0.4,
            child: Center(
              child: Image.asset("assets/images/エジプト神（イヌ型）.png"),
            ),
          ),
        ),
        PageViewModel(
          title: "使い方",
          body: "",
          image: Container(
            width: size.width * 0.4,
            height: size.width * 0.4,
            child: Center(
              child: Image.asset("assets/images/エジプト神（イヌ型）.png"),
            ),
          ),
        ),
        PageViewModel(
          title: "早速使ってみよう！",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("利用規約をよく読んで使ってね！"),
              TextButton(
                  onPressed: () async {
                    const url =
                        'https://nostalgic-catmint-d3c.notion.site/716f1cb47a35414e81d18acd06ab44ec';
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                        forceWebView: true,
                      );
                    } else {
                      throw 'このURLにはアクセスできません';
                    }
                  },
                  child: Text("利用規約")),
              Text(
                "（外部サイトへ遷移します。）",
                style: TextStyle(fontSize: 10, color: kBlackColor),
              ),
            ],
          ),
          image: Container(
            width: size.width * 0.4,
            height: size.width * 0.4,
            child: Center(
              child: Image.asset("assets/images/エジプト神（イヌ型）.png"),
            ),
          ),
        )
      ],
      onDone: () async {
        completedFirstLogin();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return BookList();
        }));
      },
      showBackButton: false,
      showSkipButton: true,
      skip: const Text("スキップ"),
      next: const Text("次へ"),
      done: const Text("ホームへ", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: kPrimaryColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}

//sharedに書き込み
void completedFirstLogin() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstLogin', true);
}
