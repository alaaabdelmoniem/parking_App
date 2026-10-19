import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/reservations/data/repos/reservations_repo.dart';

part 'getbookingspots_state.dart';

class GetbookingspotsCubit extends Cubit<GetbookingspotsState> {
  GetbookingspotsCubit({required this.reservationsRepo})
    : super(GetbookingspotsInitial());
  final ReservationsRepo reservationsRepo;

  Future<void> getBookingSpotsFromSupabase() async {
    emit(GetbookingspotsLoading());

    final bookingsResult = await reservationsRepo.getBookingSpots();
    if (isClosed) return;

    await bookingsResult.fold(
      (failure) async {
        emit(GetbookingspotsFailure(errorMessage: failure.errorMessage));
      },
      (bookings) async {
        final spotResults = await Future.wait(
          bookings.map((b) => reservationsRepo.getSpotDataFromId(id: b.spotId)),
        );

        final spots = spotResults
            .map(
              (result) => result.fold(
                (failure) => null, // spot may have been deleted - keep null
                (spot) => spot,
              ),
            )
            .toList();
        if (isClosed) return;

        emit(GetbookingspotsSuccess(bookings: bookings, spots: spots));
      },
    );
  }
}
