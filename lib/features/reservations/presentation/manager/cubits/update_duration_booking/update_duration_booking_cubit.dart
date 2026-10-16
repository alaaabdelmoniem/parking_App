import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/reservations/data/repos/reservations_repo.dart';

part 'update_duration_booking_state.dart';

class UpdateDurationBookingCubit extends Cubit<UpdateDurationBookingState> {
  UpdateDurationBookingCubit({required this.reservationsRepo})
    : super(UpdateDurationBookingInitial());
  final ReservationsRepo reservationsRepo;

  Future<void> extendBookingTime({
    required DateTime newEndTime,
    required String bookingId,
  }) async {
    emit(UpdateDurationBookingLoading());

    final bookingsResult = await reservationsRepo.updateDuarationBooking(
      newEndTime: newEndTime,
      bookingId: bookingId,
    );

    await bookingsResult.fold(
      (failure) async {
        emit(UpdateDurationBookingFailure(errorMessage: failure.errorMessage));
      },
      (bookings) async {
        emit(UpdateDurationBookingSuccess());
      },
    );
  }
}
