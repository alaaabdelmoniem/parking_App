import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/auth_cache.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/core/models/oAuth_mixin.dart';
import 'package:parking/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginRepoImple with OAuthMixin implements LoginRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<Either<Failures, User?>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        return Left(ServerFailures.fromException(Exception('User not found')));
      }

      await AuthCache.cacheUser(user, fallbackEmail: email);
      return Right(user);
    } catch (e) {
      if (e is AuthException) {
        return Left(AuthFailure.fromAuthException(exception: e));
      } else {
        log(e.toString());
        return Left(ServerFailures.fromException(e));
      }
    }
  }

  Future<Either<Failures, void>> loginWithFacebook() =>
      authWithProvider(OAuthProvider.facebook);

  @override
  Future<Either<Failures, void>> loginWithGoogle() =>
      authWithProvider(OAuthProvider.google);


}
