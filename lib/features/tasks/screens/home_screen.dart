import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../auth/cubit/firebase_auth_cubit.dart';
import '../../profile/screens/profile_screen.dart';
import 'add_task_screen.dart';
import 'completed_tasks_screen.dart';
import '../widgets/tasks_tab.dart';

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
          ? TasksTab(
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
