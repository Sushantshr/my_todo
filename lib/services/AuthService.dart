import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static loginWithEmail({String email, String password}) async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return res.user;
    } catch (error) {
      print(error.message);
    }
  }

  static Future<User> signInWithGoogle() async {
    try {
      GoogleSignIn gs = GoogleSignIn();
      final googleUser = await gs.signIn();
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final resp = await _auth.signInWithCredential(credential);

      return resp.user;
    } catch (error) {
      print(error.message);
      return null;
    }
  }

  static logOut() {
    try {
      _auth.signOut();
      return true;
    } catch (error) {
      print(error.message);
    }
  }
}
