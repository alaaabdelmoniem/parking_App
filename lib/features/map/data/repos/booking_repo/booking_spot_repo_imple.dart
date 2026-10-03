import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/repos/booking_repo/booking_spo_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingSpotRepoImple implements BookingSpoRepo {
  @override
  Future<Either<Failures, void>> createBooking(BookingModel booking) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        return Left(
          AuthFailure(errorMessage: 'You must be logged in to book.'),
        );
      }

      await Supabase.instance.client
          .from(CacheKeys.bookingTable)
          .insert(booking.toJson());

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure.fromPostgrestException(exception: e));
    } catch (e) {
      return Left(ServerFailures.fromException(e));
    }
  }
}
