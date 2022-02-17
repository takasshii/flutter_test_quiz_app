import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationLong {
  NotificationLong(this.title, this.content, this.createdAt, this.updatedAt);
  String title;
  String content;
  Timestamp createdAt;
  Timestamp updatedAt;
}
