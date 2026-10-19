import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/data/repos/overpass_repo/overpass_spots_imple.dart';
import 'package:parking/features/map/data/repos/supabase_repo/supabase_repo.dart';

part 'fetch_spots_state.dart';

class FetchSpotsCubit extends Cubit<FetchSpotsState> {
  FetchSpotsCubit({required this.supabaseRepo, required this.overpassRepo})
    : super(FetchSpotsInitial());

  final SupabaseRepo supabaseRepo;
  final OverpassSpotsImple overpassRepo;

  String _cellKey(double lat, double lng) =>
      'synced_${lat.toStringAsFixed(2)},${lng.toStringAsFixed(2)}';

  bool _wasSyncedRecently(String key) {
    final ts = CacheHelper.getValue(key: key) as int?; // millis since epoch
    if (ts == null) return false;
    final age = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(ts),
    );
    return age < const Duration(days: 7); // re-check an empty area after a week
  }

  Future<void> _markSynced(String key) async => CacheHelper.setValue(
    key: key,
    value: DateTime.now().millisecondsSinceEpoch,
  );

  Future<void> fetchSpots({required double lat, required double lng}) async {
    // 1) Fast path: read what Supabase already has for this area.
    final cached = await supabaseRepo.fetchSpotsFromSupaBase(
      lat: lat,
      lng: lng,
    );
    if (isClosed) return;

    // A Supabase error is shown as an error, we don't fall through to Overpass.
    final cachedError = cached.fold<String?>(
      (f) => f.errorMessage,
      (_) => null,
    );
    if (cachedError != null) {
      emit(FetchSpotsError(errorMessage: cachedError));
      return;
    }

    final cachedSpots = cached.getOrElse(() => <SpotModel>[]);
    if (cachedSpots.isNotEmpty) {
      emit(FetchSpotsSuccess(spots: cachedSpots));
      return; // data exists, no Overpass call
    }

    // 2) Nothing stored yet: skip if this area was already synced recently.
    final key = _cellKey(lat, lng);
    if (_wasSyncedRecently(key)) {
      emit(FetchSpotsSuccess(spots: const []));
      return;
    }

    // 3) Fetch from Overpass (it persists into Supabase), then re-read.
    emit(FetchSpotsLoading());
    try {
      await overpassRepo.fetchOverpassGetSpots(lat: lat, lng: lng);
      await _markSynced(key); 
    } catch (e) {
      if (isClosed) return;
      emit(FetchSpotsError(errorMessage: e.toString()));
      return;
    }
    if (isClosed) return;

    final fresh = await supabaseRepo.fetchSpotsFromSupaBase(lat: lat, lng: lng);
    if (isClosed) return;
    fresh.fold(
      (failure) => emit(FetchSpotsError(errorMessage: failure.errorMessage)),
      (spots) => emit(FetchSpotsSuccess(spots: spots)),
    );
  }
}
