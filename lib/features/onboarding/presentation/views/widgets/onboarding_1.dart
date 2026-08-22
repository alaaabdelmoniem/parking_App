import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/content_sectiononb1.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/image_section_onb1.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ImageSection(),
            Transform.translate(
              offset: Offset(0, -64.h),
              child: const ContentSection(),
            ),
          ],
        ),
      ),
    );
  }
}
