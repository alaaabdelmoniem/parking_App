import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/presentation/views/widgets/see_all_reviews_dragable_bottom_sheet.dart';

class SeeAllReviewsButton extends StatelessWidget {
  const SeeAllReviewsButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => const SeeAllReviewsDragableBottomSheet(),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: AppColors.border, width: 1.4),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 22.w),
        child: Center(
          child: Text(
            'See all reviews',
            style: AppTextStyle.buttonSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
