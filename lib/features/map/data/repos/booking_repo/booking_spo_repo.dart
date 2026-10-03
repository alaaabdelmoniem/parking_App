import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/features/map/data/models/booking_model.dart';

abstract class BookingSpoRepo {
  Future<Either<Failures, void>> createBooking(BookingModel booking);
}
