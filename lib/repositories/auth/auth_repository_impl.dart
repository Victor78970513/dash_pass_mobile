import 'package:dash_pass/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth authdb = FirebaseAuth.instance;

  AuthRepositoryImpl(this.authdb);

  @override
  Future<User?> getCurrentUser() async {
    try {
      return authdb.currentUser;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserCredential?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await authdb.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) return response;
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authdb.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) return response;
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
