part of 'login_with_email_cubit.dart';

@immutable
sealed class LoginWithEmailState {}

final class LoginWithEmailInitial extends LoginWithEmailState {}

final class LoginWithEmailLoading extends LoginWithEmailState {}

final class LoginWithEmailSuccess extends LoginWithEmailState {
  final User? user;
  LoginWithEmailSuccess({required this.user});
}

final class LoginWithEmailFailure extends LoginWithEmailState {
  final String errorMessage;
  LoginWithEmailFailure({required this.errorMessage});
}
