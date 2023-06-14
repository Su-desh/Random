import 'package:firebase_auth/firebase_auth.dart';
import 'package:random/API/api.dart';

class AuthService {
  //sign out user
  static Future<void> signOutThisUser() async {
    await APIs.firebaseAuth.signOut();
  }

  //register new user
  static Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await APIs.firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

//login
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await APIs.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // return 'No user found for that email.';
        return 'This username does not exist';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
