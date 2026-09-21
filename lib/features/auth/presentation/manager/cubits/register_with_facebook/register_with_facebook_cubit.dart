import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/register_repo/register_repo.dart';

part 'register_with_facebook_state.dart';

class RegisterWithFacebookCubit extends Cubit<RegisterWithFacebookState> {
  RegisterWithFacebookCubit({required this.registerRepo}) : super(RegisterWithFacebookInitial());
    final RegisterRepo registerRepo;
    Future<void> registerWithFacebook() async {
    emit(RegisterWithFacebookLoading());
 
    final result = await registerRepo.registerWithFacebook();
 
    result.fold(
      (failure) {
        emit(RegisterWithFacebookFailure(errorMessage: failure.errorMessage));
      },
      (_) {
        emit(RegisterWithFacebookSuccess());
      },
    );
  }
}
