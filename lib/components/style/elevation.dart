import 'package:flutter/material.dart';

class FElevation {
  static List<BoxShadow> get elevation => [
        BoxShadow(
          offset: Offset(0, 12),
          blurRadius: 24,
          spreadRadius: -4,
          color: Color.fromRGBO(145, 158, 171, 0.12),
        ),
        BoxShadow(
          offset: Offset(0, 0),
          blurRadius: 2,
          color: Color.fromRGBO(145, 158, 171, 0.2),
        )
      ];
  static BoxShadow get elevation1 =>
      BoxShadow(offset: Offset(0, 5.0), blurRadius: 15.0, color: Color.fromRGBO(0, 0, 0, 0.1));
  static BoxShadow get elevation2 =>
      BoxShadow(offset: Offset(0, 4.0), blurRadius: 20.0, color: Color.fromRGBO(0, 0, 0, 0.03));
  static BoxShadow get elevation3 =>
      BoxShadow(offset: Offset(0, 1.0), blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.05));
  static BoxShadow get elevation4 =>
      BoxShadow(offset: Offset(0, -1.0), blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.05));
}
