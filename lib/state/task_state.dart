import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/models/task.dart';
import 'package:my_todo/services/task_service.dart';
import 'package:my_todo/state/auth_state.dart';

final taskListStreamProvider = StreamProvider<List<Task>>((ref) {
  final user = ref.watch(loginCheckProvider).data?.value;
  if (user != null) {
    return TaskService.getTasksStream(user.uid);
  }
  return null;
});

final addTaskProvider =
    ChangeNotifierProvider<AddTaskNotifier>((ref) => AddTaskNotifier(ref));

class AddTaskNotifier extends ChangeNotifier {
  bool isLoading = false;
  String error;
  ProviderReference ref;

  AddTaskNotifier(this.ref);

  addTask(Task task) async {
    try {
      this.isLoading = true;
      notifyListeners();

      final user = ref.watch(loginCheckProvider).data?.value;
      task.userId = user.uid;
      task.isDone = false;

      await TaskService.addTask(task);
    } catch (err) {
      error = err.toString();
      print(error);
    } finally {
      this.isLoading = false;
      notifyListeners();
    }
  }
}
