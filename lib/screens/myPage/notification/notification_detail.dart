import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/notification_long.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../repository/ad_state.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({Key? key, required this.notification})
      : super(key: key);

  final NotificationLong notification;

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.mediumRectangle,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

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
                        color: widget.notification.color,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      child: Text(
                        "${widget.notification.tag}",
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
                        "${widget.notification.updatedAt.toDate().year}-${widget.notification.updatedAt.toDate().month}-${widget.notification.updatedAt.toDate().day} ${widget.notification.updatedAt.toDate().hour}:${widget.notification.updatedAt.toDate().minute.toString().padLeft(2, '0')}",
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
                  widget.notification.title,
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
                  widget.notification.content,
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ), //
              if (banner == null)
                Container()
              else
                Padding(
                  padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      top: kDefaultPadding * 2,
                      bottom: kDefaultPadding / 2),
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
                ), // ここに追加
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
