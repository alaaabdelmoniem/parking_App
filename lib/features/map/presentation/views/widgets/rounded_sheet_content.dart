import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/presentation/manager/cubits/fetch_spots/fetch_spots_cubit.dart';
import 'package:parking/features/map/presentation/views/widgets/header_draggable_sheet.dart';
import 'package:parking/features/map/presentation/views/widgets/spot_nearby_item.dart';

class RoundedSheetContent extends StatelessWidget {
  const RoundedSheetContent({super.key});
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.70,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),

          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Container(
                      width: 40.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    const HeaderDraggableSheet(),
                    SizedBox(height: 17.h),
                  ],
                ),
              ),

              BlocBuilder<FetchSpotsCubit, FetchSpotsState>(
                builder: (context, state) {
                  if (state is FetchSpotsSuccess) {
                    return SliverList.separated(
                      itemBuilder: (context, index) {
                        return SpotNearbyItem(spotModel: state.spots[index]);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 4.h),
                      itemCount: state.spots.length,
                    );
                  } else if (state is FetchSpotsLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is FetchSpotsError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.errorMessage)),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('search on city or loaction')),
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 17.h)),
            ],
          ),
        );
      },
    );
  }
}
