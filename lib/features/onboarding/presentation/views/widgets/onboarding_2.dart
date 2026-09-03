import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/content_onboarding2.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 85.h),
            const Center(
              child: SingleChildScrollView(child: ContentSectionOnBording2()),
            ),
          ],
        ),
      ),
    );
  }
}
