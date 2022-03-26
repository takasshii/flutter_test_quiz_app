import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecommendCard extends StatelessWidget {
  const RecommendCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.country,
      required this.price,
      required this.press})
      : super(key: key);

  final String image, title, country;
  final int price;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        margin: EdgeInsets.only(
          right: kDefaultPadding / 1.5,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.3,
        child: Column(
          children: <Widget>[
            Container(
              //写真のサイズを固定
              width: size.width * 0.3,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
