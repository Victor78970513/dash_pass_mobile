import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password});
  //
  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<bool> logOut();

  Future<bool> createUser({
    required String uid,
    required String name,
    required double saldo,
    required String vehiculoId,
  });

  Future<bool> updateUser({required String name, required String uid});
}

class AuthRemoteSourceImpl implements AuthRemoteDataSource {
  FirebaseFirestore usersDb = FirebaseFirestore.instance;
  @override
  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (response.user == null) throw ServerExceptions("USER IS NULL");
      return response;
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(e.toString());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (response.user == null) throw ServerExceptions("USER IS NULL");
      return response;
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

  @override
  Future<bool> createUser({
    required String uid,
    required String name,
    required double saldo,
    required String vehiculoId,
  }) async {
    CollectionReference users = usersDb.collection("usuarios");
    // DocumentSnapshot user
    try {
      await users.doc(uid).set({
        "nombre": name,
        "saldo": saldo,
        "vehiculoId": vehiculoId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateUser({required String name, required String uid}) async {
    try {
      Map<String, dynamic> userData = {
        'nombre': name,
      };
      await usersDb.collection("usuarios").doc(uid).update(userData);
      return true;
    } catch (e) {
      return false;
    }
  }
}
