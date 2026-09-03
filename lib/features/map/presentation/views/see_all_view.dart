import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/presentation/views/widgets/sort_dropdown_button.dart';

class SeeALlSpotsView extends StatefulWidget {
  const SeeALlSpotsView({super.key});

  @override
  State<SeeALlSpotsView> createState() => _SeeALlSpotsViewState();
}

class _SeeALlSpotsViewState extends State<SeeALlSpotsView> {
  int _selectedFilterIndex = 0;
  double _maxPrice = 15;
  String _selectedSort = 'Distance';

  static const _filters = ['All', 'EV Charging', 'Covered', '24/7', 'Security'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.textPrimary,
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search parking locations...',
                      hintStyle: AppTextStyle.body.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20.sp,
                        color: AppColors.textTertiary,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40.w,
                        minHeight: 20.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                SortDropdownButton(
                  selected: _selectedSort,
                  onSelected: (value) => setState(() => _selectedSort = value),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, _) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedFilterIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilterIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.secondary
                            : AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.secondary
                              : AppColors.border,
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
                        child: Text(_filters[index]),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                Text(
                  'Max price',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3.h,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 8.r,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 14.r,
                      ),
                    ),
                    child: Slider(
                      value: _maxPrice,
                      min: 0,
                      max: 50,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.border,
                      onChanged: (value) => setState(() => _maxPrice = value),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  '\$${_maxPrice.round()}',
                  style: AppTextStyle.monoPrice.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '5 locations found',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Live data',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
