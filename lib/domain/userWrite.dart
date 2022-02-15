import 'package:cloud_firestore/cloud_firestore.dart';

class UserWrite {
  UserWrite(this.createdAt, this.updatedAt, this.grade, this.graduation,
      this.open, this.name);
  Timestamp createdAt;
  Timestamp updatedAt;
  int? grade;
  bool graduation;
  String name;
  bool open;
}
