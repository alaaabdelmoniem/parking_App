import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/presentation/views/widgets/header_draggable_sheet.dart';
import 'package:parking/features/map/presentation/views/widgets/spot_nearby_item.dart';

class RoundedSheetContent extends StatelessWidget {
  const RoundedSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.1,
      maxChildSize: 0.85,
      // snap: true, // عشان يوقف عند نقط محددة بدل ما يفضل يتحرك حر
      // snapSizes: const [0.1, 0.35, 0.85], // النقط اللي هيوقف عندها بالظبط
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
                    const SpotNearbyItem(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
