import 'package:dartz/dartz.dart';
import 'package:parking/core/errors/failure.dart';

abstract class OverpassGetSpots {
  Future<Either<Failures, void>> fetchOverpassGetSpots();
}
