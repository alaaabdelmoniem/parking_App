import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/auth_cache.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/core/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin OAuthMixin {
  SupabaseClient get supabase;

  Failures mapAuthError(Object e) {
    if (e is AuthException) {
      return AuthFailure.fromAuthException(exception: e);
    }
    log(e.toString());
    return ServerFailures.fromException(e);
  }

  Future<Either<Failures, void>> authWithProvider(
    OAuthProvider provider,
  ) async {
    try {
      // Opens the browser. This returns right away, NOT when the user is signed in.
      final launched = await supabase.auth.signInWithOAuth(
        provider,
        redirectTo: authRedirectUrl,
      );
      if (!launched) {
        return Left(
          ServerFailures.fromException(
            Exception('Could not open the sign-in page'),
          ),
        );
      }

      // Wait (once) for the deep link to bring the user back and sign them in.
      // firstWhere cancels its own subscription after the first match.
      final state = await supabase.auth.onAuthStateChange
          .firstWhere(
            (state) => state.event == AuthChangeEvent.signedIn && state.session != null,
          )
          .timeout(const Duration(minutes: 2));

      await AuthCache.cacheUser(state.session!.user);
      return const Right(null);
    } catch (e) {
      return Left(mapAuthError(e));
    }
  }
}
