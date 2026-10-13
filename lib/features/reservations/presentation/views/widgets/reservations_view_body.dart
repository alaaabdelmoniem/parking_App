import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/date_and_time_formats.dart';
import 'package:parking/features/reservations/presentation/manager/cubits/get_booking_spots/getbookingspots_cubit.dart';
import 'package:parking/features/reservations/presentation/views/widgets/reservation_status_filter.dart';
import 'package:parking/features/reservations/presentation/views/widgets/reservations_card.dart';

class ReservationsViewBody extends StatelessWidget {
  const ReservationsViewBody({super.key});
  ReservationCardStatus mapBookingStatus(String status) {
    switch (status) {
      case 'active':
        return ReservationCardStatus.active;
      case 'completed':
      case 'cancelled':
        return ReservationCardStatus.completed;
      case 'upcoming':
      default:
        return ReservationCardStatus.upcoming;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Text(
            'my Reservations',
            style: AppTextStyle.pageTitle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15.h),
          const ReservationStatusFilter(),
          SizedBox(height: 15.h),

          BlocBuilder<GetbookingspotsCubit, GetbookingspotsState>(
            builder: (context, state) {
              if (state is GetbookingspotsLoading ||
                  state is GetbookingspotsInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetbookingspotsFailure) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: AppTextStyle.body.copyWith(color: AppColors.error),
                  ),
                );
              } else if (state is GetbookingspotsSuccess) {
                final bookings = state.bookings;
                final spots = state.spots;

                if (bookings.isEmpty) {
                  return Center(
                    child: Text(
                      'No reservations yet',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: bookings.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final spot =
                          spots[index]; // same index -> same booking's spot
                      return ReservationCard(
                        status: mapBookingStatus(booking.status),
                        imageUrl:
                            (spot?.images != null && spot!.images.isNotEmpty)
                            ? spot.images[0]
                            : 'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=200',
                        spotName: booking.spotName,
                        address: spot?.address ?? 'Address unavailable',
                        date: formatDateOnly(booking.startTime),
                        timeRange:
                            '${formatTimeOnly(booking.startTime)} - ${formatTimeOnly(booking.endTime)}',

                        totalPrice: booking.totalPrice,
                        onViewQrCode: () {},
                        onGetDirections: () {},
                        onBookAgain: () {},
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

//   SizedBox(height: 15.h),

//   ReservationCard(
//     status: ReservationCardStatus.active,
//     imageUrl:
//         'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=200',
// spotName: 'Downtown Garage',
// address: '5 Nile Corniche, Cairo',
// date: 'Oct 13, 2026',
// timeRange: '11:00 PM - 1:00 AM',
//     totalPrice: 16.0,
//     onGetDirections: () {
//       print('open maps');
//     },
//   ),
//   SizedBox(height: 15.h),

//   ReservationCard(
//     status: ReservationCardStatus.completed,
//     imageUrl:
//         'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=200',
//     spotName: 'Maadi Covered Parking',
//     address: '88 Road 9, Maadi',
//     date: 'Oct 2, 2026',
//     timeRange: '2:00 PM - 4:00 PM',
//     totalPrice: 10.0,
//     onBookAgain: () {
//       print('book again');
//     },
//   ),
