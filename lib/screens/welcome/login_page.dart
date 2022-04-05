import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:provider/provider.dart';

import '../myPage/dataTransfer/components/text_with_dot.dart';
import 'components/input_form.dart';
import 'model/login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel()..initAsync(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          title: Text(
            "ログイン",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Consumer<LoginModel>(builder: (context, model, child) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    //Statusを取得
                    padding: EdgeInsets.only(
                        top: kDefaultPadding, left: kDefaultPadding),
                    child: Stack(
                      children: [
                        Text(
                          "メールアドレスでログイン",
                          style: TextStyle(
                            color: kBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 3,
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
                    //Statusを取得
                    child: Column(
                      children: [
                        TextWithDot(text: "メールアドレスを入力してください。", dot: "１. "),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kDefaultPadding / 4,
                              bottom: kDefaultPadding / 4),
                          child: TextWithDot(
                              text: "送信されたメールのリンクを押してください。", dot: "２. "),
                        ),
                      ],
                    ),
                  ),
                  InputForm(
                    hintText: 'Email Address',
                    onChanged: (text) {
                      model.setMail(text);
                    },
                    controller: model.mailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child:
                        //メールリンクの送信がされていないとき
                        model.storedMail == null
                            ? ElevatedButton(
                                onPressed: model.isUpdated()
                                    ? () {
                                        model.register(context);
                                      }
                                    : () {
                                        ScaffoldSnackBar.of(context)
                                            .show('メールアドレスを入力してください');
                                      },
                                child: const Text('ログイン',
                                    style: TextStyle(
                                        color: kBlackColor, fontSize: 16)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: kGrayColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: BorderSide(color: kGrayColor),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: model.isUpdated()
                                    ? () {
                                        model.retry();
                                      }
                                    //メールリンクの送信後、リンクの検証がされていない時
                                    : () {
                                        ScaffoldSnackBar.of(context)
                                            .show('メールアドレスを入力してください');
                                      },
                                child: const Text('再送信',
                                    style: TextStyle(
                                        color: kBlackColor, fontSize: 16)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: kGrayColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: BorderSide(color: kGrayColor),
                                ),
                              ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    //Statusを取得
                    padding: EdgeInsets.only(
                        top: kDefaultPadding, left: kDefaultPadding),
                    child: Stack(
                      children: [
                        Text(
                          "Googleアカウントでログイン",
                          style: TextStyle(
                            color: kBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 3,
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
                    child: TextWithDot(
                        text: "下のボタンをタップし、Googleアカウントでログインしてください。", dot: "１. "),
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () {
                      model.googleSignIn();
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
