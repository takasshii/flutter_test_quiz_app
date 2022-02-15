import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  void login(currentUser) {
    //同期処理
    try {
      FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print("Failed with error code: ${e.code}");
      print(e.message);
    }
  }

  Future<void> userCreate() async {
    //初期化
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    //userのuidを取得
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user_uid = _auth.currentUser!.uid;
    //userのreferenceを取得

    //バッチに保管する
    final WriteBatch batch = firestore.batch();

    //usersの内容をbatchに保管する
    var userReference = firestore.collection('users').doc(user_uid);

    var userWrite = {
      'name': "名無しの権平",
      'grade': null,
      'open': true,
      'graduation': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp()
    };

    batch.set(userReference, userWrite);

    //public-profileのreferenceを取得
    var publicUserReference =
        firestore.collection('public-profiles').doc(user_uid);

    var publicUserWrite = {
      'name': "名無しの権平",
      'grade': null,
      'open': true,
      'graduation': false,
      'total_time': 0,
      'today_time': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    //publicの内容をbatchに保存する
    batch.set(publicUserReference, publicUserWrite);
    //書き込む
    batch.commit();
  }
}

// ログアウト
Future<void> signOut() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut();
}

// ユーザー削除
Future<void> userDelete(User user) async {
  await user.delete();
}
