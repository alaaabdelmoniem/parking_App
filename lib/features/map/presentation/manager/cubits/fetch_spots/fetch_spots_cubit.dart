import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/data/repos/supabase_repo/supabase_repo.dart';

part 'fetch_spots_state.dart';

class FetchSpotsCubit extends Cubit<FetchSpotsState> {
  FetchSpotsCubit({required this.supabaseRepo}) : super(FetchSpotsInitial());

  final SupabaseRepo supabaseRepo;

  Future<void> fetchSpots() async {
    var result = await supabaseRepo.fetchSpotsFromSupaBase()
      ..fold(
        (error) {
          emit(FetchSpotsError(errorMessage: error.errorMessage));
        },
        (success) {
          emit(FetchSpotsSuccess(spots: success));
        },
      );
  }
}
