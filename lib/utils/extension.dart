import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  TextTheme get textTheme => themeData.textTheme;

  ThemeData get themeData => Theme.of(this);

  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
}
