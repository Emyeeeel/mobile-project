import 'package:flutter/material.dart';

class ScrollAnimationService {
  final ScrollController scrollController;
  final int index;

  ScrollAnimationService(this.scrollController, this.index);

  void startAnimation(
      double max, double min, double direction, int seconds) async {
    await _animateToMaxMin(max, min, direction, seconds);
  }

  Future<void> _animateToMaxMin(
      double max, double min, double direction, int seconds) async {
    await scrollController.animateTo(direction,
        duration: Duration(seconds: seconds), curve: Curves.linear);
    direction = direction == max ? min : max;
    await _animateToMaxMin(max, min, direction, seconds);
  }
}
