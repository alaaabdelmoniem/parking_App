import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

abstract class ReservationsRepo {
  Future<Either<Failures, List<Bookingmodel>>> getBookingSpots();
  Future<Either<Failures, SpotModel>> getSpotDataFromId({String? id});
  Future<Either<Failures, void>> updateDuarationBooking({
    required DateTime newEndTime,
    required String bookingId,
  });
}
