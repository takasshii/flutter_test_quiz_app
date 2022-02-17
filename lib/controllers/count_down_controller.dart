import 'package:flutter/cupertino.dart';

class CountDownController extends ChangeNotifier {
  int? countDown;
  DateTime? realExamDay = DateTime(2022, 2, 10);
  DateTime? officialAnnouncement = null;
  bool isImage = false;
  DateTime today = DateTime.now();

  void fetchCountDownDate() {
    //realExamDayがある　かつ realが今日以降に存在してる
    if (realExamDay != null && realExamDay!.isAfter(today)) {
      countDown = realExamDay!.difference(today).inDays;
    }
    //realExamDayがある　かつ realが以前に存在してる
    else if (realExamDay != null && realExamDay!.isBefore(today)) {
      realExamDay = new DateTime(
          realExamDay!.year + 1, realExamDay!.month, realExamDay!.day);
      countDown = realExamDay!.difference(today).inDays;
      isImage = true;
    }
    notifyListeners();
  }
}
