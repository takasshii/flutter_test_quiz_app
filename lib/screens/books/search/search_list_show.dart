import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/books/search/model/search_box_model.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'components/search_box_focused.dart';

class SearchListShow extends StatelessWidget {
  const SearchListShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchBoxModel>(
      create: (_) => SearchBoxModel(),
      child: Consumer<SearchBoxModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            toolbarHeight: 70,
            backgroundColor: kBackGroundColor,
            flexibleSpace: SearchBoxFocused(),
            automaticallyImplyLeading: false,
          ),
          body: ListView.builder(
            itemCount: model.searchedNames.length,
            itemBuilder: (BuildContext context, int index) {
              print(model.searchedNames);
              return ListTile(title: Text(model.searchedNames[index]));
            },
          ),
          bottomNavigationBar: BuildBottomNavigationBar(),
        );
      }),
    );
  }
}
