import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';

class UserLogOut implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  UserLogOut(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return authRepository.logOut();
  }
}
