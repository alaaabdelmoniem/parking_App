import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/launch_website_url.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_distance_and_reviews_row.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_spot_details_price.dart';

class SpotDetailsViewDetailsSection extends StatelessWidget {
  const SpotDetailsViewDetailsSection({
    super.key,
    required this.spotModel,
    required this.dis,
  });
  final SpotModel spotModel;
  final double dis;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomDistanceAndRiewesRow(spotModel: spotModel, dis: dis),
              SizedBox(height: 4.h),

              if (spotModel.website != null || (spotModel.phone != null)) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (spotModel.website != null) ...[
                      GestureDetector(
                        onTap: () => launchWebsite(spotModel.website!),
                        child: Text(
                          spotModel.website!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.body.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                    if (spotModel.phone != null) ...[
                      Text(
                        spotModel.phone!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),

        Expanded(flex: 1, child: CustomSpotDetailsPrice(spotModel: spotModel)),
      ],
    );
  }
}
