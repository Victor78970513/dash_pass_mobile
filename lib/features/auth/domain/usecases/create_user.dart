import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';
import 'package:dash_pass/core/usecase/use_case.dart';
import 'package:dash_pass/features/auth/domain/repository/auth_repository.dart';

class CreateUser implements UseCase<bool, CreateUserParams> {
  final AuthRepository authRepository;

  CreateUser(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(CreateUserParams params) async {
    return await authRepository.createUser(
      uid: params.name,
      name: params.name,
      saldo: params.saldo,
      vehiculoId: params.vehiculoId,
    );
  }
}

class CreateUserParams {
  final String uid;
  final String name;
  final double saldo;
  final String vehiculoId;

  CreateUserParams({
    required this.uid,
    required this.name,
    required this.saldo,
    required this.vehiculoId,
  });
}
