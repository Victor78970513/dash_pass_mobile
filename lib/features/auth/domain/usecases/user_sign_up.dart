import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSignUp implements UseCase<UserCredential, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, UserCredential>> call(UserSignUpParams params) {
    return authRepository.signUpWithEmailAndPassword(
        email: params.email, password: params.passowrd);
  }
}

class UserSignUpParams {
  final String email;
  final String passowrd;

  UserSignUpParams({required this.email, required this.passowrd});
}
