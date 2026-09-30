import 'package:parking/features/map/data/models/spot_model.dart';

class BookModel {
  final DateTime startTime;
  final DateTime endTime;
  final int duration;
  final SpotModel spotModel;

  BookModel({
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.spotModel,
  });
}
