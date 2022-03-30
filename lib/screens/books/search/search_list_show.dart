import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/bottom_navigation_controller.dart';
import 'package:flutter_test_takashii/screens/books/search/model/search_box_model.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/review/review_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'components/search_box_focused.dart';

class SearchListShow extends StatelessWidget {
  const SearchListShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchBoxModel>(
      create: (_) => SearchBoxModel()..fetchTitleList(),
      child: Consumer<SearchBoxModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            toolbarHeight: 70,
            backgroundColor: kBackGroundColor,
            flexibleSpace: SearchBoxFocused(),
            automaticallyImplyLeading: true,
          ),
          body: ListView.builder(
            itemCount: model.searchedTitleList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(model.searchedTitleList[index].title),
                onTap: () async {
                  selectedIndex = 1;
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewScreen(
                            initialIndex:
                                model.searchedTitleList[index].initialIndex),
                      ));
                },
              );
            },
          ),
          bottomNavigationBar: BuildBottomNavigationBar(),
        );
      }),
    );
  }
}
