import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> logOut();

  Future<Either<Failure, bool>> createUser({
    required String uid,
    required String name,
    required double saldo,
    required String vehiculoId,
  });

  Future<Either<Failure, bool>> updateUser(
      {required String name, required String uid});
}
