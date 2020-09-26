import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedIn = StateProvider<bool>((ref) => false);
final loginCheckProvider =
    StreamProvider<User>((ref) => FirebaseAuth.instance.authStateChanges());

final userProvider = StateProvider<User>((ref) {
  final user = ref.watch(loginCheckProvider).data?.value;
  return user;
});
