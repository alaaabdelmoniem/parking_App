import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_summary_item.dart';

class PromoAndSummarySection extends StatefulWidget {
  const PromoAndSummarySection({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  State<PromoAndSummarySection> createState() => _PromoAndSummarySectionState();
}

class _PromoAndSummarySectionState extends State<PromoAndSummarySection> {
  final TextEditingController _controller = TextEditingController();

  bool _applied = true;
  final double _savedAmount = 5.00;

  void _toggleApply() {
    setState(() {
      _applied = !_applied;
    });
  }

  void _dismissBanner() {
    setState(() {
      _applied = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Promotional Code',
              style: AppTextStyle.sectionLabel.copyWith(
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 20.sp,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textCapitalization: TextCapitalization.characters,
                            style: AppTextStyle.cardTitle.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: false,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Enter promo code',
                              hintStyle: AppTextStyle.body.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _toggleApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnDark,
                      elevation: 0,
                      minimumSize: Size(0, 48.h),
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      _applied ? 'Applied' : 'Apply',
                      style: AppTextStyle.buttonSmall.copyWith(
                        color: AppColors.textOnDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Success banner
            if (_applied) ...[
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.successPale,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.successDark,
                          ),
                          children: [
                            TextSpan(
                              text: "Code '${_controller.text}' ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'saved you \$${_savedAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _dismissBanner,
                      child: Icon(
                        Icons.close,
                        size: 18.sp,
                        color: AppColors.successDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 25.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSummaryItem(
                label: 'Parking fee',
                value: '\$${widget. bookModel.spotModel.priceForHour}',
              ),
              SizedBox(height: 10.h),
              const CustomSummaryItem(label: 'Tax (8.75%)', value: '\$1.05'),
              SizedBox(height: 10.h),
              const CustomSummaryItem(
                label: 'EV Fast Charging surcharge',
                value: '\$.50',
              ),
              SizedBox(height: 10.h),
              const CustomSummaryItem(
                label: 'Convenience & Platform fee',
                value: '\$1.55',
              ),
              SizedBox(height: 10.h),
              if (_applied) ...[
                const CustomSummaryItem(
                  label: 'Member discount',
                  value: '-\$2.50',
                  valueColor: AppColors.success,
                ),
                SizedBox(height: 12.h),
              ],
              const Divider(color: AppColors.border),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: AppTextStyle.cardTitle.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '\$${widget.bookModel.spotModel.priceForHour! *widget. bookModel.duration}',
                    style: AppTextStyle.monoDisplay.copyWith(
                      color: AppColors.primary,
                      fontSize: 22.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
