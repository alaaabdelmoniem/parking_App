import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/manager/cubits/fetch_spots/fetch_spots_cubit.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_amenities_list_view.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_live_data.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_see_all_text_field.dart';
import 'package:parking/features/map/presentation/views/widgets/parking_spot_details.dart';
import 'package:parking/features/map/presentation/views/widgets/sort_dropdown_button.dart';

class SeeALlSpotsView extends StatefulWidget {
  const SeeALlSpotsView({super.key});

  @override
  State<SeeALlSpotsView> createState() => _SeeALlSpotsViewState();
}

class _SeeALlSpotsViewState extends State<SeeALlSpotsView> {
  double _maxPrice = 15;
  String _selectedSort = 'Distance';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  static const _filters = ['All', 'EV Charging', 'Covered', '24/7', 'Security'];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchSpotsCubit>(
      context,
    ).fetchSpots(lat: 51.5074, lng: -0.1278);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SpotModel> _applyFiltersAndSort(List<SpotModel> spots) {
    var result = spots.where((spot) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          spot.name.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesPrice =
          spot.priceForHour == null || spot.priceForHour! <= _maxPrice;

      return matchesSearch && matchesPrice;
    }).toList();

    switch (_selectedSort) {
      case 'Price':
        result.sort(
          (a, b) => (a.priceForHour ?? 0).compareTo(b.priceForHour ?? 0),
        );
        break;
      case 'Rating':
        result.sort((a, b) => (b.rate ?? 0).compareTo(a.rate ?? 0));
        break;
      case 'Distance':
      case 'Availability':
      default:
        // Distance/Availability sorting can be added once those values
        // are computed (distanceFrom requires the user's live position).
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomSeeAllTextField(
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
                SizedBox(width: 10.w),
                SortDropdownButton(
                  selected: _selectedSort,
                  onSelected: (value) => setState(() => _selectedSort = value),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            const CustomAmenitiesListView(filters: _filters),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  'Max price',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3.h,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 8.r,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 14.r,
                      ),
                    ),
                    child: Slider(
                      value: _maxPrice,
                      min: 0,
                      max: 50,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.border,
                      onChanged: (value) => setState(() => _maxPrice = value),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  '\$${_maxPrice.round()}',
                  style: AppTextStyle.monoPrice.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: BlocBuilder<FetchSpotsCubit, FetchSpotsState>(
                builder: (context, state) {
                  if (state is FetchSpotsLoading ||
                      state is FetchSpotsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is FetchSpotsError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  final allSpots = (state as FetchSpotsSuccess).spots;
                  final visibleSpots = _applyFiltersAndSort(allSpots);
                  return visibleSpots.isEmpty
                      ? Center(
                          child: Text(
                            'No parking spots match your filters.',
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            CustomLiveData(length: visibleSpots.length),
                            SizedBox(height: 10.h),

                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(color: AppColors.secondary),
                                itemCount: visibleSpots.length,
                                itemBuilder: (context, index) {
                                  return ParkingSpotDetails(
                                    amenity: true,
                                    spotModel: visibleSpots[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
