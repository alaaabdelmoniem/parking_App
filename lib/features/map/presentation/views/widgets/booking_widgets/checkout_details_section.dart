import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/spot_summary_section.dart';
import 'package:parking/features/map/presentation/views/widgets/payment_method_tile.dart';

class CheckoutDetailsSection extends StatefulWidget {
  const CheckoutDetailsSection({super.key, required this.bookModel});
  final BookModel bookModel;

  @override
  State<CheckoutDetailsSection> createState() => _CheckoutDetailsSectionState();
}

class _CheckoutDetailsSectionState extends State<CheckoutDetailsSection> {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9.r),
              child: AspectRatio(
                aspectRatio: 1 / .6,
                child: Image.asset(
                  widget.bookModel.spotModel.images[0],

                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 100.w,
                    height: 100.w,
                    color: AppColors.surfaceMuted,
                    child: const Icon(
                      Icons.local_parking,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 8.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.bookModel.spotModel.name,
                      style: AppTextStyle.cardTitle.copyWith(
                        height: 1,
                        color: AppColors.textPrimary,
                        fontSize: 19.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(widget.bookModel.spotModel.address.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

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
                value: '+\$${widget.bookModel.spotModel.priceForHour}',
              ),
              SizedBox(height: 10.h),
              const CustomSummaryItem(label: 'Tax (8.75%)', value: '+\$1.05'),
              SizedBox(height: 10.h),
              const CustomSummaryItem(
                label: 'EV Fast Charging surcharge',
                value: '+\$.50',
              ),
              SizedBox(height: 10.h),
              const CustomSummaryItem(
                label: 'Convenience & Platform fee',
                value: '+\$1.55',
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
                    '\$${widget.bookModel.spotModel.priceForHour! * widget.bookModel.duration}',
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
        const PaymentMethodTile(
          icon: Icons.apple,
          title: 'Apple Pay',
          subtitle: 'Instant one-touch biometric checkout',
        ),
      ],
    );
  }
}
