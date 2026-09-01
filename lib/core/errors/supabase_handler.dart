import 'package:parking/core/errors/failure.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles errors coming from Supabase's database layer (Postgrest),
/// e.g. select/insert/update/delete/upsert/realtime stream failures.
class DatabaseFailure extends Failures {
  DatabaseFailure({required super.errorMessage});

  factory DatabaseFailure.fromPostgrestException({
    required PostgrestException exception,
  }) {
    switch (exception.code) {
      case '23505':
        return DatabaseFailure(
          errorMessage: 'This record already exists.',
        );
      case '23503':
        return DatabaseFailure(
          errorMessage: 'This action references data that does not exist.',
        );
      case '23502':
        return DatabaseFailure(
          errorMessage: 'A required field is missing.',
        );
      case '42501':
        return DatabaseFailure(
          errorMessage: 'You do not have permission to perform this action.',
        );
      case 'PGRST116':
        return DatabaseFailure(
          errorMessage: 'The requested item was not found.',
        );
      case '08006':
      case '08001':
        return DatabaseFailure(
          errorMessage: 'Could not connect to the server. Check your internet connection.',
        );
      default:
        return DatabaseFailure(
          errorMessage: exception.message.isNotEmpty
              ? exception.message
              : 'An unknown database error occurred.',
        );
    }
  }
}

/// Handles errors coming from Supabase Auth (if/when you add authentication).
class AuthFailure extends Failures {
  AuthFailure({required super.errorMessage});

  factory AuthFailure.fromAuthException({
    required AuthException exception,
  }) {
    switch (exception.statusCode) {
      case '400':
        return AuthFailure(errorMessage: 'Invalid email or password.');
      case '422':
        return AuthFailure(errorMessage: 'This email is already in use.');
      case '429':
        return AuthFailure(
          errorMessage: 'Too many attempts. Please try again later.',
        );
      default:
        return AuthFailure(
          errorMessage: exception.message.isNotEmpty
              ? exception.message
              : 'An unknown authentication error occurred.',
        );
    }
  }
}

/// Generic fallback for any non-Supabase-specific error
/// (e.g. network failures, unexpected exceptions, parsing errors).
class ServerFailures extends Failures {
  ServerFailures({required super.errorMessage});

  factory ServerFailures.fromException(Object exception) {
    return ServerFailures(errorMessage: exception.toString());
  }
}