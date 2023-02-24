import 'dart:math';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class QrCard extends StatelessWidget {
  const QrCard({
    super.key,
    required this.qrData,
  });

  final String qrData;
  final minWidth = 350.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: max(screenWidth, minWidth),
      ),
      child: Container(
        decoration: ShapeDecoration(
          shadows: const [
            BoxShadow(
              color: woodSmoke,
              offset: Offset(0, 6),
            )
          ],
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              color: trout,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          color: white,
        ),
        child: QrImage(
          data: qrData,
          version: QrVersions.auto,
        ),
      ),
    );
  }
}
