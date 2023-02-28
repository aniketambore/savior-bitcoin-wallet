import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class ExpandedOutlinedButton extends StatelessWidget {
  static const double _elevatedButtonHeight = 60;

  const ExpandedOutlinedButton({
    required this.label,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  ExpandedOutlinedButton.inProgress({
    required String label,
    Key? key,
  }) : this(
          label: label,
          icon: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(),
          ),
          key: key,
        );

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: _elevatedButtonHeight,
      width: double.infinity,
      child: icon != null
          ? OutlinedButton.icon(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: black,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              label: Text(
                label,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: woodSmoke,
                ),
              ),
              icon: icon,
            )
          : OutlinedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: black,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: woodSmoke,
                ),
              ),
            ),
    );
  }
}
