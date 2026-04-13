import 'package:flutter/material.dart';
import '../core/theme/light_theme.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key, this.onBack, this.color, this.icon, this.size});
  final VoidCallback? onBack;
  final Color? color;
  final IconData? icon;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onBack != null) {
          onBack?.call();
        } else {
          Navigator.pop(context);
        }
      },
      icon: Icon(
        icon ?? Icons.arrow_back_ios,
        color: color ?? LightThemeColors.primary,
        size: size,
      ),
    );
  }
}
