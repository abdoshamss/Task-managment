import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../cubit/task_cubit.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  String _priority = 'medium';
  bool _loading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await context.read<TaskCubit>().addTask(
      title: _titleController.text.trim(),
      description: _descController.text.trim().isEmpty
          ? null
          : _descController.text.trim(),
      dueDate: _dueDate,
      priority: _priority,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addTask)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormFieldWidget(
              controller: _titleController,
              hintText: l10n.taskTitle,
              label: l10n.taskTitle,
              validator: (v) {
                final r = Validators.requiredTaskTitle(v);
                return r != null ? l10n.requiredField : null;
              },
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              controller: _descController,
              hintText: l10n.taskDescription,
              label: l10n.taskDescription,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(l10n.dueDate),
              subtitle: Text(
                '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),
            Text(l10n.priority, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _PriorityChip(
                    label: l10n.low,
                    value: 'low',
                    selected: _priority == 'low',
                    onTap: () => setState(() => _priority = 'low'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _PriorityChip(
                    label: l10n.medium,
                    value: 'medium',
                    selected: _priority == 'medium',
                    onTap: () => setState(() => _priority = 'medium'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _PriorityChip(
                    label: l10n.high,
                    value: 'high',
                    selected: _priority == 'high',
                    onTap: () => setState(() => _priority = 'high'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ButtonWidget(
              title: l10n.save,
              onTap: _loading ? null : _save,
              child: _loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });
  final String label, value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
