import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/books/book_lists.dart';
import 'package:flutter_test_takashii/screens/learningData/learning_data_page.dart';
import 'package:flutter_test_takashii/screens/myPage/my_page_screen.dart';
import 'package:flutter_test_takashii/screens/review/review_screen.dart';

int selectedIndex = 0;

class BottomNavigationController extends ChangeNotifier {
  Future<void> onItemTapped(int index, BuildContext context) async {
    int previousIndex = selectedIndex;
    selectedIndex = index;
    if (selectedIndex == 0 && previousIndex != selectedIndex) {
      await Navigator.pushAndRemoveUntil(
        context,
        new PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              new BookList(),
          transitionDuration: Duration(seconds: 0),
        ),
        (_) => false,
      );
    }
    if (selectedIndex == 1 && previousIndex != selectedIndex) {
      await Navigator.pushAndRemoveUntil(
        context,
        new PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              new ReviewScreen(),
          transitionDuration: Duration(seconds: 0),
        ),
        (_) => false,
      );
    }
    if (selectedIndex == 2 && previousIndex != selectedIndex) {
      await Navigator.pushAndRemoveUntil(
        context,
        new PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              new LearningDataPage(),
          transitionDuration: Duration(seconds: 0),
        ),
        (_) => false,
      );
    }
    if (selectedIndex == 3 && previousIndex != selectedIndex) {
      await Navigator.pushAndRemoveUntil(
        context,
        new PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              new MyPageScreen(),
          transitionDuration: Duration(seconds: 0),
        ),
        (_) => false,
      );
    }
    notifyListeners();
  }
}
