import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/repos/booking_repo/booking_spo_repo.dart';

part 'book_spot_state.dart';

class BookSpotCubit extends Cubit<BookSpotState> {
  BookSpotCubit({required this.bookingSpotRepo}) : super(BookSpotInitial());
  final BookingSpoRepo bookingSpotRepo;

  Future<void> bookSpot({required Bookmodel booking}) async {
    emit(BookSpotLoading());
    final result = await bookingSpotRepo.createBooking(booking);
    result.fold(
      (message) {
        emit(BookSpotFailure(errorMessage: message.errorMessage));
      },
      (succes) {
        emit(BookSpotSuccess());
      },
    );
  }
}
