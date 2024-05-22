import 'package:flutter/material.dart';

late MediaQueryData _mediaQueryData;

class DeviceUtils {
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  static double get safeHeight => size.height - padding.bottom - padding.top;

  static EdgeInsets get padding => _mediaQueryData.padding;

  static EdgeInsets get viewInsets => _mediaQueryData.viewInsets;

  static Size get size => _mediaQueryData.size;
}
