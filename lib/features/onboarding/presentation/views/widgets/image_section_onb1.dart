import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDREERKSX5Y-grYchDDE0gxd3K8XxcQ870an1xqAp4WXa76V3M0H0XDlkH4QOe2GVS-hiXOfYIVc_RlwE-V3IFaDOmDm8_GGQyFNrkxM1BLH0w0Xl3LBxzHWYH8Xz4wfZwngodG2PqAIYD6iuJlI0yKHcgW2xo5z-A1t4QDG7Jhl75rHr7ayRgrxxyMQeL_ehxI5ArmRfdfuCrjqrrnJ9SGXblFbxIXG4xOCuoB_rhueV4FBg-qbcFu',
          fit: BoxFit.cover,
          width: double.infinity.w,
          height: 486.h,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFAF9FF).withValues(alpha: 0.0),
                  const Color(0xFFFAF9FF).withValues(alpha: 0.7),
                  const Color(0xFFFAF9FF),
                ],
                stops: const [0.0, 0.8, 1.0],
              ),
            ),
          ),
        ),

        Positioned(
          left: 20.w,
          top: 40.h,
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 46.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Image.asset('assets/images/park_icon.png'),
              ),
              SizedBox(width: 8.w),
              Text(
                'Aetheris Mobility',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
