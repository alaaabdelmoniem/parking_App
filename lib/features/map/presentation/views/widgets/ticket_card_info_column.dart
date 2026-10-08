
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class TicketCardInfoColumn extends StatelessWidget {
  const TicketCardInfoColumn({super.key, 
    required this.label,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mono = false,
    this.valueColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  final bool mono;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(label, style: AppTextStyle.caption),
        SizedBox(height: 4.h),
        Text(
          value,
          style: (mono ? AppTextStyle.monoPriceLarge : AppTextStyle.cardTitle)
              .copyWith(color: valueColor),
        ),
      ],
    );
  }
}
