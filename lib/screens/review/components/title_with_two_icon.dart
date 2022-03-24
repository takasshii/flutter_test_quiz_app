import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithTwoIcon extends StatelessWidget {
  const TitleWithTwoIcon(
      {Key? key,
      required this.title,
      required this.pageController,
      required this.index,
      required this.paperLength})
      : super(key: key);

  final String title;
  final PageController pageController;
  final int index;
  final int paperLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Opacity(
          opacity: index == 0 ? 0.0 : 1.0,
          child: index == 0
              ? IgnorePointer(
                  child: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      if (pageController.hasClients) {
                        pageController.previousPage(
                            //100msかけてページを動かす
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                      }
                    },
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    if (pageController.hasClients) {
                      pageController.previousPage(
                          //100msかけてページを動かす
                          duration: Duration(milliseconds: 100),
                          curve: Curves.ease);
                    }
                  },
                ),
        ),
        Spacer(),
        RichText(
            text: TextSpan(
                text: "${title}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kBlackColor))),
        Spacer(),
        Opacity(
          opacity: index == paperLength - 1 ? 0.0 : 1.0,
          child: index == paperLength
              ? IgnorePointer(
                  child: IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      if (pageController.hasClients) {
                        pageController.nextPage(
                            //100msかけてページを動かす
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                      }
                    },
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    if (pageController.hasClients) {
                      pageController.nextPage(
                          //100msかけてページを動かす
                          duration: Duration(milliseconds: 100),
                          curve: Curves.ease);
                    }
                  },
                ),
        ),
      ],
    );
  }
}
