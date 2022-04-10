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
        Text("${(animationController.value * 60).round()}/60sec",
            style: TextStyle(color: kBlackColor, fontSize: 10)),
        Stack(
          children: [
            Container(
              width: size.width,
              height: 4,
              decoration: BoxDecoration(
                color: kGrayColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    Container(
                  height: 4,
                  width: size.width * animationController.value,
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
