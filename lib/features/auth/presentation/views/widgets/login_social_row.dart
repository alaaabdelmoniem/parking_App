import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/auth/presentation/manager/cubits/login_with_google/login_google_cubit.dart';
import 'package:parking/features/auth/presentation/views/widgets/social_circle.dart';

class LoginSocialRow extends StatelessWidget {
  const LoginSocialRow({super.key, required this.googleOnTap, required this.facebookOnTap});
final void Function() googleOnTap;
final void Function() facebookOnTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.divider)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Or',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            Expanded(child: Divider(color: AppColors.divider)),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<LoginGoogleCubit, LoginGoogleState>(
              listener: (context, state) {
                if (state is LoginWithGoogleLoading) {
                  //TODO:show animation on dialog
                }
                if (state is LoginWithGoogleFailure) {
                  //TODO: show with toast instead of snackbar

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                return SocialCircle(
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: const Color(0xFFEA4335),
                    size: 19.sp,
                  ),
                  onTap: googleOnTap,
                );
              },
            ),
            const SizedBox(width: 18),
            SocialCircle(
              icon: FaIcon(
                FontAwesomeIcons.apple,
                color: Colors.black,
                size: 20.sp,
              ),
              onTap: () {},
            ),
            const SizedBox(width: 18),
            SocialCircle(
              icon: FaIcon(
                FontAwesomeIcons.facebookF,
                color: const Color(0xFF1877F2),
                size: 20.sp,
              ),
              onTap: facebookOnTap,
            ),
          ],
        ),
      ],
    );
  }
}
