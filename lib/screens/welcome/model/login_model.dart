import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  final googleLogin = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  void googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userInfo = await FirebaseAuth.instance.currentUser!
        .linkWithCredential(credential); //ここで連携してるぞ！
    print(userInfo.user!.uid);
    print(userInfo.user!.email);
  }
}
