
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';

class DividerBeforSummaryItem extends StatelessWidget {
  const DividerBeforSummaryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Divider(
          color: AppColors.textBody.withValues(alpha: .1),
          endIndent: 50,
          indent: 50,
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}
