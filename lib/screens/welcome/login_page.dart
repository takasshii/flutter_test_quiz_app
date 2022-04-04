import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/screens/books/book_lists.dart';
import 'package:provider/provider.dart';

import 'components/input_form.dart';
import 'forgot_password.dart';
import 'model/login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
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
          padding: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Consumer<LoginModel>(builder: (context, model, child) {
              return Column(
                children: [
                  InputForm(
                    hintText: 'Email Address',
                    onChanged: (text) {
                      model.setMail(text);
                    },
                    controller: model.mailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  InputForm(
                    hintText: 'Password',
                    onChanged: (text) {
                      model.setPassword(text);
                    },
                    controller: model.passwordController,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: !context.watch<LoginModel>().showPassword,
                    iconButton: IconButton(
                      icon: Icon(context
                              .watch<LoginModel>()
                              .showPassword // パスワード表示状態を監視(watch)
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => context
                          .read<LoginModel>()
                          .togglePasswordVisible(), // パスワード表示・非表示をトグルする
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                    child: ElevatedButton(
                      onPressed: model.isUpdated()
                          ? () async {
                              try {
                                await model.login();
                                await _showDialog(context, 'ログインしました');
                                Navigator.push(
                                  context,
                                  await Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BookList();
                                      },
                                    ),
                                  ),
                                );
                              } catch (e) {
                                _showDialog(context, e.toString());
                              }
                            }
                          : () {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("10文字以下で名前を入力してください"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        onPrimary: Colors.white,
                        minimumSize: Size(230, 60),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0x98FFFFFF),
                        ),
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

  Future _showDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
