import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'componentes/five_big_button.dart';
import 'componentes/icon_with_name.dart';
import 'componentes/two_middle_button.dart';
import 'models/my_page_model.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyPageModel>(
      create: (_) => MyPageModel()..fetchUserList(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            "マイページ",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding),
            child: Consumer<MyPageModel>(builder: (context, model, child) {
              final UserGet? user = model.userDetailList;
              print("${user?.image}");
              if (user == null) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  IconWithName(user: user),
                  TwoMiddleButton(),
                  FiveBigButton(user: user),
                ],
              );
            }),
          ),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}
