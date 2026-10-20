import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/auth/data/repos/logout_repo/logout_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit({required this.logoutRepo}) : super(LogoutInitial());

  final LogoutRepo logoutRepo;

  Future<void> logout() async {
    if (state is LogoutLoading) return;
    emit(LogoutLoading());

    final result = await logoutRepo.logout();
    if (isClosed) return;

    result.fold(
      (failure) => emit(LogoutFailure(errorMessage: failure.errorMessage)),
      (_) => emit(LogoutSuccess()),
    );
  }
}