import 'package:flutter/material.dart';

import '../constants.dart';

class ProgressController extends StatefulWidget {
  const ProgressController({Key? key}) : super(key: key);

  @override
  ProgressControllerState createState() => ProgressControllerState();
}

class ProgressControllerState extends State<ProgressController>
    with SingleTickerProviderStateMixin {
  static late AnimationController animationController;

  //なぜか使用されない？？
  late Animation animation;

  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));
    animation = animationController.drive(
      Tween<double>(
        begin: 1.0,
        end: 0.0,
      ),
    )..addListener(() => setState(() {}));
    animationController.forward();
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  static void start() {
    animationController
      ..reset()
      ..forward();
  }

  static void stop() {
    animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: size.width - 48 - 40,
              height: 4,
              decoration: BoxDecoration(
                color: kGrayColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                height: 4,
                width: (size.width - 48 - 40) * animationController.value,
                decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(right: kDefaultPadding / 10),
                height: 12,
                child: Text("目標時間 ",
                    style: TextStyle(color: kGrayColor, fontSize: 10))),
            Container(
              height: 12,
              child: Text("${(animationController.value * 60).round()}",
                  style: TextStyle(color: kBlackColor, fontSize: 12)),
            ),
            Container(
                height: 12,
                child: Text("/60秒",
                    style: TextStyle(color: kGrayColor, fontSize: 10))),
          ],
        ),
      ],
    );
  }
}
