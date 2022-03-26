import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationController extends ChangeNotifier {
  //時間を計測
  int now = DateTime.now().hour;

  late int conversationRange;

  void timeCheck() {
    if (now >= 3 && now <= 10) {
      conversationRange = 1;
    } else if (now >= 11 && now <= 17) {
      conversationRange = 2;
    } else {
      conversationRange = 3;
    }
  }

  final conversationFirst = [
    [
      "おはようございます！今日も1日がんばりましょう！",
    ],
    [
      "こんにちは！昼からも頑張っていこう！",
    ],
    ["こんばんは！おつかれさまです！"],
    ["こんにちは！これからよろしくお願いします！"],
  ];

  late String conversation;

  void randConversation() {
    timeCheck();
    conversationFirst[conversationRange].shuffle();
    conversation = conversationFirst[conversationRange][0];
    notifyListeners();
  }
}
