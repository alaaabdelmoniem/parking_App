import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parking made\neffortless.',
            style: TextStyle(
              fontSize: 31.sp,
              color: const Color(0XFF191B21),
              letterSpacing: -0.4,
              height: 1.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16.h),
          Text(
            'Find, book, and manage your parking in seconds. Discover available spots near you without the stress of circling the block.',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.scrim,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 32.h),
          Card(
            color: const Color(0XFFF3F3FB),
            clipBehavior: Clip.none,

            child: Padding(
              padding: EdgeInsets.all(18.r),
              child: Row(
                children: [
                  Container(
                    height: 42.h,
                    width: 42.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/sending_icon.png',
                      color: const Color(0XFF4A5B80),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precision Search',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFF191B21),
                        ),
                      ),
                      Text(
                        'Real-time availability tracking',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0XFF424752),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
