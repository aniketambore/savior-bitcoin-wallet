import 'package:flutter/material.dart';
import 'package:component_library/src/theme/wallet_theme_data.dart';

class WalletTheme extends InheritedWidget {
  const WalletTheme({
    super.key,
    required Widget child,
    required this.lightTheme,
    required this.darkTheme,
  }) : super(
          child: child,
        );

  final WalletThemeData lightTheme;
  final WalletThemeData darkTheme;

  @override
  bool updateShouldNotify(WalletTheme oldWidget) =>
      oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  static WalletThemeData of(BuildContext context) {
    final WalletTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<WalletTheme>();
    assert(inheritedTheme != null, 'No WalletTheme found in context');

    final currentBrightness = Theme.of(context).brightness;

    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
