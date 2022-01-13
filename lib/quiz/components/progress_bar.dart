import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/question_controller.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../constants.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalObjectKey<ProgressControllerState>(context);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF3F4768), width: 3),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    ProgressController(
                  key: _key,
                  child: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("sec"),
                      WebsafeSvg.asset("assets/icons/clock.svg")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: kDefaultPadding / 2),
          child: IconButton(
            icon: Icon(
              Icons.refresh,
              size: 40,
            ),
            onPressed: () {
              _key.currentState?.start();
            },
          ),
        )
      ],
    );
  }
}
