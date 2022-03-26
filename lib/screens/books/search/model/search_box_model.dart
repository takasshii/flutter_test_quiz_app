import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/book_title_list.dart';

class SearchBoxModel extends ChangeNotifier {
  String? keywords;
  final searchController = TextEditingController();
  List searchedNames = [];

  void setKeywords(String keywords) {
    if (keywords.isNotEmpty) {
      this.keywords = keywords;
      this.searchedNames =
          nameList.where((element) => element.contains(keywords)).toList();
    } else {
      this.searchedNames.clear();
    }
    notifyListeners();
  }
}
