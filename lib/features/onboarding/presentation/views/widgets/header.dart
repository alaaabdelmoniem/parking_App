import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key, this.isSkip = true, this.onPressed});
  final bool isSkip;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Aetheris',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const Spacer(),
        isSkip == true
            ? TextButton(
                onPressed: onPressed,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textTertiary,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
