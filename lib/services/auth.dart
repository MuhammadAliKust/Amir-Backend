import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  ///SignUp
  Future<User> registerUser({
    required String email,
    required String pwd,
  }) async {
    UserCredential userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pwd);
    return userCred.user!;
  }

  ///Login
  Future<User> loginUser({required String email, required String pwd}) async {
    UserCredential userCred = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pwd);
    return userCred.user!;
  }

  ///Reset Password
  Future resetPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
