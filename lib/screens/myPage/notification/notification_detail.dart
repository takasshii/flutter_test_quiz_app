import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/notification_long.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';

import '../../../constants.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({Key? key, required this.notification})
      : super(key: key);

  final NotificationLong notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        toolbarHeight: 50,
        backgroundColor: kBackGroundColor,
        iconTheme: IconThemeData(color: kBlackColor),
        title: Text(
          "お知らせ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    child: Text(
                      notification.title,
                      style: TextStyle(
                        color: kBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(right: kDefaultPadding / 4),
                      height: 5,
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Container(
                //Statusを取得
                padding: EdgeInsets.only(top: kDefaultPadding),
                width: double.infinity,
                child: Text(
                  "配信日",
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: kDefaultPadding / 2),
                //Statusを取得
                child: Text(
                  "${notification.updatedAt.toDate().year}年${notification.updatedAt.toDate().month}月${notification.updatedAt.toDate().day}日 ${notification.updatedAt.toDate().hour}時${notification.updatedAt.toDate().minute}分",
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                //Statusを取得
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: Text(
                  "配信内容",
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                //Statusを取得
                child: Text(
                  notification.content,
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ), // ここに追加
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
