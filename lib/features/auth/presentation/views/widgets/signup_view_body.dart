import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/widgets/morphing_loading_button.dart';
import 'package:parking/features/auth/presentation/manager/cubits/register_with_email/register_with_email_cubit.dart';
import 'package:parking/features/auth/presentation/manager/cubits/register_with_google/register_with_google_cubit.dart';
import 'package:parking/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:parking/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/features/auth/presentation/views/widgets/register_social_row.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
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
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }

                return null;
              },
              keyboardType: TextInputType.name,
              controller: nameController,
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
            EmailTextField(controller: emailController),
            SizedBox(height: 18.h),

            Text(
              'Password',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            PasswordTextField(controller: passwordController),
            SizedBox(height: 24.h),

            BlocConsumer<RegisterWithEmailCubit, RegisterWithEmailState>(
              listener: (context, state) {
                if (state is RegisterWithEmailFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }

                if (state is RegisterWithEmailSuccess) {
                  GoRouter.of(context).pushReplacement(AppRouter.kMapView);
                }
              },

              builder: (context, state) {
                final isLoading = state is RegisterWithEmailLoading;

                return MorphingLoadingButton(
                  isLoading: isLoading,
                  text: 'Sign up',
                  onPressed: () {
                    BlocProvider.of<RegisterWithEmailCubit>(
                      context,
                    ).registerWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                      fullName: nameController.text,
                    );
                  },
                );
              },
            ),

            SizedBox(height: 20.h),

            RegisterSocialRow(
              googleOnTap: () {
                BlocProvider.of<RegisterWithGoogleCubit>(
                  context,
                ).registerWithGoogle();
              },
              facebookOnTap: () {},
            ),

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
