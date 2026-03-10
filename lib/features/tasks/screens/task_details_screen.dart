import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../cubit/task_cubit.dart';
import '../models/task_model.dart';
import 'edit_task_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});
  final TaskModel task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.isCompleted;
  }

  Color _priorityColor(String p) {
    switch (p) {
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
    final l10n = AppLocalizations.of(context);
    final taskCubit = context.read<TaskCubit>();

    return StreamBuilder<TaskModel?>(
      stream: taskCubit.getTaskStream(widget.task.id),
      initialData: widget.task,
      builder: (context, snapshot) {
        final task = snapshot.data ?? widget.task;

        // Sync local completion state with latest streamed data
        if (snapshot.hasData &&
            snapshot.data != null &&
            _isCompleted != task.isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _isCompleted = task.isCompleted);
          });
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n.taskTitle)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _priorityColor(task.priority).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    task.priority,
                    style: TextStyle(
                      color: _priorityColor(task.priority),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(16),
                Row(
                  children: [
                    Text(
                      l10n.dueDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(8),
                    Text(
                      '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Text(
                      l10n.completed,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(8),
                    Switch(
                      value: _isCompleted,
                      onChanged: (v) {
                        setState(() => _isCompleted = v);
                        taskCubit.toggleComplete(task.id, v);
                      },
                    ),
                  ],
                ),
                if (task.description != null &&
                    task.description!.isNotEmpty) ...[
                  const Gap(16),
                  Text(
                    task.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const Gap(32),
                ButtonWidget(
                  title: l10n.edit,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditTaskScreen(task: task),
                      ),
                    );
                  },
                ),
                const Gap(12),
                ButtonWidget(
                  title: l10n.delete,
                  buttonColor: AppColors.priorityHigh,
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n.delete),
                        content: Text(l10n.deleteConfirm),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(l10n.cancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(l10n.delete),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true && context.mounted) {
                      await taskCubit.deleteTask(task.id);
                      if (context.mounted) Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
