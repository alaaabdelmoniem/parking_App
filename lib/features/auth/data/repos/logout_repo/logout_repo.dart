import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';

abstract class LogoutRepo {
  Future<Either<Failures, void>> logout();
}
