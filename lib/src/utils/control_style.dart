import 'package:flutter/material.dart';
import '../utils/control_tick_style.dart';

class ControlStyle {
  final Color backgroundColor;
  final Color shadowColor;
  final Color glowColor;
  final ControlTickStyle tickStyle;

  const ControlStyle({
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.grey,
    this.glowColor = Colors.grey,
    this.tickStyle = const ControlTickStyle(),
  });
}
