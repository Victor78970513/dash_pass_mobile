import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> getCurrentUser();

  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential?> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> logOut();
}
