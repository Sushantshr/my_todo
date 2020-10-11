import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/models/task.dart';
import 'package:my_todo/screens/add_task_screen.dart';
import 'package:my_todo/services/task_service.dart';
import 'package:my_todo/state/task_state.dart';

class ListTask extends StatefulWidget {
  @override
  _ListTaskState createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch(taskListStreamProvider).when(
          data: (taskList) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: taskList.length > 0
                  ? taskList
                      .map<Widget>((Task task) => _buildTask(task))
                      .toList()
                  : _addNewTask(),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) {
            return InkWell(
              onTap: () => context.refresh(taskListStreamProvider),
              child: Center(
                child: Text(error.toString()),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _addNewTask() {
    return [
      Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide.none),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            "Create a new task",
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
          },
          autofocus: true,
        ),
      ),
    ];
  }

  Widget _buildTask(Task task) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide.none),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          child: Checkbox(
            value: task.isDone ?? false,
            onChanged: (value) async {
              await TaskService.updateIsDone(task.id, value);
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(DateFormat("yMd")
                  .format(DateTime.fromMillisecondsSinceEpoch(task.createdAt) ??
                      DateTime.now())
                  .toString())
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(task.description),
        ),
        trailing: InkWell(
          onTap: () => TaskService.deleteTask(task.id),
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 13.0),
//     child: Consumer(
//       builder: (context, watch, child) {
//         return watch(taskListStreamProvider).when(
//           data: (taskList) {
//             return ExpansionPanelList.radio(
//               children: taskList.map<ExpansionPanelRadio>((Task task) {
//                 return _buildTask(task);
//               }).toList(),
//             );
//           },
//           loading: () => CircularProgressIndicator(),
//           error: (error, stackTrace) {
//             return InkWell(
//               onTap: () => context.refresh(taskListStreamProvider),
//               child: Center(
//                 child: Text(error.toString()),
//               ),
//             );
//           },
//         );
//       },
//     ),
//   );
// }

// ExpansionPanel _buildTask(Task task) {
//   return ExpansionPanelRadio(
//     canTapOnHeader: true,
//     headerBuilder: (BuildContext context, bool isExpanded) {
//       return ListTile(
//         title: Text(task.title),
//         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//       );
//     },
//     body: Container(
//       child: Column(
//         children: [
//           Column(
//             children: task.todos.map(
//               (todo) {
//                 return ListTile(
//                   leading: Container(
//                     child: Checkbox(
//                       value: todo['isDone'],
//                       onChanged: (value) {
//                         setState(() {
//                           todo.isDone = value;
//                         });
//                       },
//                     ),
//                   ),
//                   title: Text(todo['title']),
//                 );
//               },
//             ).toList(),
//           ),
//           ListTile(
//             leading: Container(
//               child: Checkbox(
//                 value: false,
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//               ),
//             ),
//             title: TextField(
//               controller: _todo,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: "Type to add a new one",
//               ),
//               onSubmitted: (value) {
//                 setState(() {});

//                 Map newTodo = {'title': value, 'isDone': false};
//                 addTodo(task, newTodo);
//                 _todo.clear();
//               },
//             ),
//           )
//         ],
//       ),
//     ),
//     value: task.id,
//   );
// }
