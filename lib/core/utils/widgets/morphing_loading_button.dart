import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class MorphingLoadingButton extends StatelessWidget {
  const MorphingLoadingButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  });

  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  static const _buttonHeight = 52.0;

  @override
  Widget build(BuildContext context) {
    // Full width, minus the horizontal padding used around the button.
    final expandedWidth = MediaQuery.of(context).size.width - 48.w;

    return Center(
      child: GestureDetector(
        onTap: isLoading ? null :onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          height: _buttonHeight.h,
          width: isLoading ? _buttonHeight.h : expandedWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(_buttonHeight.h / 2),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: isLoading
                ? SizedBox(
                    key: const ValueKey('loading'),
                    width: 22.w,
                    height: 22.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textOnDark,
                      ),
                    ),
                  )
                : Text(
                    text,
                    key: const ValueKey('label'),
                    style: AppTextStyle.buttonSmall.copyWith(
                      color: AppColors.textOnDark,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
