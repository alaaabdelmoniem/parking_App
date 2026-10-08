class Bookmodel {
  final String? id;
  final String userId;
  final String spotId;
  final String spotName;
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;
  final double? pricePerHour;
  final double totalPrice;
  final String status;
  final String? paymentMethod;
  final String paymentStatus;

  const Bookmodel({
    this.id,
    required this.userId,
    required this.spotId,
    required this.spotName,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    this.pricePerHour,
    required this.totalPrice,
    this.status = 'upcoming',
    this.paymentMethod,
    this.paymentStatus = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'spot_id': spotId,
      'spot_name': spotName,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'duration_minutes': durationMinutes,
      'price_per_hour': pricePerHour,
      'total_price': totalPrice,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
    };
  }

  factory Bookmodel.fromJson(Map<String, dynamic> json) {
    return Bookmodel(
      id: json['id'],
      userId: json['user_id'],
      spotId: json['spot_id'],
      spotName: json['spot_name'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      durationMinutes: json['duration_minutes'],
      pricePerHour: (json['price_per_hour'] as num?)?.toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'] ?? 'upcoming',
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'] ?? 'pending',
    );
  }
}
