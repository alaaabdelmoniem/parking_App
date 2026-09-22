import 'package:parking/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseFailure extends Failures {
  DatabaseFailure({required super.errorMessage});

  factory DatabaseFailure.fromPostgrestException({
    required PostgrestException exception,
  }) {
    switch (exception.code) {
      case '23505':
        return DatabaseFailure(errorMessage: 'This record already exists.');
      case '23503':
        return DatabaseFailure(
          errorMessage: 'This action references data that does not exist.',
        );
      case '23502':
        return DatabaseFailure(errorMessage: 'A required field is missing.');
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
          errorMessage:
              'Could not connect to the server. Check your internet connection.',
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

class AuthFailure extends Failures {
  AuthFailure({required super.errorMessage});

  factory AuthFailure.fromAuthException({required AuthException exception}) {
    switch (exception.code) {
      // --- Login errors ---
      case 'invalid_credentials':
        return AuthFailure(errorMessage: 'Incorrect email or password.');

      case 'email_not_confirmed':
        return AuthFailure(
          errorMessage: 'Please confirm your email before logging in.',
        );

      case 'user_not_found':
        return AuthFailure(errorMessage: 'No account found with this email.');

      // --- Registration errors ---
      case 'user_already_exists':
      case 'email_exists':
        return AuthFailure(errorMessage: 'This email is already registered.');

      case 'weak_password':
        return AuthFailure(
          errorMessage: 'Password is too weak. Use at least 6 characters.',
        );

      case 'signup_disabled':
        return AuthFailure(errorMessage: 'Sign-ups are currently disabled.');

      case 'same_password':
        return AuthFailure(
          errorMessage: 'New password must be different from the old one.',
        );

      // --- Rate limiting ---
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
        return AuthFailure(
          errorMessage: 'Too many attempts. Please try again later.',
        );

      // --- OAuth / provider errors ---
      case 'provider_disabled':
        return AuthFailure(
          errorMessage: 'This sign-in method is currently unavailable.',
        );

      case 'provider_email_needs_verification':
        return AuthFailure(
          errorMessage: 'Please verify your email to continue.',
        );

      case 'bad_oauth_callback':
      case 'bad_oauth_state':
        return AuthFailure(
          errorMessage:
              'Something went wrong during sign-in. Please try again.',
        );

      // --- Session / token errors ---
      case 'bad_jwt':
      case 'session_expired':
        return AuthFailure(
          errorMessage: 'Your session has expired. Please log in again.',
        );

      case 'reauthentication_needed':
        return AuthFailure(errorMessage: 'Please log in again to continue.');

      // --- Validation ---
      case 'validation_failed':
        return AuthFailure(
          errorMessage: 'Please check your input and try again.',
        );

      case 'email_address_invalid':
        return AuthFailure(errorMessage: 'Please enter a valid email address.');

      default:
        return AuthFailure(
          errorMessage: exception.message.isNotEmpty
              ? exception.message
              : 'An unknown authentication error occurred.',
        );
    }
  }
}

class ServerFailures extends Failures {
  ServerFailures({required super.errorMessage});

  factory ServerFailures.fromException(Object exception) {
    return ServerFailures(errorMessage: exception.toString());
  }
}
