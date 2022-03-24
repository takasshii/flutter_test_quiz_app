import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageUpdate extends ChangeNotifier {
  Future<void> imageUpdate(String image) async {
    //初期化
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //userのuidを取得
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user_uid = _auth.currentUser!.uid;

    //public-profileのreferenceを取得
    var publicUserReference =
        firestore.collection('public-profiles').doc(user_uid);

    publicUserReference.update({
      'image': image,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    const databaseName = 'your_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    Database database = await openDatabase(path, version: 1);

    final db = await database;
    WidgetsFlutterBinding.ensureInitialized();

    const String tableName = 'User';

    Map<String, dynamic> record = {
      'image': image,
    };

    await db.update(
      tableName,
      record,
    );
  }
}
