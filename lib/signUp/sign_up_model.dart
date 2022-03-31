import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
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

  void userCreate() async {
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
      'image': "assets/images/エジプト神（イヌ型）.png",
      'total_time': 0,
      'today_time': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    //publicの内容をbatchに保存する
    batch.set(publicUserReference, publicUserWrite);
    //書き込む
    await batch.commit();
  }

  //ローカルに書き込む
  Future<void> userLocalCreate() async {
    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    const String createUserSql =
        'CREATE TABLE User(uid TEXT, name TEXT, grade INTEGER, open INTEGER, graduation INTEGER, image TEXT)';
    const String createLearningDataSql =
        'CREATE TABLE LearningData(id INTEGER PRIMARY KEY AUTOINCREMENT, currentContinuousRecord INTEGER, continuousRecord INTEGER, totalDay INTEGER, todayTime INTEGER, totalQuestion INTEGER, learnedQuestion INTEGER, totalLearningTime INTEGER, loginAt INTEGER, createdAt, INTEGER, updatedAt INTEGER)';
    WidgetsFlutterBinding.ensureInitialized();
    // Open or connect database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      // When creating the db, create the table
      db.execute(createUserSql);
      db.execute(createLearningDataSql);
    });

    final db = await database;
    const String tableName1 = 'User';
    Map<String, dynamic> record1 = {
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'name': "名無しの権平",
      'grade': 0,
      'open': 1,
      'graduation': 0,
      'image': "assets/images/エジプト神（イヌ型）.png"
    };

    await db.insert(
      tableName1,
      record1,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    const String tableName2 = 'LearningData';
    Map<String, dynamic> record2 = {
      'currentContinuousRecord': 1,
      'continuousRecord': 1,
      'totalDay': 1,
      'todayTime': 0,
      'totalQuestion': 0,
      'learnedQuestion': 0,
      'totalLearningTime': 0,
      'loginAt': DateTime.now().toUtc().toIso8601String(),
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };

    await db.insert(
      tableName2,
      record2,
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
