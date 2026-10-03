import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/add_payment_button.dart';
import 'package:parking/features/map/presentation/views/widgets/payment_methods_section.dart';
import 'package:parking/features/map/presentation/views/widgets/promo_and_summary_section.dart';

class CheckoutDetailsSection extends StatefulWidget {
  const CheckoutDetailsSection({super.key, required this.bookModel});
  final BookModel bookModel;

  @override
  State<CheckoutDetailsSection> createState() => _CheckoutDetailsSectionState();
}

class _CheckoutDetailsSectionState extends State<CheckoutDetailsSection> {
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
                  border: Border.all(color: AppColors.border),
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

        PromoAndSummarySection(bookModel: widget.bookModel),
        const PaymentMethodsSection(),

        AddPaymentButton(onTap: () {}),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              sizeStyle: CupertinoButtonSize.medium,
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.r),
              onPressed: () {},
              child: Text(
                'Confirm  Booking',
                style: AppTextStyle.buttonSmall.copyWith(
                  color: AppColors.textOnDark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
