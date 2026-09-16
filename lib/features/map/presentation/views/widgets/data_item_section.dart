import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/get_current_postiones.dart';
import 'package:parking/core/utils/functions/get_distance_and_time.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_price.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_rating_and_status.dart';

class DataItemSection extends StatefulWidget {
  const DataItemSection({super.key, required this.spotModel});
  final SpotModel spotModel;

  @override
  State<DataItemSection> createState() => _DataItemSectionState();
}

class _DataItemSectionState extends State<DataItemSection> {
  @override
  void initState() {
    super.initState();
    getpos();
  }

  Position? currentPosition;
  Future<void> getpos() async {
    currentPosition = await getCurrentLocation();
    if (mounted) setState(() {}); // screen will update when location recieve
    log('work: $currentPosition');
  }

  @override
  Widget build(BuildContext context) {
    var mxava = (int.tryParse(widget.spotModel.capacity ?? '0') ?? 0);

    double dis = (currentPosition != null)
        ? getDistanceFrom(
            currentPosition!,
            widget.spotModel.lat,
            widget.spotModel.lng,
          )
        : 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                widget.spotModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.cardTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${formatDistanceAway(dis)}· ${widget.spotModel.type}',
                style: AppTextStyle.cardSubtitle,
              ),
              SizedBox(height: 11.h),
              CustomRatingAndStatus(
                spotModel: widget.spotModel,
                maxCap: mxava > 100 ? mxava + 10 : 100,
              ),
            ],
          ),
        ),
        CustomPrice(spotModel: widget.spotModel),
      ],
    );
  }
}
