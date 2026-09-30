
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class ReservationTips extends StatelessWidget {
  const ReservationTips({super.key});

  static const List<String> _tips = [
    'Get instant confirmation and directions straight to your reserved spot.',
    'Modify or cancel your booking anytime before check-in, no fees.',
    'Need more time? Extend your session right from the app.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tips for a Smooth Park',
          style: AppTextStyle.sectionTitle.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 18.h),
        ..._tips.map(
          (tip) => Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15.sp,
                    color: AppColors.textOnDark,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    tip,
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.textBody,
                    ),
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
