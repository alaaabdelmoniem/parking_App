part of 'update_duration_booking_cubit.dart';

@immutable
sealed class UpdateDurationBookingState {}

final class UpdateDurationBookingInitial extends UpdateDurationBookingState {}

final class UpdateDurationBookingLoading extends UpdateDurationBookingState {}

final class UpdateDurationBookingSuccess extends UpdateDurationBookingState {}

final class UpdateDurationBookingFailure extends UpdateDurationBookingState {
  final String errorMessage;

  UpdateDurationBookingFailure({required this.errorMessage});
}
