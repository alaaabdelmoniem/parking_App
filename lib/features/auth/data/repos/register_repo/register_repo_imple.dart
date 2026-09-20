import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/core/utils/constants.dart';
import 'package:parking/features/auth/data/repos/register_repo/register_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterRepoImple implements RegisterRepo {
  final _supabase = Supabase.instance.client;

  @override
  Future<Either<Failures, void>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      return const Right(null);
    } catch (e) {
      if (e is AuthException) {
        return Left(AuthFailure.fromAuthException(exception: e));
      } else {
        log(e.toString());
        return Left(ServerFailures.fromException(e));
      }
    }
  }

  @override
  Future<Either<Failures, void>> registerWithFacebook() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: authRedirectUrl,
      );
      return const Right(null);
    } catch (e) {
      if (e is AuthException) {
        return Left(AuthFailure.fromAuthException(exception: e));
      } else {
        log(e.toString());
        return Left(ServerFailures.fromException(e));
      }
    }
  }
}
