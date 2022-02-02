import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';

class ProgressController extends StatefulWidget {
  const ProgressController({Key? key}) : super(key: key);

  @override
  ProgressControllerState createState() => ProgressControllerState();
}

class ProgressControllerState extends State<ProgressController>
    with SingleTickerProviderStateMixin {
  static late AnimationController animationController;
  late Animation _animation;

  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));
    _animation = animationController.drive(
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

  void stop() {
    animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Container(
            width: size.width * animationController.value,
            decoration: BoxDecoration(
              gradient: kPrimaryGradient,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${(animationController.value * 60).round()} sec"),
                WebsafeSvg.asset("assets/icons/clock.svg")
              ],
            ),
          ),
        )
      ],
    );
  }
}
