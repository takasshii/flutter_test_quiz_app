import 'package:flutter/material.dart';

class _ProgressControllerState extends ChangeNotifier
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  //外部からアクセスできるようにする
  Animation get animation => this._animation;

  //継続時間は60秒
  void progress_bar_animation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    //0から1の範囲で変化させられる
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);

    _animationController.forward();
    notifyListeners();
  }
}

/*
@override
void dispose() {
  _animationController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold();
}

 */
