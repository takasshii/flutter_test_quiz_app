import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationLong {
  NotificationLong(this.title, this.content, this.tag, this.color,
      this.createdAt, this.updatedAt);
  String title;
  String content;
  String tag;
  Color color;
  Timestamp createdAt;
  Timestamp updatedAt;
}
