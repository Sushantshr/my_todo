class Todo {
  int id;
  String title;
  int isDone;
  int taskId;

  Todo({this.id, this.title, this.isDone, this.taskId});
}

List<Todo> getTodo() {
  return [
    Todo(
      id: 1,
      isDone: 0,
      taskId: 1,
      title: 'test1',
    ),
    Todo(
      id: 2,
      isDone: 0,
      taskId: 1,
      title: 'test2',
    ),
    Todo(
      id: 3,
      isDone: 0,
      taskId: 2,
      title: 'test3',
    ),
  ];
}
