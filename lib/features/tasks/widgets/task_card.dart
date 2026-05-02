import 'package:flutter/material.dart';
import 'package:task_mangment/core/theme/light_theme.dart';

import '../../../core/constants/app_colors.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
 
     required this.onToggleComplete,
  });

  final TaskModel task;
  final VoidCallback onTap;
   final ValueChanged<bool> onToggleComplete;

  Color _priorityColor() {
    switch (task.priority) {
      case 'high':
        return AppColors.priorityHigh;
      case 'medium':
        return AppColors.priorityMedium;
      default:
        return AppColors.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LightThemeColors.primary.withOpacity(.1),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Switch(
          activeThumbColor: LightThemeColors.primary,
          value: task.isCompleted,
          inactiveTrackColor: LightThemeColors.primary.withOpacity(.2),
          onChanged: (v) => onToggleComplete(v),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _priorityColor().withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.priority,
            style: TextStyle(
              color: _priorityColor(),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
