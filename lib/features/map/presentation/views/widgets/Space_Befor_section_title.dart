import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';

class SpaceBeforSectionTitle extends StatelessWidget {
  const SpaceBeforSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        Divider(
          indent: 30,
          color: AppColors.textBody.withValues(alpha: .2),
          endIndent: 30,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
