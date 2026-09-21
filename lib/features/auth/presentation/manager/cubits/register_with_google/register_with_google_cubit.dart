import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/register_repo/register_repo.dart';

part 'register_with_google_state.dart';

class RegisterWithGoogleCubit extends Cubit<RegisterWithGoogleState> {
  RegisterWithGoogleCubit({required this.registerRepo}) : super(RegisterWithGoogleInitial());
    final RegisterRepo registerRepo;
    Future<void> registerWithGoogle() async {
    emit(RegisterWithGoogleLoading());
 
    final result = await registerRepo.registerWithGoogle();
 
    result.fold(
      (failure) {
        emit(RegisterWithGoogleFailure(errorMessage: failure.errorMessage));
      },
      (_) {
        emit(RegisterWithGoogleSuccess());
      },
    );
  }
}
