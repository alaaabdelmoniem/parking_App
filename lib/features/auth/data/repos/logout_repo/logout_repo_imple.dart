import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/auth_cache.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/features/auth/data/repos/logout_repo/logout_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogoutRepoImple implements LogoutRepo {
  final _client = Supabase.instance.client;

  @override
  Future<Either<Failures, void>> logout() async {
    try {
      await _client.auth.signOut();
      AuthCache.removeUser();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailures(errorMessage: e.toString()));
    }
  }
}
