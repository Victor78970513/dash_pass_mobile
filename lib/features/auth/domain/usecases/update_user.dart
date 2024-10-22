import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';

class UpdateUser implements UseCase<bool, UpdateUserParams> {
  final AuthRepository authRepository;

  UpdateUser(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(UpdateUserParams params) {
    return authRepository.updateUser(name: params.name, uid: params.uid);
  }
}

class UpdateUserParams {
  final String name;
  final String uid;

  UpdateUserParams({required this.name, required this.uid});
}
