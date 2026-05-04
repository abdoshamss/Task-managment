import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../cubit/task_cubit.dart';
import '../models/task_model.dart';
import 'edit_task_screen.dart';
import 'task_details_screen.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final taskCubit = context.read<TaskCubit>();

    return StreamBuilder<List<TaskModel>>(
      stream: taskCubit.getCompletedTasksStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final list = snapshot.data ?? [];
        if (list.isEmpty) {
          return Center(
            child: FadeIn(
              duration: const Duration(milliseconds: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done_all,
                    size: 80,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.completedTasks,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final task = list[i];
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 100 * (i > 5 ? 5 : i)),
              child: Slidable(
                key: ValueKey(task.id),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (_) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditTaskScreen(task: task),
                        ),
                      ),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: l10n.edit,
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (_) =>
                          taskCubit.toggleComplete(task.id, false),
                      backgroundColor: AppColors.priorityLow,
                      foregroundColor: Colors.white,
                      icon: Icons.undo,
                      label: l10n.pending,
                    ),
                    SlidableAction(
                      onPressed: (_) => taskCubit.deleteTask(task.id),
                      backgroundColor: AppColors.priorityHigh,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: l10n.delete,
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  color: Colors.blue.withOpacity(.1),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Text(
                      '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TaskDetailsScreen(task: task),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
