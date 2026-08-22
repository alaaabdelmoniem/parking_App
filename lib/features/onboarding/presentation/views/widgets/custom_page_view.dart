import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/header.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/onboarding_1.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/onboarding_2.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/onboarding_3.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({super.key});

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController controller = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void previusView() {
    if (currentIndex > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void nextView() {
    if (currentIndex < screens.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void onSkip() {
    controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  final List<Widget> screens = const [
    Onboarding1(),
    Onboarding2(),
    EnableLocationScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (context, index) => screens[index],
                  itemCount: screens.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                ),
              ),

              Column(
                children: [
                  //Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      final active = i == currentIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 36.w : 7.w,
                        height: 7,
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary : AppColors.border,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: currentIndex != 0
                        ? EdgeInsets.symmetric(horizontal: 20.r)
                        : EdgeInsetsGeometry.symmetric(horizontal: 70.r),
                    child: Row(
                      children: [
                        if (currentIndex != 0) ...[
                          DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              strokeWidth: 1.5,
                              dashPattern: const [6, 4],
                              radius: const Radius.circular(30),
                              padding: EdgeInsets.zero,
                            ),

                            child: SizedBox(
                              height: 50.h,
                              child: TextButton(
                                onPressed: previusView,

                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                  ),
                                ),
                                child: Text(
                                  'Previous',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 36.w),
                        ],
                        Expanded(
                          child: GestureDetector(
                            onTap: nextView,
                            child: Container(
                              height: 57.h,

                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(28.r),
                              ),

                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (currentIndex == 0) ...[
                    TextButton(
                      onPressed: onSkip,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          if (currentIndex == 1) ...[
            Positioned(
              top: 17.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Header(onPressed: onSkip),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
