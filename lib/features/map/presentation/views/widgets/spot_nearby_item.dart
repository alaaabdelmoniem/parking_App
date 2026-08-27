import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/presentation/views/widgets/spot_nearby_item_details.dart';

class SpotNearbyItem extends StatelessWidget {
  const SpotNearbyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.brown.shade600,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(child: Container(width: 2, color: Colors.grey.shade300)),
            ],
          ),
          SizedBox(width: 10.w),
          const Expanded(child: SpotNearbyItemDetails()),
        ],
      ),
    );
  }
}
