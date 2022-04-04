import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/welcome/components/input_form.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'components/text_with_dot.dart';
import 'model/email_login_model.dart';

class EmailLoginPage extends StatelessWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailLoginModel>(
      create: (_) => EmailLoginModel()..initAsync(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          title: Text(
            "メールアドレス連携",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Consumer<EmailLoginModel>(builder: (context, model, child) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: kDefaultPadding),
                    //Statusを取得
                    child: Column(
                      children: [
                        TextWithDot(text: "メールアドレスを入力してください。", dot: "１. "),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 4),
                          child: TextWithDot(
                              text: "送信されたメールアドレスのリンクをタップすることで連携をすることができます。",
                              dot: "２. "),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: kDefaultPadding / 4),
                    child: InputForm(
                      hintText: 'Email Address',
                      onChanged: (text) {
                        model.setMail(text);
                      },
                      controller: model.mailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    padding: EdgeInsets.only(top: kDefaultPadding / 2),
                    child:
                        //メールリンクの送信がされていないとき
                        model.storedMail == null
                            ? ElevatedButton(
                                onPressed: model.isUpdated()
                                    ? () {
                                        model.register(context);
                                      }
                                    //メールリンクの送信後、リンクの検証がされていない時
                                    : () {
                                        ScaffoldSnackBar.of(context)
                                            .show('メールアドレスを入力してください');
                                      },
                                child: const Text('連携',
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
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
