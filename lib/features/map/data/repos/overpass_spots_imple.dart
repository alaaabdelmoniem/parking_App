import 'dart:developer';
import 'dart:math' hide log;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:parking/core/errors/failure.dart';
import 'package:parking/features/map/data/mock/mock_spot_data.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/data/repos/overpass_spots.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;

class OverpassSpotsImple implements OverpassGetSpots {
  final _supabase = Supabase.instance.client;
  @override
  Future<Either<Failures, void>> fetchOverpassGetSpots() async {
    const lat = 38.9071929;
    const lng = -77.0368724;
    const radius = 2000; // meters

    const query =
        '[out:json];node["amenity"="parking"](around:$radius,$lat,$lng);out body;';

    const url = 'https://overpass-api.de/api/interpreter';
    // const url = 'https://overpass.kumi.systems/api/interpreter';
    // const url = 'https://overpass.openstreetmap.ru/api/interpreter';
    try {
      final response =
          await Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
            ),
          ).post(
            url,

            data: {'data': query},
            options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'User-Agent':
                    'com.example.parking_app (contact: alaaabdelmoniem5@email.com)',
                'Accept': '*/*',
              },
            ),
          );

      final List<dynamic> elements = response.data['elements'];

      final List<SpotModel> spots = elements
          .map((element) => SpotModel.fromOverpassElement(element))
          .toList();

      // fill mock data  before insert,

      final List<SpotModel> spotsToInsert = spots
          .map(_fillWithMockDataForTesting)
          .toList();

      for (var item in spotsToInsert) {
        log(
          "spots are : name is ${item.name}, address ${item.address}, capacity ${item.capacity} phone is ${item.phone}",
        );
      }
      await _supabase
          .from('parking_spots')
          .upsert(
            spotsToInsert.map((s) => s.toJson()).toList(),
            onConflict: 'osm_id',
          );

      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        return Left(ServerFailures.fromDioException(e));
      } else {
        print('Unexpected error: ${e.toString()}');
        return Left(ServerFailures(errorMessage: e.toString()));
      }
    }
  }

  SpotModel _fillWithMockDataForTesting(SpotModel spot) {
    final random = Random();

    return spot.copyWith(
      name:
          spot.name.isEmpty ||
              spot.name == 'Parking' ||
              spot.name == 'Public' ||
              spot.name.contains(r"$")
          ? getRandomParkingName()
          : spot.name,
      noteDirection: spot.noteDirection ?? getRandomDirectionNote(),
      priceForHour: spot.priceForHour ?? _randomPriceForHour(random),
      priceForDay: spot.priceForDay ?? _randomPriceForDay(random),
      rate: spot.rate ?? _randomRate(random),
      openingHours: spot.openingHours ?? getRandomOpeningHours(),
      capacityDisabled: spot.capacityDisabled ?? getRandomCapacityDisabled(),
      type: (spot.type == 'unknown') ? getRandomType() : spot.type,
      address:
          spot.address ??
          parkingAddresses[random.nextInt(parkingAddresses.length)],
      images: spot.images.isEmpty ? getRandomImages() : spot.images,
    );
  }

  double _randomPriceForHour(Random random) =>
      (random.nextInt(15) + 3).toDouble();

  double _randomPriceForDay(Random random) =>
      (random.nextInt(80) + 20).toDouble();

  double _randomRate(Random random) =>
      double.parse((random.nextDouble() * 2 + 3).toStringAsFixed(1));
}
