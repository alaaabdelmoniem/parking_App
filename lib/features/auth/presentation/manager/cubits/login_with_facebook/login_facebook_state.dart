part of 'login_facebook_cubit.dart';

@immutable
sealed class LoginFacebookState {}

final class LoginFacebookInitial extends LoginFacebookState {}

final class LoginWithFacebookLoading extends LoginFacebookState {}

final class LoginWithFacebookSuccess extends LoginFacebookState {}

final class LoginWithFacebookFailure extends LoginFacebookState {
  final String errorMessage;
  LoginWithFacebookFailure({required this.errorMessage});
}
