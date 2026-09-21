import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/register_repo/register_repo.dart';

part 'register_with_email_state.dart';

class RegisterWithEmailCubit extends Cubit<RegisterWithEmailState> {
  RegisterWithEmailCubit({required this.registerRepo})
    : super(RegisterWithEmailInitial());
  final RegisterRepo registerRepo;
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(RegisterWithEmailLoading());

    final result = await registerRepo.registerWithEmailAndPassword(
      email: email,
      password: password,
      fullName: fullName,
    );

    result.fold(
      (failure) {
        emit(RegisterWithEmailFailure(errorMessage: failure.errorMessage));
      },
      (_) {
        emit(RegisterWithEmailSuccess());
      },
    );
  }
}
