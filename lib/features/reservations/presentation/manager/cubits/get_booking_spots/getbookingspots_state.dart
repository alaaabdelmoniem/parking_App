part of 'getbookingspots_cubit.dart';

@immutable
sealed class GetbookingspotsState {}

final class GetbookingspotsInitial extends GetbookingspotsState {}
final class GetbookingspotsLoading extends GetbookingspotsState {}
final class GetbookingspotsSuccess extends GetbookingspotsState {
  GetbookingspotsSuccess({required this.bookings, required this.spots});
 
  final List<Bookingmodel> bookings;

  final List<SpotModel?> spots;

}
final class GetbookingspotsFailure extends GetbookingspotsState {
  final String errorMessage;
  GetbookingspotsFailure({required this.errorMessage});
}