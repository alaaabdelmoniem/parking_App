import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_with_email_state.dart';

class LoginWithEmailCubit extends Cubit<LoginWithEmailState> {
  LoginWithEmailCubit({required this.loginRepo})
    : super(LoginWithEmailInitial());
  final LoginRepo loginRepo;
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginWithEmailLoading());

    final result = await loginRepo.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(LoginWithEmailFailure(errorMessage: failure.errorMessage));
      },
      (user) {
        emit(LoginWithEmailSuccess(user: user));
      },
    );
  }
}
