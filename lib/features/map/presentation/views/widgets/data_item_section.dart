import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_price.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_rating_and_status.dart';

class DataItemSection extends StatelessWidget {
  const DataItemSection({super.key, required this.spotModel});
  final SpotModel spotModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                spotModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.cardTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '1.5 mi away · ${spotModel.type}',
                style: AppTextStyle.cardSubtitle,
              ),
              SizedBox(height: 11.h),
              CustomRatingAndStatus(spotModel: spotModel),
            ],
          ),
        ),
        CustomPrice(spotModel: spotModel),
      ],
    );
  }
}
