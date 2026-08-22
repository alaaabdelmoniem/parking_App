import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/content_onboarding3.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/header.dart';

class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 25.h),

            const Header(isSkip: false),
            Padding(
              padding: EdgeInsets.only(top: 56.h),
              child: const Center(
                child: SingleChildScrollView(
                  child: ContentSectionOnboarding3(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
