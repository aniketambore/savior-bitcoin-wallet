import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

abstract class WalletThemeData {
  ThemeData get materialThemeData;
}

class LightWalletThemeData extends WalletThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
      brightness: Brightness.light,
      primarySwatch: persianBlue.toMaterialColor());
}

class DarkWalletThemeData extends WalletThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
      brightness: Brightness.dark,
      primarySwatch: persianBlue.toMaterialColor());
}

extension on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );
}
