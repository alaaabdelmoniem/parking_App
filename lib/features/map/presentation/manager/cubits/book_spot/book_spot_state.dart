part of 'book_spot_cubit.dart';

@immutable
sealed class BookSpotState {}

final class BookSpotInitial extends BookSpotState {}

final class BookSpotLoading extends BookSpotState {}

final class BookSpotSuccess extends BookSpotState {

}

final class BookSpotFailure extends BookSpotState {
  final String errorMessage;
  BookSpotFailure({required this.errorMessage});
}
