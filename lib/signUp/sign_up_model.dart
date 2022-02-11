import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserCredential? userCredential;

  // 匿名認証
  Future<UserCredential> signInWithAnonymously() => _auth.signInAnonymously();

  Future<void> login() async {
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        userCredential = await FirebaseAuth.instance.signInAnonymously();
        notifyListeners();
      } else {
        print('User is signed in!');
      }
    });
  }

  // ログアウト
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ユーザー削除
  Future<void> userDelete(User user) async {
    await user.delete();
  }
}
