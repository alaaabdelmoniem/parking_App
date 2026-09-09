
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class CustomAmenitiesListView extends StatefulWidget {
  const CustomAmenitiesListView({super.key, required this.filters});
  final List<String> filters;

  @override
  State<CustomAmenitiesListView> createState() =>
      _CustomAmenitiesListViewState();
}

class _CustomAmenitiesListViewState extends State<CustomAmenitiesListView> {
  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final isSelected = index == selectedFilterIndex;

          return GestureDetector(
            onTap: () => setState(() {
              selectedFilterIndex = index;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInCubic,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.secondary
                    : AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColors.secondary : AppColors.border,
                ),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                style: AppTextStyle.buttonSmall.copyWith(
                  color: isSelected
                      ? AppColors.textOnDark
                      : AppColors.textSecondary,
                ),
                child: Text(widget.filters[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
