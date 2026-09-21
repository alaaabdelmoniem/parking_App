import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/login_repo/login_repo.dart';

part 'login_facebook_state.dart';

class LoginFacebookCubit extends Cubit<LoginFacebookState> {
  LoginFacebookCubit({required this.loginRepo}) : super(LoginFacebookInitial());
    final LoginRepo loginRepo;

  Future<void> loginWithFacebook() async {
    emit(LoginWithFacebookLoading());
 
    final result = await loginRepo.loginWithFacebook();
 
    result.fold(
      (failure) {
        emit(LoginWithFacebookFailure(errorMessage: failure.errorMessage));
      },
      (_) {
        emit(LoginWithFacebookSuccess());
      },
    );
  }
}
