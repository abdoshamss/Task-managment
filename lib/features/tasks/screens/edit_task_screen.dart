import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../cubit/task_cubit.dart';
import '../models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final TaskModel task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late DateTime _dueDate;
  late String _priority;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(
      text: widget.task.description ?? '',
    );
    _dueDate = widget.task.dueDate;
    _priority = widget.task.priority;
  }

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

  Future<void> _update() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final updated = widget.task.copyWith(
      title: _titleController.text.trim(),
      description: _descController.text.trim().isEmpty
          ? null
          : _descController.text.trim(),
      dueDate: _dueDate,
      priority: _priority,
    );
    await context.read<TaskCubit>().updateTask(updated);
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.editTask)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: TextFormFieldWidget(
                controller: _titleController,
                hintText: l10n.taskTitle,
                label: l10n.taskTitle,
                validator: (v) => Validators.requiredTaskTitle(v) != null
                    ? l10n.requiredField
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              child: TextFormFieldWidget(
                controller: _descController,
                hintText: l10n.taskDescription,
                label: l10n.taskDescription,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: ListTile(
                title: Text(l10n.dueDate),
                subtitle: Text(
                  '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.priority,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _PriorityChip(
                          label: l10n.low,
                          selected: _priority == 'low',
                          onTap: () => setState(() => _priority = 'low'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _PriorityChip(
                          label: l10n.medium,
                          selected: _priority == 'medium',
                          onTap: () => setState(() => _priority = 'medium'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _PriorityChip(
                          label: l10n.high,
                          selected: _priority == 'high',
                          onTap: () => setState(() => _priority = 'high'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: ButtonWidget(
                title: l10n.save,
                onTap: _loading ? null : _update,
                child: _loading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              ),
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
    required this.selected,
    required this.onTap,
  });
  final String label;
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
