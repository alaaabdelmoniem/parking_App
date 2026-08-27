
import 'package:flutter/material.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class HeaderDraggableSheet extends StatelessWidget {
  const HeaderDraggableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nearby Parking',
          style: AppTextStyle.sectionTitle.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,

            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},

          child: Text(
            'See All',
            style: AppTextStyle.buttonSmall.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
