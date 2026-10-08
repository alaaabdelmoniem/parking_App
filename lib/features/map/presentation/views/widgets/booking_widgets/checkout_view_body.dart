import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/checkout_details_section.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/summary_header_section.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TopBar(text: 'Checkout'),
            CheckoutDetailsSection(bookModel: bookModel),
          ],
        ),
      ),
    );
  }
}
