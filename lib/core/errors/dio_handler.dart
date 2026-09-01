
import 'package:dio/dio.dart';
import 'package:parking/core/errors/failure.dart';

class DioHandlerFailures extends Failures {
  const DioHandlerFailures({required super.errorMessage});

  factory DioHandlerFailures.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const DioHandlerFailures(
          errorMessage:
              'Connection timed out. Please check your internet and try again.',
        );

      case DioExceptionType.sendTimeout:
        return const DioHandlerFailures(
          errorMessage: 'Request took too long to send. Please try again.',
        );

      case DioExceptionType.receiveTimeout:
        return const DioHandlerFailures(
          errorMessage:
              'Server is taking too long to respond. Please try again later.',
        );

      case DioExceptionType.badCertificate:
        return const DioHandlerFailures(
          errorMessage:
              'Secure connection failed. The server certificate is invalid.',
        );

      case DioExceptionType.badResponse:
        return DioHandlerFailures.fromResponse(
          dioException.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return const DioHandlerFailures(
          errorMessage: 'Request was cancelled. Please try again.',
        );

      case DioExceptionType.connectionError:
        return const DioHandlerFailures(
          errorMessage:
              'No internet connection. Please check your network and try again.',
        );

      case DioExceptionType.unknown:
        if (dioException.error is Exception &&
            dioException.message?.contains('SocketException') == true) {
          return const DioHandlerFailures(
            errorMessage: 'No internet connection. Please check your network.',
          );
        }
        return const DioHandlerFailures(
          errorMessage: 'An unexpected error occurred. Please try again.',
        );

      // Safety net: covers any DioExceptionType values added by future
      // dio versions, so the app can't crash on a non-exhaustive switch.
      default:
        return const DioHandlerFailures(
          errorMessage: 'An unexpected error occurred. Please try again.',
        );
    }
  }

  factory DioHandlerFailures.fromResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const DioHandlerFailures(
          errorMessage:
              'Invalid request. Please check your input and try again.',
        );

      case 401:
        return const DioHandlerFailures(
          errorMessage:
              'Incorrect email or password. Please check and try again.',
        );

      case 403:
        return const DioHandlerFailures(
          errorMessage:
              "Access denied. You don't have permission to perform this action.",
        );

      case 404:
        return const DioHandlerFailures(
          errorMessage: 'The requested resource was not found.',
        );

      case 408:
        return const DioHandlerFailures(
          errorMessage: 'Request timed out. Please try again.',
        );

      case 409:
        return const DioHandlerFailures(
          errorMessage: 'A conflict occurred. The data may already exist.',
        );

      case 422:
        return const DioHandlerFailures(
          errorMessage: 'Invalid data submitted. Please check your input.',
        );

      case 429:
        return const DioHandlerFailures(
          errorMessage:
              'Too many requests. Please wait a moment and try again.',
        );

      case 500:
        return const DioHandlerFailures(
          errorMessage: 'Internal server error. Please try again later.',
        );

      case 502:
        return const DioHandlerFailures(
          errorMessage:
              'Server is temporarily unavailable. Please try again later.',
        );

      case 503:
        return const DioHandlerFailures(
          errorMessage:
              'Service is currently unavailable. Please try again later.',
        );

      case 504:
        return const DioHandlerFailures(
          errorMessage: 'Server gateway timed out. Please try again later.',
        );

      default:
        return DioHandlerFailures(
          errorMessage:
              'An unexpected error occurred (Code: $statusCode). Please try again.',
        );
    }
  }
}
