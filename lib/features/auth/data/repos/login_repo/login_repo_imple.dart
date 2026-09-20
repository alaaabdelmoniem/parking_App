import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/core/utils/constants.dart';
import 'package:parking/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginRepoImple implements LoginRepo {
  final _supabase = Supabase.instance.client;

  @override
  Future<Either<Failures, User?>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      await CacheHelper.setValue(
        key: CacheKeys.uId,
        value: response.user?.id ?? '',
      );

      return Right(response.user);
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
  Future<Either<Failures, void>> loginWithFacebook() async {
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
