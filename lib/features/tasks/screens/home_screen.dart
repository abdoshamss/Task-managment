import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../auth/cubit/firebase_auth_cubit.dart';
import '../../profile/screens/profile_screen.dart';
import '../cubit/task_cubit.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';
import 'completed_tasks_screen.dart';
import 'edit_task_screen.dart';
import 'task_details_screen.dart';

/// TaskFlow home: list of tasks, FAB add, bottom nav Home | Completed | Profile.
class TaskFlowHomeScreen extends StatefulWidget {
  const TaskFlowHomeScreen({super.key});

  @override
  State<TaskFlowHomeScreen> createState() => _TaskFlowHomeScreenState();
}

class _TaskFlowHomeScreenState extends State<TaskFlowHomeScreen> {
  int _currentIndex = 0;
  String _priorityFilter = 'all'; // all | low | medium | high

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = context.watch<FirebaseAuthCubit>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? l10n.home
              : _currentIndex == 1
              ? l10n.completedTasks
              : l10n.profile,
        ),
        actions: [
          if (_currentIndex == 0 && user != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  (user.displayName?.isNotEmpty == true
                          ? user.displayName!.substring(0, 1)
                          : user.email.substring(0, 1))
                      .toUpperCase(),
                  style: const TextStyle(color: AppColors.primary),
                ),
              ),
            ), 
        ],
      ),
      body: _currentIndex == 0
          ? _TasksTab(
              priorityFilter: _priorityFilter,
              onFilterChanged: (v) => setState(() => _priorityFilter = v),
            )
          : _currentIndex == 1
          ? const CompletedTasksScreen()
          : const ProfileScreen(),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddTaskScreen()),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.done_all_outlined),
            selectedIcon: const Icon(Icons.done_all),
            label: l10n.completedTasks,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}

class _TasksTab extends StatelessWidget {
  const _TasksTab({
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
                  _FilterChip(
                    label: l10n.all,
                    value: 'all',
                    selected: priorityFilter == 'all',
                    onSelected: onFilterChanged,
                  ),
                  const Gap(8),
                  _FilterChip(
                    label: l10n.low,
                    value: 'low',
                    selected: priorityFilter == 'low',
                    onSelected: onFilterChanged,
                  ),
                  const Gap(8),
                  _FilterChip(
                    label: l10n.medium,
                    value: 'medium',
                    selected: priorityFilter == 'medium',
                    onSelected: onFilterChanged,
                  ),
                  const Gap(8),
                  _FilterChip(
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
                  ? _EmptyState(message: l10n.noTasks)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final task = filtered[i];
                        return _TaskCard(
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(value),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleComplete,
  });

  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
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
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (v) => onToggleComplete(v ?? false),
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.outline,
          ),
          const Gap(16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
