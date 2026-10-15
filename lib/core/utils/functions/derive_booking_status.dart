import 'package:parking/features/map/data/models/booking_model.dart';
import '../reservation_card_status.dart';

ReservationCardStatus deriveBookingStatus(Bookingmodel booking) {
  final now = DateTime.now();
  if (booking.status == 'cancelled') return ReservationCardStatus.completed; // or a cancelled variant
  if (now.isAfter(booking.endTime)) return ReservationCardStatus.completed;
  if (now.isAfter(booking.startTime)) return ReservationCardStatus.active;
  return ReservationCardStatus.upcoming;
}