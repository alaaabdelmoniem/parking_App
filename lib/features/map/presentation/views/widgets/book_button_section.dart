import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class BookButtonSection extends StatelessWidget {
  const BookButtonSection({super.key, required this.spotModel});
  final SpotModel spotModel;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .18,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
      color: AppColors.card,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: r'US$',
                      style: AppTextStyle.monoPriceLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 21.sp,
                      ),
                    ),
                    TextSpan(
                      text: '${spotModel.priceForHour}',
                      style: AppTextStyle.monoPriceLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 21.sp,
                      ),
                    ),
                    TextSpan(
                      text: '\ttotal',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 17.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.not_interested,
                    size: 22.sp,
                    color: AppColors.secondary,
                  ),
                  SizedBox(width: 4.w),
                  const Text('NO in & Out'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(color: AppColors.textBody.withValues(alpha: .2)),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: Center(
                child: Text(
                  'Book now',
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
