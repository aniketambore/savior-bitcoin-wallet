import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({
    super.key,
    required this.borderColor,
    required this.shadowColor,
    required this.bgColor,
    this.size,
    this.iconData,
    this.borderWidth,
  });

  final Color borderColor;
  final Color shadowColor;
  final Color bgColor;
  final double? size;
  final IconData? iconData;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 34,
      width: size ?? 34,
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: shadowColor,
          )
        ],
        color: bgColor,
        shape: CircleBorder(
          side: BorderSide(
            color: borderColor,
            width: borderWidth ?? 2,
          ),
        ),
      ),
      child: iconData != null && size != null
          ? Icon(
              iconData,
              size: size! - 5,
              color: white,
            )
          : null,
    );
  }
}
