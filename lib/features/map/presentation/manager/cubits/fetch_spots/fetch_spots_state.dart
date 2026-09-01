part of 'fetch_spots_cubit.dart';

@immutable
sealed class FetchSpotsState {}

final class FetchSpotsInitial extends FetchSpotsState {}

final class FetchSpotsLoading extends FetchSpotsState {}

final class FetchSpotsSuccess extends FetchSpotsState {
  final List<SpotModel> spots;

  FetchSpotsSuccess({required this.spots});
}

final class FetchSpotsError extends FetchSpotsState {
  final String errorMessage;

  FetchSpotsError({required this.errorMessage});
}
