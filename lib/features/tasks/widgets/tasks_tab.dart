import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/localization/generated/app_localizations.dart';
import '../cubit/task_cubit.dart';
import '../models/task_model.dart';
import '../screens/edit_task_screen.dart';
import '../screens/task_details_screen.dart';
import 'empty_state.dart';
import 'filter_chip.dart';
import 'task_card.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({
    super.key,
    required this.priorityFilter,
    required this.onFilterChanged,
  });

  final String priorityFilter;
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final taskCubit = context.read<TaskCubit>();

    return StreamBuilder<List<TaskModel>>(
      stream: taskCubit.getTasksStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final list = snapshot.data ?? [];
        var filtered = list;
        if (priorityFilter != 'all') {
          filtered = list.where((t) => t.priority == priorityFilter).toList();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Priority chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CustomFilterChip(
                    label: l10n.all,
                    value: 'all',
                    selected: priorityFilter == 'all',
                    onSelected: onFilterChanged,
                  ),
                  const Gap(8),
                  CustomFilterChip(
                    label: l10n.low,
                    value: 'low',
                    selected: priorityFilter == 'low',
                    onSelected: onFilterChanged,
                  ),
                  const Gap(8),
                  CustomFilterChip(
                    label: l10n.medium,
                    value: 'medium',
                    selected: priorityFilter == 'medium',
                    onSelected: onFilterChanged,
                  ),
                  const Gap(8),
                  CustomFilterChip(
                    label: l10n.high,
                    value: 'high',
                    selected: priorityFilter == 'high',
                    onSelected: onFilterChanged,
                  ),
                ],
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? TasksEmptyState(message: l10n.noTasks)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final task = filtered[i];
                        return TaskCard(
                          task: task,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TaskDetailsScreen(task: task),
                            ),
                          ),
                          onEdit: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditTaskScreen(task: task),
                            ),
                          ),
                          onDelete: () => taskCubit.deleteTask(task.id),
                          onToggleComplete: (v) =>
                              taskCubit.toggleComplete(task.id, v),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
