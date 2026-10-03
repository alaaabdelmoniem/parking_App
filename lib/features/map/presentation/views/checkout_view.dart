import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/data/repos/booking_repo/booking_spot_repo_imple.dart';
import 'package:parking/features/map/presentation/manager/cubits/book_spot/book_spot_cubit.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookSpotCubit(bookingSpotRepo: BookingSpotRepoImple()),
      child: Scaffold(body: CheckoutViewBody(bookModel: bookModel)),
    );
  }
}
