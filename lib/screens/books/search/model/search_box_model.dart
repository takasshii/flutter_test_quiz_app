import 'package:flutter/cupertino.dart';
import 'package:flutter_test_takashii/domain/book_title_list.dart';

class SearchBoxModel extends ChangeNotifier {
  String? keywords;
  final searchController = TextEditingController();
  List searchedNames = [];

  void setKeywords(String keywords) {
    this.keywords = keywords;
    this.searchedNames =
        nameList.where((element) => element.contains(keywords)).toList();
    notifyListeners();
  }
}
