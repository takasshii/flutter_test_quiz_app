import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/myPage/dataTransfer/model/data_link_model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'components/text_with_dot.dart';
import 'email_login_page.dart';

class DataTransferPage extends StatelessWidget {
  const DataTransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => DataLinkModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          title: Text(
            "データ保護",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: kRedColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Text(
                          "重要",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: kGrayColor, width: 1))),
                  child: Text(
                    "データ保護",
                    style: TextStyle(
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Consumer<DataLinkModel>(builder: (context, model, child) {
                  return Column(
                    children: [
                      SignInButton(
                        Buttons.Email,
                        text: "Emailで連携",
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailLoginPage()),
                          );
                        },
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: "Googleで連携",
                        onPressed: () {
                          model.googleSignIn();
                        },
                      ),
                    ],
                  );
                }),
                Container(
                  //Statusを取得
                  padding: EdgeInsets.only(top: kDefaultPadding / 2),
                  child: Text(
                    "データ保護とは",
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: kDefaultPadding / 4),
                  //Statusを取得
                  child: Column(
                    children: [
                      TextWithDot(
                          text: "メールアドレスなどを登録することで、学習データを保護することができます。",
                          dot: "・"),
                      TextWithDot(
                          text: "よりセキュリティが強固になり、アカウントの乗っ取りを防ぐことができます。",
                          dot: "・"),
                    ],
                  ),
                ), // ここに追加
                Container(
                  //Statusを取得
                  padding: EdgeInsets.only(top: kDefaultPadding / 2),
                  child: Text(
                    "データ引き継ぎについて",
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: kDefaultPadding / 4),
                  //Statusを取得
                  child: Column(
                    children: [
                      TextWithDot(
                          text: "データ移行の際は、必ずこの作業を行なってから引き継ぎを行なってください。",
                          dot: "・"),
                      TextWithDot(text: "データを復旧できる確率が高くなります。", dot: "・"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}
