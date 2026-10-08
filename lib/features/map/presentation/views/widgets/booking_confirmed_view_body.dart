import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/summary_header_section.dart';
import 'package:parking/features/map/presentation/views/widgets/ticket_card.dart';

class BookingConfirmedViewBody extends StatelessWidget {
  const BookingConfirmedViewBody({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(text: 'Booking Confirmed'),

        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                Text(
                  bookModel.spotModel.name,
                  style: AppTextStyle.pageTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  bookModel.spotModel.address.toString(),
                  style: AppTextStyle.bodySmall,
                ),
                SizedBox(height: 20.h),
                TicketCard(bookModel: bookModel),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          child: ElevatedButton.icon(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.kMapView);
            },
            label: Text(
              'Done',
              style: AppTextStyle.buttonSmall.copyWith(
                color: AppColors.textOnDark,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(220.w, 52.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
