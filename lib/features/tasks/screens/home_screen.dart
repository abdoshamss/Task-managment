import 'package:flutter/material.dart';
import '../widgets/tasks_tab.dart';

class TaskFlowHomeScreen extends StatefulWidget {
  const TaskFlowHomeScreen({super.key});

  @override
  State<TaskFlowHomeScreen> createState() => _TaskFlowHomeScreenState();
}

class _TaskFlowHomeScreenState extends State<TaskFlowHomeScreen> {
  String _priorityFilter = 'all'; // all | low | medium | high

  @override
  Widget build(BuildContext context) {
    return TasksTab(
      priorityFilter: _priorityFilter,
      onFilterChanged: (v) => setState(() => _priorityFilter = v),
    );
  }
}
