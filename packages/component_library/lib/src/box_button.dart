import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class BoxButton extends StatelessWidget {
  const BoxButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
    required this.iconData,
  });

  final VoidCallback onTap;
  final String label;
  final Color color;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onPressed: onTap,
        child: Stack(children: [
          Center(
            child: Icon(
              iconData,
              size: 40,
              color: white,
            ),
          ),
          Positioned(
            right: 8,
            bottom: 5,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
