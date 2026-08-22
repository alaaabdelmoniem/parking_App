import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/privacy_note.dart';

class ContentSectionOnboarding3 extends StatelessWidget {
  const ContentSectionOnboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset('assets/animations/Man waiting car.json'),
        SizedBox(height: 60.h),
        Text(
          'Find parking near you',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF191B21),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          'Allow Aetheris to access your location so we can find the closest available spots and guide you straight to them.',
          style: TextStyle(
            fontSize: 16.sp,
            height: 1.5,
            color: const Color(0xFF424752),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        const PrivacyNote(),
      ],
    );
  }
}
