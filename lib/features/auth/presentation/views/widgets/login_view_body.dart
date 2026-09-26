import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/widgets/morphing_loading_button.dart';
import 'package:parking/features/auth/presentation/manager/cubits/login_with_email/login_with_email_cubit.dart';
import 'package:parking/features/auth/presentation/manager/cubits/login_with_google/login_google_cubit.dart';
import 'package:parking/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:parking/features/auth/presentation/views/widgets/login_social_row.dart';
import 'package:parking/features/auth/presentation/views/widgets/password_text_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Form(
        key: _formkey,
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
            EmailTextField(controller: emailController),
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
            PasswordTextField(controller: passwordController),
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
            BlocConsumer<LoginWithEmailCubit, LoginWithEmailState>(
              listener: (context, state) {
                if (state is LoginWithEmailFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }

                if (state is LoginWithEmailSuccess) {
                  GoRouter.of(context).pushReplacement(AppRouter.kMapView);
                }
              },

              builder: (context, state) {
                final isLoading = state is LoginWithEmailLoading;

                return MorphingLoadingButton(
                  isLoading: isLoading,
                  text: 'Log in',
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      log(
                        '${emailController.text} ,pass: ${passwordController.text}',
                      );
                      BlocProvider.of<LoginWithEmailCubit>(
                        context,
                      ).loginWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                );
              },
            ),
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

            LoginSocialRow(
              googleOnTap: () {
                BlocProvider.of<LoginGoogleCubit>(context).loginWithGoogle();
              },
              facebookOnTap: () {},
            ),

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
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kSignupView);
                    },
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
