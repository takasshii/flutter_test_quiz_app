import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/count_down_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class CountDown extends StatelessWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<CountDownController>(
      create: (_) => CountDownController()..fetchCountDownDate(),
      child: Container(
        width: size.width - 40,
        child: Column(
          children: [
            Stack(
              children: [
                RichText(
                  text: TextSpan(
                      text: "国家試験まで",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: kBlackColor)),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: kDefaultPadding / 4),
                    height: 3,
                    color: kPrimaryColor.withOpacity(0.2),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CountDownController>(builder: (context, model, child) {
                  final int? countDown = model.countDown;
                  if (countDown == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return RichText(
                      text: TextSpan(
                          text: "${countDown}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 80,
                              color: kPrimaryColor)));
                }),
                Container(
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: kDefaultPadding / 4),
                  child: RichText(
                    text: TextSpan(
                      text: "日",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: kGrayColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
