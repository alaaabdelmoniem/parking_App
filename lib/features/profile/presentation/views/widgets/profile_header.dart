import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';
import 'package:parking/core/utils/widgets/custom_outlined_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userinfo =
        CacheHelper.getValue(key: CacheKeys.userInfoList) as List<String>;

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  userinfo[0][0].toUpperCase(),
                  style: AppTextStyle.sheetTitle.copyWith(
                    color: AppColors.primary,
                    fontSize: 26.sp,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 14.sp,
                    color: AppColors.textOnDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            userinfo[0],
            style: AppTextStyle.cardTitle.copyWith(
              color: AppColors.textPrimary,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            userinfo[1],
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 12.h),

          CustomOutlinedButton(
            hight: 34.h,
            radius: 20.r,
            icon: Icons.edit_outlined,
            label: 'Edit profile',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
