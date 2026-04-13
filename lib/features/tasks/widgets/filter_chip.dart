import 'package:flutter/material.dart';
import 'package:task_mangment/core/theme/light_theme.dart';

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    required this.label,
    required this.value,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final String value;
  final bool selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      color: WidgetStateProperty.all(LightThemeColors.primary.withOpacity(.6)),
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(value),
    );
  }
}
