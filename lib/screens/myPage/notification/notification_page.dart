import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/notification_long.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/myPage/notification/model/notification_model.dart';
import 'package:flutter_test_takashii/screens/myPage/notification/notification_detail.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationModel>(
      create: (_) => NotificationModel()..fetchNotificationList(),
      child: Scaffold(
        backgroundColor: kBackGroundColor.withOpacity(0.97),
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
        body: SafeArea(
          child: Consumer<NotificationModel>(builder: (context, model, child) {
            final List<NotificationLong>? notifications = model.notifications;
            if (notifications == null) {
              return Center(child: CircularProgressIndicator());
            }
            final List<Widget> widgets = notifications
                .map(
                  (notification) => Container(
                    margin: EdgeInsets.symmetric(horizontal:kDefaultPadding, vertical: kDefaultPadding/2),
                    padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2,
                        horizontal: kDefaultPadding / 3),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 4,
                          color: kGrayColor.withOpacity(0.23),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListTile(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NotificationDetail(notification: notification),
                          ),
                        );
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: notification.color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding / 2),
                                child: Text(
                                  "${notification.tag}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      '更新日',
                                      style: TextStyle(
                                          fontSize: 10, color: kGrayColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "${notification.updatedAt.toDate().year}-${notification.updatedAt.toDate().month}-${notification.updatedAt.toDate().day}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: kBlackColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: kGrayColor,
                                    size: 32,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 3),
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                color: kBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList();
            return ListView(
              padding: EdgeInsets.only(top: 10),
              children: widgets,
            );
          }),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}
