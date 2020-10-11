import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  bool isDone = false;
  String userId;
  int createdAt = new DateTime.now().millisecondsSinceEpoch;
  int updatedAt;
  Task(
      {this.id,
      this.title,
      this.description,
      isDone = false,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Task.fromJson(QueryDocumentSnapshot queryDocumentSnapshot) {
    var data = queryDocumentSnapshot.data();
    this.title = data['title'];
    this.isDone = data['isDone'] ?? false;
    this.description = data['description'];
    this.userId = data['user_id'];
    this.createdAt = data['created_at'];
    this.updatedAt = data['updated_at'];
    this.id = queryDocumentSnapshot.id;
  }
}

// List<Task> getTask() {
//   return [
//     Task(
//       id: 1,
//       title: 'Task 1',
//       todos: [
//         Todo(
//           id: 1,
//           taskId: 1,
//           title: 'todo 1',
//         )
//       ],
//     ),
//     Task(id: 2, title: 'Task 2', todos: []),
//     Task(id: 3, title: 'Task 3', todos: []),
//   ];
// }
