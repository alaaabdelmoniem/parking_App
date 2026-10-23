import 'package:dartz/dartz.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/reservations/data/repos/reservations_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationsRepoImple implements ReservationsRepo {
  @override
  Future<Either<Failures, List<Bookingmodel>>> getBookingSpots() async {
    final supabase = Supabase.instance.client;

    final userId = CacheHelper.getValue(key: CacheKeys.uId);
    if (userId == null) {
      return Left(
        AuthFailure(
          errorMessage: 'You must be logged in to view your reservations.',
        ),
      );
    }

    try {
      final data = await supabase
          .from(CacheKeys.bookingTable)
          .select()
          .eq('user_id', userId)
          .order('start_time', ascending: false);

      final bookings = (data as List)
          .map((json) => Bookingmodel.fromJson(json as Map<String, dynamic>))
          .toList();
      print("real uid: $userId");

      return Right(bookings);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure.fromPostgrestException(exception: e));
    } catch (e) {
      return Left(ServerFailures.fromException(e));
    }
  }

  @override
  @override
  Future<Either<Failures, SpotModel>> getSpotDataFromId({String? id}) async {
    if (id == null || id.isEmpty) {
      return Left(ServerFailures(errorMessage: 'Spot id is missing.'));
    }

    final supabase = Supabase.instance.client;

    try {
      final data = await supabase
          .from(CacheKeys.parkingSpotsTable)
          .select()
          .eq('id', id)
          .single();

      final spot = SpotModel.fromSupabase(data);
      return Right(spot);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure.fromPostgrestException(exception: e));
    } catch (e) {
      return Left(ServerFailures.fromException(e));
    }
  }

  @override
  @override
  Future<Either<Failures, void>> updateDuarationBooking({
    required String bookingId,
    required DateTime newEndTime,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase
          .from(CacheKeys.bookingTable)
          .update({'end_time': newEndTime.toUtc().toIso8601String()})
          .eq('id', bookingId);

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure.fromPostgrestException(exception: e));
    } catch (e) {
      return Left(ServerFailures.fromException(e));
    }
  }
}
