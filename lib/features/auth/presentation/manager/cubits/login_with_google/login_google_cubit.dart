import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/login_repo/login_repo.dart';

part 'login_google_state.dart';

class LoginGoogleCubit extends Cubit<LoginGoogleState> {
  LoginGoogleCubit({required this.loginRepo}) : super(LoginGoogleInitial());
    final LoginRepo loginRepo;

  Future<void> loginWithGoogle() async {
    emit(LoginWithGoogleLoading());
 
    final result = await loginRepo.loginWithGoogle();
 
    result.fold(
      (failure) {
        emit(LoginWithGoogleFailure(errorMessage: failure.errorMessage));
      },
      (_) {
        emit(LoginWithGoogleSuccess());
      },
    );
  }
}
