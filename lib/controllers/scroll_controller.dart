import 'package:flutter/material.dart';

class ScrollController extends StatefulWidget {
  const ScrollController({Key? key}) : super(key: key);

  @override
  ScrollControllerState createState() => ScrollControllerState();
}

class ScrollControllerState extends State<ScrollController>
    with SingleTickerProviderStateMixin {
  static PageController? pageController;

  void initState() {
    pageController = PageController();
    super.initState();
  }

  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  static void start() {
    pageController?.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
