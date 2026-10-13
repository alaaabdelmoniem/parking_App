
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class ReservationStatusFilter extends StatefulWidget {
  const ReservationStatusFilter({super.key, this.onChanged});
  final ValueChanged<int>? onChanged;

  @override
  State<ReservationStatusFilter> createState() =>
      _ReservationStatusFilterState();
}

class _ReservationStatusFilterState extends State<ReservationStatusFilter> {
  int _selectedIndex = 0;

  static const List<(String, int?)> _filters = [
    ('All', null),
    ('Active', 1),
    ('Upcoming', null),
    ('Completed', null),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final (label, count) = _filters[index];
          final isSelected = index == _selectedIndex;

          return GestureDetector(
 onTap: () {
              setState(() => _selectedIndex = index);
              widget.onChanged?.call(index);
            },            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.secondary
                    : AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: AppTextStyle.buttonSmall.copyWith(
                      color: isSelected
                          ? AppColors.textOnDark
                          : AppColors.textSecondary,
                    ),
                    child: Text(label),
                  ),
                  if (count != null) ...[
                    SizedBox(width: 6.w),
                    Container(
                      width: 18.w,
                      height: 18.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$count',
                        style: AppTextStyle.captionSmall.copyWith(
                          color: AppColors.textOnDark,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
