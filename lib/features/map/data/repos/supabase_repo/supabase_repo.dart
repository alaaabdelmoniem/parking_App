import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

abstract class SupabaseRepo {
  Future<Either<Failures, List<SpotModel>>> fetchSpotsFromSupaBase();
}
