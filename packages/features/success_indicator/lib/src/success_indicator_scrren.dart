import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class SuccessIndicatorScreen extends StatelessWidget {
  const SuccessIndicatorScreen({
    super.key,
    this.title,
    this.message,
    required this.onOkayTap,
  });

  final String? title;
  final String? message;
  final VoidCallback onOkayTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.mediumLarge,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleWidget(
                  borderColor: woodSmoke,
                  shadowColor: trout,
                  bgColor: carribeanGreen,
                  size: 161,
                  iconData: Icons.check_outlined,
                  borderWidth: 4,
                ),
                const SizedBox(
                  height: Spacing.xxLarge,
                ),
                Text(
                  title ?? 'Success',
                  style: const TextStyle(
                    fontSize: 36,
                    color: black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: Spacing.medium,
                ),
                Text(
                  message ??
                      'Congratulations, your request has been successfully processed!',
                  style: const TextStyle(
                    fontSize: 21,
                    color: trout,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Spacing.xxLarge,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ExpandedElevatedButton(
                    label: 'Okay',
                    onTap: onOkayTap,
                    color: woodSmoke,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
