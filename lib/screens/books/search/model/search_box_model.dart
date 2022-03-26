import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/book_title_list.dart';

class SearchBoxModel extends ChangeNotifier {
  List<PastPaperTitle>? pastPaperTitle;
  String? keywords;
  final searchController = TextEditingController();
  List<PastPaperTitle> searchedTitleList = [];

  void fetchTitleList() async {
    List<PastPaperTitle> _pastPaperTitle = await past_paper_title_list
        .map(
          (data) => PastPaperTitle(
            title: data['title'],
            tag: data['tag'],
            sort: data['sort'],
            initialIndex: data['initialIndex'],
          ),
        )
        .toList();
    this.pastPaperTitle = _pastPaperTitle;
    notifyListeners();
  }

  void setKeywords(String keywords) {
    if (keywords.isNotEmpty) {
      this.keywords = keywords;
      this.searchedTitleList = pastPaperTitle!
          .where((element) => element.title.contains(keywords))
          .toList();
    } else {
      this.searchedTitleList.clear();
    }
    notifyListeners();
  }
}
