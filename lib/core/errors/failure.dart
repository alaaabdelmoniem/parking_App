import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  const Failures({required this.errorMessage});
}

class ServerFailures extends Failures {
  const ServerFailures({required super.errorMessage});

  factory ServerFailures.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailures(
          errorMessage:
              'Connection timed out. Please check your internet and try again.',
        );

      case DioExceptionType.sendTimeout:
        return const ServerFailures(
          errorMessage: 'Request took too long to send. Please try again.',
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailures(
          errorMessage:
              'Server is taking too long to respond. Please try again later.',
        );

      case DioExceptionType.badCertificate:
        return const ServerFailures(
          errorMessage:
              'Secure connection failed. The server certificate is invalid.',
        );

      case DioExceptionType.badResponse:
        return ServerFailures.fromResponse(dioException.response?.statusCode);

      case DioExceptionType.cancel:
        return const ServerFailures(
          errorMessage: 'Request was cancelled. Please try again.',
        );

      case DioExceptionType.connectionError:
        return const ServerFailures(
          errorMessage:
              'No internet connection. Please check your network and try again.',
        );

      case DioExceptionType.unknown:
        if (dioException.error is Exception &&
            dioException.message?.contains('SocketException') == true) {
          return const ServerFailures(
            errorMessage: 'No internet connection. Please check your network.',
          );
        }
        return const ServerFailures(
          errorMessage: 'An unexpected error occurred. Please try again.',
        );

      // Safety net: covers any DioExceptionType values added by future
      // dio versions, so the app can't crash on a non-exhaustive switch.
      default:
        return const ServerFailures(
          errorMessage: 'An unexpected error occurred. Please try again.',
        );
    }
  }

  factory ServerFailures.fromResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const ServerFailures(
          errorMessage:
              'Invalid request. Please check your input and try again.',
        );

      case 401:
        return const ServerFailures(
          errorMessage:
              'Incorrect email or password. Please check and try again.',
        );

      case 403:
        return const ServerFailures(
          errorMessage:
              "Access denied. You don't have permission to perform this action.",
        );

      case 404:
        return const ServerFailures(
          errorMessage: 'The requested resource was not found.',
        );

      case 408:
        return const ServerFailures(
          errorMessage: 'Request timed out. Please try again.',
        );

      case 409:
        return const ServerFailures(
          errorMessage: 'A conflict occurred. The data may already exist.',
        );

      case 422:
        return const ServerFailures(
          errorMessage: 'Invalid data submitted. Please check your input.',
        );

      case 429:
        return const ServerFailures(
          errorMessage:
              'Too many requests. Please wait a moment and try again.',
        );

      case 500:
        return const ServerFailures(
          errorMessage: 'Internal server error. Please try again later.',
        );

      case 502:
        return const ServerFailures(
          errorMessage:
              'Server is temporarily unavailable. Please try again later.',
        );

      case 503:
        return const ServerFailures(
          errorMessage:
              'Service is currently unavailable. Please try again later.',
        );

      case 504:
        return const ServerFailures(
          errorMessage: 'Server gateway timed out. Please try again later.',
        );

      default:
        return ServerFailures(
          errorMessage:
              'An unexpected error occurred (Code: $statusCode). Please try again.',
        );
    }
  }
}
