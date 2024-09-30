import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> logOut();
}
