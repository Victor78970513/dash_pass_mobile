import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/exceptions.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:dash_pass/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    return _getUser(() async => await remoteDataSource
        .loginWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    return _getUser(() async => await remoteDataSource
        .signUpWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final res = await remoteDataSource.logOut();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createUser(
      {required String uid,
      required String name,
      required double saldo,
      required String vehiculoId}) async {
    try {
      final res = await remoteDataSource.createUser(
          uid: uid, name: name, saldo: saldo, vehiculoId: vehiculoId);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUser(
      {required String name, required String uid}) async {
    try {
      final res = await remoteDataSource.updateUser(name: name, uid: uid);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserCredential>> _getUser(
      Future<UserCredential> Function() fn) async {
    try {
      final user = await fn();

      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
