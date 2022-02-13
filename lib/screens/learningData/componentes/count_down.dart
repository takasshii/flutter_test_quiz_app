import 'package:flutter/material.dart';

import '../../../constants.dart';

class CountDown extends StatelessWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.width * 0.23;
    return Container(
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
                        fontSize: height / 6,
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
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      text: "0",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height,
                          color: kPrimaryColor))),
              Container(
                height: height,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: kDefaultPadding / 4),
                child: RichText(
                  text: TextSpan(
                    text: "日",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height / 6,
                        color: kGrayColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
