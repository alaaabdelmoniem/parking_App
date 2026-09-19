import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/auth/presentation/views/widgets/animated_auth_button.dart';
import 'package:parking/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:parking/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:parking/features/auth/presentation/views/widgets/social_row.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            //animations

            Center(
              child: SizedBox(
                height: 300.h,
                child: Lottie.asset(
                  'assets/animations/register.json',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48.sp,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Sign up to start finding parking near you.',
              style: AppTextStyle.body.copyWith(color: AppColors.textBody),
            ),
            SizedBox(height: 28.h),

            Text(
              'Username',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              keyboardType: TextInputType.name,
              style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Alex Chen',
                hintStyle: TextStyle(fontSize: 15.sp, color: Colors.black38),
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 18.sp,
                  color: AppColors.textTertiary,
                ),
              ),
            ),

            SizedBox(height: 18.h),
            Text(
              'Email',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            const EmailTextField(),
            SizedBox(height: 18.h),

            Text(
              'Password',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            const PasswordTextField(),
            SizedBox(height: 24.h),

            AnimatedAuthButton(onPressed: () {}, text: 'Sign up'),

            SizedBox(height: 20.h),

            const SocialRow(),

            SizedBox(height: 28.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textBody,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(AppRouter.kLoginView);
                    },
                    child: Text(
                      'Log in',
                      style: AppTextStyle.buttonSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
