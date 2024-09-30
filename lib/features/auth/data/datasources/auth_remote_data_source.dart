import 'package:dash_pass/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password});
  //
  Future<String> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<bool> logOut();
}

class AuthRemoteSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (response.user == null) throw ServerExceptions("USER IS NULL");
      return response.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(e.toString());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (response.user == null) throw ServerExceptions("USER IS NULL");
      return response.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(e.toString());
    } catch (e) {
      throw ServerExceptions(e.toString());
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
