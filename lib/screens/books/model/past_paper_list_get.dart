import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/book_title_list.dart';

class PastPaperListGet extends ChangeNotifier {
  List<PastPaperTitle> pastPaperTitle = [];

  void fetchTitleList() async {
    List<PastPaperTitle> _pastPaperTitle = await past_paper_title_list
        .map(
          (data) => PastPaperTitle(
            title: data['title'],
            tag: data['tag'],
            sort: data['sort'],
            image: data['image'],
            initialIndex: data['initialIndex'],
          ),
        )
        .toList();
    this.pastPaperTitle = _pastPaperTitle;
    notifyListeners();
  }
}
