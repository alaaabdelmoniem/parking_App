import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/presentation/views/widgets/see_all_reviews_bottom_sheet_content.dart';

class SeeAllReviewsDragableBottomSheet extends StatelessWidget {
  const SeeAllReviewsDragableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .8,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews',
                  style: AppTextStyle.sheetTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,

                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                    size: 22.sp,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Text(
                  'Reservation Details',
                  style: AppTextStyle.sectionLabel.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.info_outline,
                  size: 15.sp,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
            SizedBox(height: 12.h),

            Expanded(
              child: SeeAllReviewsBottomSheetContent(
                controller: scrollController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
