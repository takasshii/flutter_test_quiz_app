import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';

import '../../constants.dart';
import 'componentes/four_big_button.dart';
import 'componentes/icon_with_name.dart';
import 'componentes/two_middle_button.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              IconWithName(),
              TwoMiddleButton(),
              FourBigButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
