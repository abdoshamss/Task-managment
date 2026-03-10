import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/app_strings.dart';
import '../models/task_model.dart';

/// Task CRUD and stream using Firestore: users/{userId}/tasks
class TaskProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;
  CollectionReference<Map<String, dynamic>>? get _tasksCol {
    final uid = _userId;
    if (uid == null) return null;
    return FirebaseFirestore.instance
        .collection(AppStrings.usersCollection)
        .doc(uid)
        .collection(AppStrings.tasksSubcollection);
  }

  /// Real-time stream of all tasks (pending first, then by due date).
  Stream<List<TaskModel>> getTasksStream() {
    final col = _tasksCol;
    if (col == null) return Stream.value([]);
    return col.orderBy('dueDate').snapshots().map((snap) {
      final list = snap.docs
          .map((d) => TaskModel.fromMap(d.id, d.data()))
          .toList();
      list.sort((a, b) {
        if (a.isCompleted != b.isCompleted) return a.isCompleted ? 1 : -1;
        return a.dueDate.compareTo(b.dueDate);
      });
      return list;
    });
  }

  /// Stream of completed tasks only.
  Stream<List<TaskModel>> getCompletedTasksStream() {
    final col = _tasksCol;
    if (col == null) return Stream.value([]);
    return col
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => TaskModel.fromMap(d.id, d.data())).toList(),
        );
  }

  Future<void> addTask({
    required String title,
    String? description,
    required DateTime dueDate,
    required String priority,
  }) async {
    final col = _tasksCol;
    if (col == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      final id = col.doc().id;
      await col.doc(id).set({
        'id': id,
        'title': title,
        'description': description ?? '',
        'dueDate': Timestamp.fromDate(dueDate),
        'priority': priority,
        'isCompleted': false,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(TaskModel task) async {
    final col = _tasksCol;
    if (col == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      await col.doc(task.id).update({
        'title': task.title,
        'description': task.description ?? '',
        'dueDate': Timestamp.fromDate(task.dueDate),
        'priority': task.priority,
        'isCompleted': task.isCompleted,
        'updatedAt': Timestamp.fromDate(now),
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    final col = _tasksCol;
    if (col == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      await col.doc(id).delete();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleComplete(String id, bool isCompleted) async {
    final col = _tasksCol;
    if (col == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      await col.doc(id).update({
        'isCompleted': isCompleted,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
