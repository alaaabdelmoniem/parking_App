import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/core/utils/app_colors.dart';

class ContentSectionOnBording2 extends StatelessWidget {
  const ContentSectionOnBording2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/animations/Map Routing.json'),
        SizedBox(height: 32.h),
        Text(
          'Smart Discovery',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0XFF191B21),
          ),
        ),
        SizedBox(height: 16.h),

        Text(
          'Real-time availability. See exactly where spots are open before you even arrive.',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.scrim,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
