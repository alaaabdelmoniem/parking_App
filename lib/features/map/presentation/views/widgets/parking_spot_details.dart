import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/amenity_section_item.dart';
import 'package:parking/features/map/presentation/views/widgets/data_item_section.dart';

class ParkingSpotDetails extends StatelessWidget {
  const ParkingSpotDetails({
    super.key,
    required this.spotModel,
    this.amenity = false,
  });
  final SpotModel spotModel;
  final bool amenity;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: amenity
              ? EdgeInsets.only(top: 6.h)
              : const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),

            child: Image.asset(
              spotModel.images[0],

              width: 78.w,
              height: 78.w,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 78.w,
                height: 78.w,
                color: AppColors.surfaceMuted,
                child: const Icon(
                  Icons.local_parking,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            children: [
              DataItemSection(spotModel: spotModel),
              SizedBox(height: 8.h),
              if (amenity) ...[
                const AmenitySectionitem(),
                SizedBox(height: 2.h),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
