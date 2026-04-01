import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../auth/cubit/firebase_auth_cubit.dart';
import '../../auth/screens/login_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../../tasks/cubit/task_cubit.dart';
import '../../tasks/models/task_model.dart';

import '../widgets/stat_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = context.read<FirebaseAuthCubit>().currentUser;
    final taskCubit = context.read<TaskCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              (user?.displayName?.isNotEmpty == true
                      ? user!.displayName!.substring(0, 1)
                      : user?.email.substring(0, 1) ?? '?')
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (user?.displayName != null && user!.displayName!.isNotEmpty)
            Text(
              user.displayName!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          if (user?.email != null)
            Text(user!.email, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          // إحصائيات من الـ stream
          StreamBuilder<List<TaskModel>>(
            stream: taskCubit.getTasksStream(),
            builder: (context, snapshot) {
              final list = snapshot.data ?? [];
              final completed = list.where((t) => t.isCompleted).length;
              final pending = list.length - completed;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatCard(label: l10n.totalTasks, value: '${list.length}'),
                  StatCard(label: l10n.completedCount, value: '$completed'),
                  StatCard(label: l10n.pendingCount, value: '$pending'),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            title: l10n.editProfile,
            onTap: () async {
              final result = await Navigator.of(context).push<bool>(
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
              if (result == true && context.mounted) {
                (context as Element).markNeedsBuild();
              }
            },
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            title: l10n.settings,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            title: l10n.logout,
            buttonColor: Theme.of(context).colorScheme.error,
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(l10n.logout),
                  content: Text(l10n.logoutConfirm),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: Text(l10n.cancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: Text(l10n.logout),
                    ),
                  ],
                ),
              );
              if (confirm == true && context.mounted) {
                await context.read<FirebaseAuthCubit>().logout();
                if (confirm == true && context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (_) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
