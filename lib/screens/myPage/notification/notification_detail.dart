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
    Size size = MediaQuery.of(context).size;
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
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: notification.color,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      child: Text(
                        "${notification.tag}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: kDefaultPadding / 2),
                      child: Text(
                        "${notification.updatedAt.toDate().year}-${notification.updatedAt.toDate().month}-${notification.updatedAt.toDate().day} ${notification.updatedAt.toDate().hour}:${notification.updatedAt.toDate().minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: kBlackColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: kGrayColor, width: 1))),
                child: Text(
                  notification.title,
                  style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
