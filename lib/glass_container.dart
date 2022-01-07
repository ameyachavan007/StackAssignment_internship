import 'dart:ui';
import 'package:demo/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  // final bool switchColour;
  // double width;
  const GlassContainer({
    required this.child,
    required this.start,
    required this.end,
    // required this.switchColour,
    // this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
            // height: 50,
            // width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [kLightGrey.withOpacity(start), kGrey.withOpacity(end)],
                stops: [0.3, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child),
      ),
    );
  }
}
