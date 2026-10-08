import 'package:flutter/material.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_confirmed_view_body.dart';

class BookingConfirmedView extends StatelessWidget {
  const BookingConfirmedView({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      body: BookingConfirmedViewBody(bookModel: bookModel,),
    );
  }
}