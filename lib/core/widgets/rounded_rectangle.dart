import 'package:flutter/material.dart';

class RoundedRectangleWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;

  const RoundedRectangleWidget({
    super.key,
    this.width = 414,
    this.height = 900,
    this.color = Colors.white,
    this.borderRadius = 68,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          color: color,
        ),
      ),
    );
  }
}