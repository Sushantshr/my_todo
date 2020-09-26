class Task {
  int id;
  String title;

  Task({this.id, this.title});
}

List<Task> getTask() {
  return [
    Task(
      id: 1,
      title: 'Task 1',
    ),
    Task(
      id: 2,
      title: 'Task 2',
    ),
    Task(
      id: 3,
      title: 'Task 3',
    ),
  ];
}
