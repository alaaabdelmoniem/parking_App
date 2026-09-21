part of 'register_with_facebook_cubit.dart';

@immutable
sealed class RegisterWithFacebookState {}

final class RegisterWithFacebookInitial extends RegisterWithFacebookState {}
final class RegisterWithFacebookLoading extends RegisterWithFacebookState {}
 
final class RegisterWithFacebookSuccess extends RegisterWithFacebookState {}
 
final class RegisterWithFacebookFailure extends RegisterWithFacebookState {
  final String errorMessage;
  RegisterWithFacebookFailure({required this.errorMessage});
}