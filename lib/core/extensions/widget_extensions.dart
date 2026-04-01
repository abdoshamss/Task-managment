import 'package:flutter/material.dart';

/// add tap to parent widget
extension WidgetExtension on Widget {
  Widget onTap(
    Function? function, {
    Color? splashColor,
    Color? hoverColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
  }) {
    return InkWell(
      onTap: function as void Function()?,
      splashColor: splashColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      borderRadius: borderRadius,
      child: this,
    );
  }
}
