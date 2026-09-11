import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class SpotsDetailsPageViewImages extends StatefulWidget {
  const SpotsDetailsPageViewImages({super.key, required this.spotModel});
  final SpotModel spotModel;

  @override
  State<SpotsDetailsPageViewImages> createState() =>
      _SpotsDetailsPageViewImagesState();
}

class _SpotsDetailsPageViewImagesState
    extends State<SpotsDetailsPageViewImages> {
  int currentIndx = 0;
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 350.h,

          child: PageView.builder(
            controller: controller,
            onPageChanged: (value) => setState(() {
              currentIndx = value;
            }),
            itemCount: 3,
            itemBuilder: (context, indx) {
              return Image.asset(
                widget.spotModel.images[indx],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
          bottom: 15.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (int index) {
              return AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                duration: const Duration(milliseconds: 300),
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: currentIndx == index
                      ? AppColors.primaryPale
                      : const Color(0XFFDEDBDB),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
