import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_todo/models/task.dart';

class TaskService {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static Future<DocumentReference> addTask(Task task) {
    CollectionReference _taskCollection =
        _firebaseFirestore.collection('tasks');

    var data = {
      'title': task.title,
      'description': task.description ?? null,
      'user_id': task.userId,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch
    };

    return _taskCollection.add(data);
  }

  static Future<void> updateIsDone(String id, bool isDone) {
    DocumentReference _taskCollection =
        _firebaseFirestore.collection('tasks').doc(id);

    return _taskCollection.update({
      'isDone': isDone,
      'updated_at': DateTime.now().millisecondsSinceEpoch
    });
  }

  static Future<void> deleteTask(id) {
    DocumentReference _taskDocument =
        _firebaseFirestore.collection('tasks').doc(id);

    return _taskDocument.delete();
  }

  static Stream<List<Task>> getTasksStream(String id) {
    CollectionReference _taskCollection =
        _firebaseFirestore.collection('tasks');

    return _taskCollection
        .where('user_id', isEqualTo: id)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs.map(
            (e) {
              return Task.fromJson(e);
            },
          ).toList(),
        );
  }
}
