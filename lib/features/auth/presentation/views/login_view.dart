import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/auth/presentation/views/widgets/animated_auth_button.dart';
import 'package:parking/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:parking/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:parking/features/auth/presentation/views/widgets/social_row.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  'assets/animations/Person Using phone.json',
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
            SizedBox(height: 6.h),
            // title
            Text(
              'Log in to find and book parking near you.',
              style: AppTextStyle.body.copyWith(color: AppColors.textBody),
            ),
            SizedBox(height: 28.h),

            //email section
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

            //password section
            Text(
              'Password',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            const PasswordTextField(),
            SizedBox(height: 10.h),

            //forget password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Forgot password?',
                  style: AppTextStyle.buttonSmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),

            // login button
            SizedBox(height: 24.h),
            AnimatedAuthButton(onPressed: () {}, text: 'Log in'),
            SizedBox(height: 20.h),

            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    'or continue with',
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.border)),
              ],
            ),

            SizedBox(height: 20.h),

            const SocialRow(),

            SizedBox(height: 28.h),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textBody,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Sign up',
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
