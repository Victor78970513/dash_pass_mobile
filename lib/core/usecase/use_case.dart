import 'package:dartz/dartz.dart';
import 'package:dash_pass/core/error/failures.dart';

abstract interface class UseCase<SucessType, Params> {
  Future<Either<Failure, SucessType>> call(Params params);
}

class NoParams {}
