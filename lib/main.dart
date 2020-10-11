import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/screens/home_screen.dart';
import 'package:my_todo/screens/login_screen.dart';
import 'package:my_todo/state/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, watch) {
    final loginCheck = watch(loginCheckProvider).data?.value;

    return MaterialApp(
      title: 'My Todo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: loginCheck != null ? HomeScreen() : LoginScreen(),
    );
  }
}
