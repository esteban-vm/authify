import 'package:flutter/material.dart';

class CustomAnimation {
  CustomAnimation(this.controller) {
    circleSize = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  final AnimationController controller;
  late Animation<double> circleSize;
}
