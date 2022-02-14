import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  UserCredential? userCredential;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        userCredential = await FirebaseAuth.instance.signInAnonymously();
        print("logged in");
        //初期化
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        //userのuidを取得
        final user_uid = FirebaseAuth.instance.currentUser!.uid;
        //userのreferenceを取得
        final userReference = firestore.collection('users').doc(user_uid);

        //バッチに保管する
        final batch = firestore.batch();

        //usersの内容をbatchに保管する
        batch.set(userReference, {
          'name': "名無しの権平",
          'grade': null,
          'open': true,
          'graduation': false,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        //public-profileのreferenceを取得
        final publicUserReference =
            firestore.collection('public-profiles').doc(user_uid);
        //publicの内容をbatchに保存する
        batch.set(publicUserReference, {
          'name': "名無しの権平",
          'grade': null,
          'open': true,
          'graduation': false,
          'total_time': 0,
          'today_time': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });

        //書き込む
        await batch.commit();
        notifyListeners();
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
