import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';

abstract class RegisterRepo {

  Future<Either<Failures, void>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });

  Future<Either<Failures, void>> registerWithFacebook();
}
