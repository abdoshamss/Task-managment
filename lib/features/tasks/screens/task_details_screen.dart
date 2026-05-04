import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 100),
                  child: Container(
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
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: Row(
                    children: [
                      Text(
                        l10n.dueDate,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: Row(
                    children: [
                      Text(
                        l10n.completed,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        activeThumbColor: Colors.blue,
                        value: _isCompleted,
                        inactiveTrackColor: Colors.blue.withOpacity(.2),
                        onChanged: (v) {
                          setState(() => _isCompleted = v);
                          taskCubit.toggleComplete(task.id, v);
                        },
                      ),
                    ],
                  ),
                ),
                if (task.description != null &&
                    task.description!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      task.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 500),
                  child: ButtonWidget(
                    title: l10n.edit,
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditTaskScreen(task: task),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 600),
                  child: ButtonWidget(
                    title: l10n.delete,
                    buttonColor: AppColors.priorityHigh,
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => ZoomIn(
                          duration: const Duration(milliseconds: 300),
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.delete_forever_rounded,
                                    size: 64,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.delete,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l10n.deleteConfirm,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(ctx, false),
                                          child: Text(l10n.cancel),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(ctx, true),
                                          child: Text(l10n.delete),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      if (confirm == true && context.mounted) {
                        await taskCubit.deleteTask(task.id);
                        if (context.mounted) Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
