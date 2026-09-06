
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/presentation/views/widgets/amenity_item.dart';

class AmenitySectionitem extends StatelessWidget {
  const AmenitySectionitem({super.key});

  @override
  Widget build(BuildContext context) {
    return           Row(
                children: [
                  const AmenityItem(
                    icon: Icons.access_time,
                    label: '24/7',
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 6.w),
                  const AmenityItem(
                    icon: Icons.lock,
                    label: 'Security',
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 6.w),
                  const AmenityItem(
                    icon: Icons.bolt,
                    label: 'EV Charging',
                    color: AppColors.warning,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '+2',
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              );
  }
}