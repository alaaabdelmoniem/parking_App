import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/features/reservations/data/repos/reservations_repo_imple.dart';
import 'package:parking/features/reservations/presentation/manager/cubits/get_booking_spots/getbookingspots_cubit.dart';
import 'package:parking/features/reservations/presentation/views/widgets/reservations_view_body.dart';

class ReservationsView extends StatelessWidget {
  const ReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetbookingspotsCubit(reservationsRepo: ReservationsRepoImple())
            ..getBookingSpotsFromSupabase(),
      child: const Scaffold(body: ReservationsViewBody()),
    );
  }
}
