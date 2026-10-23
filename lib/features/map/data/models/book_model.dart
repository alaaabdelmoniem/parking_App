import 'package:parking/features/map/data/models/spot_model.dart';

class BookModel {
  final DateTime startTime;
  final DateTime endTime;
  final double duration;
  final SpotModel spotModel;
  final double total;

  BookModel({
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.spotModel,
    this.total = 0,
  });
}
