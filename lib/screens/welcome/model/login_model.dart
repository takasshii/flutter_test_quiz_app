import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String? mail;
  String? password;
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //パスワード表示切り替え
  bool showPassword = false;
  void togglePasswordVisible() {
    showPassword = !showPassword;
    notifyListeners();
  }

  //Controllerに反映
  SettingModel(user) {
    mailController.text = user!.name;
    passwordController.text = user!.name;
    mail = user.mail;
    password = user.password;
  }

  void setMail(String mail) {
    this.mail = mail;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  bool isUpdated() {
    return (mail != null && password != null);
  }

  Future login() async {
    if (mail == null) {
      throw ('メールアドレスを入力してください');
    }

    if (password == null) {
      throw ('パスワードを入力してください');
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: mail!,
      password: password!,
    );
  }
}
