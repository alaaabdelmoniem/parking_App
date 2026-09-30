import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class PaymentMethodTile extends StatefulWidget {
  const PaymentMethodTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  State<PaymentMethodTile> createState() => _PaymentMethodTileState();
}

class _PaymentMethodTileState extends State<PaymentMethodTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 9.w),
      margin: EdgeInsets.only(top: 10.h, bottom: 12.h),

      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          // Icon tile
          Container(
            width: 35.w,
            height: 35.w,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(widget.icon, color: AppColors.textOnDark, size: 20.sp),
          ),
          SizedBox(width: 12.w),

          // Title + badge + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyle.cardTitle.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  widget.subtitle,
                  style: AppTextStyle.cardSubtitle.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Selection indicator
          SizedBox(width: 12.w),
          IconButton(
            icon: isSelected
                ? Icon(Icons.check_circle, size: 22.sp)
                : Icon(Icons.circle_outlined, size: 22.sp),
            color: isSelected ? AppColors.primary : AppColors.textTertiary,
            onPressed: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
          ),
        ],
      ),
    );
  }
}
