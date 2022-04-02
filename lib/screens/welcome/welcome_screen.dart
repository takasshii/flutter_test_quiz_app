import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/screens/books/book_lists.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "宿題管理アプリSKIMERへようこそ",
          body: "宿題をみんなで管理\n宿題を終わらせてランクを上げよう！",
          image: Center(
            child: Image.asset("assets/images/エジプト神（イヌ型）.png"),
          ),
        ),
        PageViewModel(
          title: "名前を入力してね",
          body: "宿題をみんなで管理\n宿題を終わらせてランクを上げよう！",
          image: Center(
            child: Image.asset("assets/images/エジプト神（イヌ型）.png"),
          ),
        ),
        PageViewModel(
          title: "宿題管理アプリSKIMERへようこそ",
          body: "宿題をみんなで管理\n宿題を終わらせてランクを上げよう！",
          image: Center(
            child: Image.asset("assets/images/エジプト神（イヌ型）.png"),
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
