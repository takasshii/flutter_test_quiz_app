import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/controllers/progressbar_controller.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalObjectKey<ProgressControllerState>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: size.width, child: ProgressController(key: _key)),
        ],
      ),
    );
  }
}
