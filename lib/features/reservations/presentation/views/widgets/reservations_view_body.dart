import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/date_and_time_formats.dart';
import 'package:parking/core/utils/functions/derive_booking_status.dart';
import 'package:parking/core/utils/functions/show_qrcode_in_bootomsheet.dart';
import 'package:parking/features/reservations/presentation/manager/cubits/get_booking_spots/getbookingspots_cubit.dart';
import 'package:parking/features/reservations/presentation/views/widgets/show_active_sesstion_sheet.dart';
import 'package:parking/features/reservations/presentation/views/widgets/reservation_status_filter.dart';
import 'package:parking/features/reservations/presentation/views/widgets/reservations_card.dart';
import '../../../../../core/utils/reservation_card_status.dart';

class ReservationsViewBody extends StatefulWidget {
  const ReservationsViewBody({super.key});

  @override
  State<ReservationsViewBody> createState() => _ReservationsViewBodyState();
}

class _ReservationsViewBodyState extends State<ReservationsViewBody> {
  int _selectedFilterIndex = 0;
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
          ReservationStatusFilter(
            onChanged: (value) => setState(() {
              _selectedFilterIndex = value;
            }),
          ),
          SizedBox(height: 15.h),

          BlocBuilder<GetbookingspotsCubit, GetbookingspotsState>(
            builder: (context, state) {
              if (state is GetbookingspotsLoading ||
                  state is GetbookingspotsInitial) {
                return const Expanded(
                  child: Center(child: CupertinoActivityIndicator()),
                );
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

                //Resolve which booking/spot pairs should be visible for the currently selected filter tab
                //This is not the best way to handle large datasets — it will impact performance and resources
                final filteredIndexes = bookings.indexed
                    .where((e) {
                      final (_, booking) = e;
                      final status = deriveBookingStatus(booking);
                      return switch (_selectedFilterIndex) {
                        1 => status == ReservationCardStatus.active,
                        2 => status == ReservationCardStatus.upcoming,
                        3 => status == ReservationCardStatus.completed,
                        _ => true, // 0 = All
                      };
                    })
                    .map((e) => e.$1)
                    .toList();

                if (filteredIndexes.isEmpty) {
                  return Center(
                    child: Text(
                      'No reservations in this category',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: filteredIndexes.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, listIndex) {
                      final originalIndex = filteredIndexes[listIndex];
                      final booking = bookings[originalIndex];
                      final spot = spots[originalIndex];

                      return ReservationCard(
                        onTap:
                            deriveBookingStatus(booking) ==
                                ReservationCardStatus.active
                            ? () => showActiveSessionSheet(
                                context,
                                address: spot?.address ?? 'Address unavailable',
                                booking: booking,
                                onViewQrCode: () => showQrInBottomSheet(
                                  context,
                                  id: booking.spotId,
                                ),
                              )
                            : null,
                        id: booking.id!,
                        status: deriveBookingStatus(booking),
                        imageUrl:
                            (spot?.images != null && spot!.images.isNotEmpty)
                            ? spot.images.first
                            : '',
                        spotName: spot!.name,
                        address: spot.address ?? 'Address unavailable',
                        date: formatDateOnly(booking.startTime),
                        timeRange:
                            '${formatTimeOnly(booking.startTime)} - ${formatTimeOnly(booking.endTime)}',
                        totalPrice: booking.totalPrice,
                        onGetDirections: () {},
                        onBookAgain: () {
                          GoRouter.of(
                            context,
                          ).push(AppRouter.kSpotDetailsView, extra: spot);
                        },
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
