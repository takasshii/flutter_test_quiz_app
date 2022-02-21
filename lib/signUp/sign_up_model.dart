import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

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

  //ローカルに書き込む
  Future<void> userLocalCreate() async {
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();

    const String createUserSql =
        'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, day TEXT, color TEXT)';
    WidgetsFlutterBinding.ensureInitialized();
    // Open or connect database
    Database database = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(createUserSql);
    });

    final db = await database;
    const String tableName = 'Diary';
    Map<String, dynamic> record = {
      'name': "名無しの権平",
      'grade': null,
      'open': true,
      'graduation': false,
      'total_time': 0,
      'today_time': 0,
      'createdAt': FieldValue.serverTimestamp().toUtc().toIso8601String(),
      'updatedAt': FieldValue.serverTimestamp().toUtc().toIso8601String(),
    };

    await db.insert(
      tableName,
      record,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
