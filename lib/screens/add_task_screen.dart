import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/models/task.dart';
import 'package:my_todo/state/task_state.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Task task;
  @override
  void initState() {
    super.initState();
    task = Task();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Add New Task"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://source.unsplash.com/1600x900/?dark,moon,space',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                TextFormField(
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  onSaved: (value) {
                    task.title = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a task";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "What are you doing??",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  onSaved: (value) {
                    task.description = value;
                  },
                  decoration: InputDecoration(
                    hintText: "And ...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Consumer(
                    builder: (context, watch, child) {
                      bool isLoading = watch(addTaskProvider).isLoading;
                      return isLoading
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: this.addTask,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Add To List",
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addTask() async {
    try {
      bool validated = _formKey.currentState.validate();
      if (validated) {
        _formKey.currentState.save();
        var addProvider = context.read(addTaskProvider);
        await addProvider.addTask(this.task);

        Navigator.pop(context);
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
