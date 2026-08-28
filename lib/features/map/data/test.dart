import 'dart:developer';
import 'package:dio/dio.dart';

class Test {
  Future<void> fetchSpots() async {
    const lat = 51.5074;
    const lng = -0.1278;

    const radius = 2000; // meters

    const query =
        '[out:json];node["amenity"="parking"](around:$radius,$lat,$lng);out body;';

    const url = 'https://overpass-api.de/api/interpreter';
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
                    'com.example.parking_app (contact: you@email.com)',
              },
            ),
          );
      final List<dynamic> elements = response.data['elements'];
      for (var element in elements) {
        log('Elemetns are : ${element}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
