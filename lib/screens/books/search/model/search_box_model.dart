import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/book_title_list.dart';

class SearchBoxModel extends ChangeNotifier {
  List<PastPaperTitle> pastPaperTitle = past_paper_title_list;
  String? keywords;
  final searchController = TextEditingController();
  List<PastPaperTitle> searchedTitleList = [];

  void setKeywords(String keywords) {
    if (keywords.isNotEmpty) {
      this.keywords = keywords;
      this.searchedTitleList = pastPaperTitle
          .where((element) => element.title.contains(keywords))
          .toList();
    } else {
      this.searchedTitleList.clear();
    }
    notifyListeners();
  }
}
