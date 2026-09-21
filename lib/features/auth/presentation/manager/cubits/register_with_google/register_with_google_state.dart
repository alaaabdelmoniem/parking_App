part of 'register_with_google_cubit.dart';

@immutable
sealed class RegisterWithGoogleState {}

final class RegisterWithGoogleInitial extends RegisterWithGoogleState {}
final class RegisterWithGoogleLoading extends RegisterWithGoogleState {}
 
final class RegisterWithGoogleSuccess extends RegisterWithGoogleState {}
 
final class RegisterWithGoogleFailure extends RegisterWithGoogleState {
  final String errorMessage;
  RegisterWithGoogleFailure({required this.errorMessage});
}