import 'package:flutter/material.dart';

class ProgressController extends StatefulWidget {
  final Decoration child;
  const ProgressController({Key? key, required this.child}) : super(key: key);

  @override
  ProgressControllerState createState() => ProgressControllerState();
}

class ProgressControllerState extends State<ProgressController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));
    _animation = _animationController.drive(
      Tween<double>(
        begin: 1.0,
        end: 0.0,
      ),
    )..addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * _animationController.value,
      decoration: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void start() {
    _animationController
      ..reset()
      ..forward();
  }
}
