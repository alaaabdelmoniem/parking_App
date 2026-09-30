import 'package:flutter/material.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CheckoutViewBody(bookModel: bookModel));
  }
}
