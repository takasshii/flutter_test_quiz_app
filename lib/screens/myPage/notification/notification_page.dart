import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/notification_long.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:flutter_test_takashii/screens/myPage/notification/model/notification_model.dart';
import 'package:flutter_test_takashii/screens/myPage/notification/notification_detail.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../repository/ad_state.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

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
                    margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
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
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(top: 10),
                    children: widgets,
                  ),
                ),
                if (banner == null)
                  Container()
                else
                  Padding(
                    padding: EdgeInsets.only(
                        top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
                    child: Container(
                      child: AdWidget(ad: banner!),
                      width: banner!.size.width.toDouble(),
                      height: banner!.size.height.toDouble(),
                      decoration: BoxDecoration(
                        color: kSecondBackGroundColor,
                        border: Border.all(color: kGrayColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 4,
                            color: kGrayColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}
