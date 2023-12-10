import 'package:flutter/material.dart';

extension ResponsiveSize on BuildContext {
  double width(double wdt) {
    return MediaQuery.of(this).size.width * (wdt / 430);
  }
}
