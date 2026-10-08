
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';

class TearLine extends StatelessWidget {
  const TearLine({super.key});

  @override
  Widget build(BuildContext context) {
    final notch = 24.w;
    return SizedBox(
      height: notch + 24.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: notch),
              child: LayoutBuilder(
                builder: (_, c) {
                  final dashCount = (c.maxWidth / 10.w).floor();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      dashCount,
                      (_) => Container(
                        width: 5.w,
                        height: 1.5,
                        color: AppColors.border,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: -notch / 2 - 1,
            child: Notch(size: notch),
          ),
          Positioned(
            right: -notch / 2 - 1,
            child: Notch(size: notch),
          ),
        ],
      ),
    );
  }
}

class Notch extends StatelessWidget {
  const Notch({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
      ),
    );
  }
}
