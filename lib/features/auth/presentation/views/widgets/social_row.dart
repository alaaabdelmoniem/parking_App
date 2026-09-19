import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking/core/utils/app_colors.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

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
            SocialCircle(
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: const Color(0xFFEA4335),
                size: 19.sp,
              ),
              onTap: () {},
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
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class SocialCircle extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialCircle({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE3E5EC)),
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
