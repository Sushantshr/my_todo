import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/screens/add_task_screen.dart';
import 'package:my_todo/services/auth_service.dart';
import 'package:my_todo/state/auth_state.dart';
import 'package:my_todo/widgets/list_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _networkSource = 'https://source.unsplash.com/1600x900/?dark,sky';
  String _networkImage = 'https://source.unsplash.com/1600x900/?dark,sky';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final user = watch(userProvider).state;
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _networkImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 60,
                    left: 10,
                    right: 10,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: ListTask(),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: appBar(user),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
            },
            tooltip: 'Add New',
            child: Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }

  Widget appBar(user) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: FlutterLogo(
          colors: Colors.orange,
        ),
      ),
      title: Text(
        user != null
            ? user.displayName != "" ? _chopEmail(user.email) : "User's Todo"
            : "Todo",
        style: TextStyle(
          fontSize: 25,
          // color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.repeat,
          ),
          onPressed: () {
            setState(() {
              var rand = Random();
              int num = rand.nextInt(50);
              _networkImage = _networkSource + num.toString();
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
          ),
          onPressed: () {
            AuthService.logOut();
          },
        )
      ],
    );
  }

  String _chopEmail(String email) {
    return email.substring(0, email.indexOf("@"));
  }

  // Widget _topSection(user) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Container(
  //         margin: EdgeInsets.only(bottom: 15),
  //         // width: double.infinity,
  //         padding: EdgeInsets.all(20),
  //         child: Center(
  //           child: Text(
  //             user != null
  //                 ? user.displayName != "" ? user.email : "User's Todo"
  //                 : "Todo",
  //             style: TextStyle(
  //               fontSize: 25,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       ),
  //       IconButton(
  //         icon: Icon(
  //           Icons.exit_to_app,
  //           color: Colors.white,
  //         ),
  //         onPressed: () {
  //           AuthService.logOut();
  //         },
  //       ),
  //       IconButton(
  //         icon: Icon(
  //           Icons.redo,
  //           color: Colors.white,
  //         ),
  //         onPressed: () {},
  //       )
  //     ],
  //   );
  // }
}

// Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//             color: Color(0xFFF6F6F6),
//           ),
//           child: ListView(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 15,
//                 ),
//                 width: double.infinity,
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                   "This is a task",
//                   style: TextStyle(fontSize: 32),
//                 ),
//               )
//             ],
//           ),
//         ),
