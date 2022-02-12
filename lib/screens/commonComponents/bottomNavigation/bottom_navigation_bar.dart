import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/bottom_navigation_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  const BuildBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationController>(
      create: (_) => BottomNavigationController(),
      child: Consumer<BottomNavigationController>(
          builder: (context, model, child) {
        return BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => model.onItemTapped(index, context),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kGrayColor,
          iconSize: kDefaultPadding * 1.4,
          selectedFontSize: kDefaultPadding * 0.5,
          unselectedFontSize: kDefaultPadding * 0.5,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '教材一覧',
              tooltip: "過去問の一覧が見れます。",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: '復習',
              tooltip: "復習することができます。",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined),
              label: '学習データ',
              tooltip: "学習データを振り返れます。",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'マイページ',
              tooltip: "設定やランキングが見れます。",
            ),
          ],
        );
      }),
    );
  }
}
