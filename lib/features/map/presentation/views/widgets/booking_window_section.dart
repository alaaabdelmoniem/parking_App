
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/map/presentation/views/widgets/cancel_banner.dart';
import 'package:parking/features/map/presentation/views/widgets/cuprtino_date_time_picker.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_booking_date_and_time.dart';

class BookingWindowSection extends StatefulWidget {
  const BookingWindowSection({
    super.key,
    required this.cancelUntilText,
  });


  final String cancelUntilText;



  @override
  State<BookingWindowSection> createState() => _BookingWindowSectionState();
}

class _BookingWindowSectionState extends State<BookingWindowSection> {
  DateTime? _selectedStartDateTime;
  DateTime? _selectedEndDateTime;
  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not set';

    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '${weekdays[dateTime.weekday - 1]}, ${months[dateTime.month - 1]} '
        '${dateTime.day} · $hour12:$minute $period';
  }

  Future<void> _openStartTimePicker() async {
    final result = await showCupertinoDateTimePicker(
      context,
      title: 'Start Time',
      initialDateTime: _selectedStartDateTime,
    );
    if (result != null) {
      setState(() => _selectedStartDateTime = result);
    }
  }

  Future<void> _openEndTimePicker() async {
    final result = await showCupertinoDateTimePicker(
      context,
      title: 'End Time',
      initialDateTime: _selectedEndDateTime,
    );
    if (result != null) {
      setState(() => _selectedEndDateTime = result);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomBookingDateAndTime(
                  label: 'Enter After',
                  dateText: formatDateTime(_selectedStartDateTime),
                  onChange: _openStartTimePicker,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: VerticalDivider(
                  color: AppColors.textBody.withValues(alpha: .1),
                  thickness: 1,
                  width: 1,
                ),
              ),
              Expanded(
                child: CustomBookingDateAndTime(
                  label: 'Exit Before',
                  dateText: formatDateTime(_selectedEndDateTime),
                  onChange: _openEndTimePicker,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        CancelPolicyBanner(text: widget.cancelUntilText),
      ],
    );
  }
}
