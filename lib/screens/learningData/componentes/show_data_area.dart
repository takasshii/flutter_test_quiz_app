import 'package:flutter/material.dart';

import '../../../constants.dart';

class ShowDataArea extends StatelessWidget {
  const ShowDataArea(
      {Key? key, required this.title, required this.unit, required this.data})
      : super(key: key);

  final String title, unit;
  final int data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width = (size.width - 55) * 0.5;
    final double height = size.width * 0.23;
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kGrayColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      //端っこと中央のmarginを引いて2で割った
      width: width,
      height: height,
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding / 2),
        child: Align(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "${title}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height / 6,
                          color: kGrayColor))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${data}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height / 3,
                          color: kLogoBackGroundColor),
                    ),
                  ),
                  Container(
                    //上のフォントサイズと合わせた。（注）
                    height: height / 3,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(left: kDefaultPadding / 2),
                    child: RichText(
                      text: TextSpan(
                        text: "${unit}",
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
        ),
      ),
    );
  }
}
