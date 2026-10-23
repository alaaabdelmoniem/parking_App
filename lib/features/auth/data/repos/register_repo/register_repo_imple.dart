import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/auth_cache.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/core/models/oAuth_mixin.dart';
import 'package:parking/features/auth/data/repos/register_repo/register_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterRepoImple with OAuthMixin implements RegisterRepo {
  @override
  final supabase = Supabase.instance.client;

  @override
  Future<Either<Failures, void>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {CacheKeys.usernameFieldInSupabase: userName},
      );

      final user = response.user;
      if (user == null) {
        return Left(ServerFailures.fromException(Exception('Sign up failed')));
      }

      if (user.identities?.isEmpty ?? false) {
        return Left(
          AuthFailure.fromAuthException(
            exception: const AuthException(
              'User already registered',
              code: 'user_already_exists',
            ),
          ),
        );
      }
      if (response.session != null) {
        await AuthCache.cacheUser(user, fallbackEmail: email);
      }

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
  Future<Either<Failures, void>> registerWithFacebook() =>
      authWithProvider(OAuthProvider.google);

  @override
  Future<Either<Failures, void>> registerWithGoogle() =>
      authWithProvider(OAuthProvider.facebook);
}
