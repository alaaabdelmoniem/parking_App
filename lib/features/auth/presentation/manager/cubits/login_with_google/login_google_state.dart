part of 'login_google_cubit.dart';

@immutable
sealed class LoginGoogleState {}

final class LoginGoogleInitial extends LoginGoogleState {}
final class LoginWithGoogleLoading extends LoginGoogleState {}
 
final class LoginWithGoogleSuccess extends LoginGoogleState {}
 
final class LoginWithGoogleFailure extends LoginGoogleState {
  final String errorMessage;
  LoginWithGoogleFailure({required this.errorMessage});
}


