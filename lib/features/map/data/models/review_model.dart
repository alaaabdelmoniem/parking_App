class ReviewDataModel {
  const ReviewDataModel({
    required this.rating,
    required this.date,
    required this.duration,
    required this.car,
    this.location,
    this.tags = const [],
  });

  final int rating;
  final String date;
  final String duration;
  final String car;
  final String? location;
  final List<String> tags;
}
