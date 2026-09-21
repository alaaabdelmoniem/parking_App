part of 'register_with_email_cubit.dart';

@immutable
sealed class RegisterWithEmailState {}

final class RegisterWithEmailInitial extends RegisterWithEmailState {}
final class RegisterWithEmailLoading extends RegisterWithEmailState {}
 
final class RegisterWithEmailSuccess extends RegisterWithEmailState {}
 
final class RegisterWithEmailFailure extends RegisterWithEmailState {
  final String errorMessage;
  RegisterWithEmailFailure({required this.errorMessage});
}