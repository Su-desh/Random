import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
  //sign out user
  Future<void> signOutThisUser() async {
    await FirebaseAuth.instance.signOut();
  }

  //register new user
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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

// var usersReference = firestoreDB.collection('users');

// //create the account for the new user
//   createTheAccountForNewUser(
//       {required String username, required String password}) async {
//     try {
//       var newAccountVar = await usersReference
//           .add({'username': username, 'password': password});
//     } catch (e) {
//       // ignore: avoid_print
//       print('this is the catch error $e');
//     }
//   }
