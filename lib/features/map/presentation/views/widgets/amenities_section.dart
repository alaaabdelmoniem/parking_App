import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key});

  static const List<String> _amenities = [
    'Self Park',
    'Garage - Covered',
    'Touchless',
    'On-Site Staff',
    'Wheelchair Accessible',
    'EV Charging',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: AppTextStyle.sectionTitle.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 14.h),
        ..._amenities.map(
          (amenity) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Container(
                    width: 5.w,
                    height: 5.w,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  amenity,
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
