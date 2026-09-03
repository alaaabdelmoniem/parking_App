import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/core/errors/supabase_handler.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/data/repos/supabase_repo/supabase_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepoImple implements SupabaseRepo {
  @override
  Future<Either<Failures, List<SpotModel>>> fetchSpotsFromSupaBase({
    required double lat,
    required double lng,
    double radiusInDegrees = 0.02,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      final data = await supabase
          .from('parking_spots')
          .select()
          .gte('lat', lat - radiusInDegrees)
          .lte('lat', lat + radiusInDegrees)
          .gte('lng', lng - radiusInDegrees)
          .lte('lng', lng + radiusInDegrees);

      final spots = data.map((json) => SpotModel.fromSupabase(json)).toList();
      return Right(spots);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure.fromPostgrestException(exception: e));
    } catch (e) {
      return Left(ServerFailures.fromException(e));
    }
  }
  // @override
  // Stream<Either<Failures, List<SpotModel>>> fetchSpotsFromSupaBase() {
  //   final _supabase = Supabase.instance.client;

  //   final controller = StreamController<Either<Failures, List<SpotModel>>>();

  //   final subscription = _supabase
  //       .from(CacheKeys.parkingSpotsTable)
  //       .stream(primaryKey: ['id'])
  //       .listen(
  //         (data) {
  //           try {
  //             final spots = data
  //                 .map((json) => SpotModel.fromSupabase(json))
  //                 .toList();
  //             controller.add(Right(spots));
  //           } catch (e) {
  //             controller.add(Left(ServerFailures.fromException(e)));
  //           }
  //         },
  //         onError: (error) {
  //           if (error is PostgrestException) {
  //             controller.add(
  //               Left(DatabaseFailure.fromPostgrestException(exception: error)),
  //             );
  //           } else {
  //             controller.add(Left(ServerFailures.fromException(error)));
  //           }
  //         },
  //         onDone: () => controller.close(),
  //       );

  //   controller.onCancel = () => subscription.cancel();

  //   return controller.stream;
  // }
}
