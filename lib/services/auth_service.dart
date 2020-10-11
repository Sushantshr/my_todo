import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  static Future<User> signInWithFacebook() async {
    print("facebook sign in");
    // Trigger the sign-in flow
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);

      // Once signed in, return the UserCredential
      final resp = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      print(resp.user);
      return resp.user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  static logOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (error) {
      print(error.message);
    }
  }
}
