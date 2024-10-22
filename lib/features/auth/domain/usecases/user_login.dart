import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLogin implements UseCase<UserCredential, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, UserCredential>> call(UserLoginParams params) {
    return authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
