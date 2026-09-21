import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRepo {
  Future<Either<Failures, User?>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failures, void>> loginWithFacebook();
  Future<Either<Failures, void>> loginWithGoogle();
}
