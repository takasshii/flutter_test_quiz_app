import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/userWrite.dart';

class SettingModel extends ChangeNotifier {
  UserWrite? user;
  String? name;
  int? grade;
  bool? graduation;
  bool? open;
  final nameController = TextEditingController();
  final gradeController = TextEditingController();
  final graduationController = TextEditingController();
  final openController = TextEditingController();

  //初期化
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //userのuidを取得
  final user_uid = FirebaseAuth.instance.currentUser!.uid;

  SettingModel(user) {
    nameController.text = user!.name;
    grade = user.grade;
    graduation = user.graduation;
    open = user.open;
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setGrade(int grade) {
    this.grade = grade;
    notifyListeners();
  }

  void setOpen(bool open) {
    this.open = open;
    notifyListeners();
  }

  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null || open != null || graduation != null;
  }

  Future<void> userUpdate() async {
    //userのreferenceを取得

    //バッチに保管する
    final WriteBatch batch = firestore.batch();

    //usersの内容をbatchに保管する
    var userReference = firestore.collection('users').doc(user_uid);

    var userWrite = {
      'name': name,
      'grade': grade,
      'open': open,
      'graduation': graduation,
      'updatedAt': FieldValue.serverTimestamp()
    };

    batch.update(userReference, userWrite);

    //public-profileのreferenceを取得
    var publicUserReference =
        firestore.collection('public-profiles').doc(user_uid);

    var publicUserWrite = {
      'name': name,
      'grade': grade,
      'open': open,
      'graduation': graduation,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    //publicの内容をbatchに保存する
    batch.update(publicUserReference, publicUserWrite);
    //書き込む
    await batch.commit();
  }
}
