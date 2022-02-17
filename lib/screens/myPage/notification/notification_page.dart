import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/notification_long.dart';
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
                    margin: EdgeInsets.all(kDefaultPadding),
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black.withOpacity(0.7)),
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
                      title: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notification.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    '更新日',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${notification.updatedAt.toDate().year}-${notification.updatedAt.toDate().month}-${notification.updatedAt.toDate().day}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.deepOrangeAccent
                                        .withOpacity(0.9),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color(0x98FFFFFF),
                                  size: 32,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding / 3,
                            top: 4,
                            right: kDefaultPadding / 3),
                        child: Text(
                          notification.content,
                          style: TextStyle(
                            color: kLogoBackGroundColor,
                            fontSize: 14,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
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
      ),
    );
  }
}
