import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    super.key,
    this.title,
    this.message,
    this.onTryAgain,
  });

  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 48,
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              title ??
                  'There has been an error.\nPlease, check your internet connection and try again later.',
              textAlign: TextAlign.center,
            ),
            if (onTryAgain != null)
              const SizedBox(
                height: 64,
              ),
            if (onTryAgain != null)
              ExpandedElevatedButton(
                onTap: onTryAgain,
                icon: const Icon(
                  Icons.refresh,
                ),
                label: 'Try Again',
              ),
          ],
        ),
      ),
    );
  }
}
