import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/oppening_houres.dart';

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = [
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

String _dayLabel(DateTime d) =>
    '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

String _timeLabel(DateTime d) =>
    '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

Future<DateTime?> showCupertinoDateTimePicker(
  BuildContext context, {
  required String title,
  DateTime? initialDateTime,
  OpeningHours? openingHours,
  int daysAhead = 21,
  int stepMinutes = 15,
}) {
  final now = DateTime.now();
  final safeInitial = (initialDateTime == null || initialDateTime.isBefore(now))
      ? now
      : initialDateTime;

  final days =
      <({DateTime day, List<DateTime> slots})>[]; //available dayes and time
  if (openingHours != null) {
    for (var i = 0; i <= daysAhead; i++) {
      final day = DateTime(now.year, now.month, now.day + i);
      final slots = openingHours
          .slotsFor(day, stepMinutes: stepMinutes)
          .where((s) => s.day == day.day && !s.isBefore(now))
          .toList();
      if (slots.isNotEmpty) days.add((day: day, slots: slots));
    }
  }

  var dayIndex = 0;
  var timeIndex = 0;

  if (openingHours != null && days.isNotEmpty) {
    final di = days.indexWhere(
      (e) =>
          e.day.year == safeInitial.year &&
          e.day.month == safeInitial.month &&
          e.day.day == safeInitial.day,
    );
    dayIndex = di == -1 ? 0 : di;
    final ti = days[dayIndex].slots.indexWhere((s) => !s.isBefore(safeInitial));
    timeIndex = ti == -1 ? 0 : ti;
  }

  final dayController = FixedExtentScrollController(initialItem: dayIndex);
  var timeController = FixedExtentScrollController(initialItem: timeIndex);
  DateTime pickedDateTime = safeInitial;

  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Widget body;

          if (openingHours == null) {
            body = CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: safeInitial,
              minimumDate: now,
              use24hFormat: true,
              onDateTimeChanged: (v) => pickedDateTime = v,
            );
          } else if (days.isEmpty) {
            body = Center(
              child: Text(
                'No available times',
                style: AppTextStyle.sheetTitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          } else {
            final slots = days[dayIndex].slots;
            body = Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CupertinoPicker(
                    scrollController: dayController,
                    itemExtent: 36.h,

                    onSelectedItemChanged: (i) => setState(() {
                      dayIndex = i;
                      timeIndex = 0;
                      timeController.dispose();
                      timeController = FixedExtentScrollController(
                        initialItem: 0,
                      );
                    }),
                    children: [
                      for (final e in days)
                        Center(
                          child: Padding(
                            padding: const EdgeInsetsGeometry.only(bottom: 3),
                            child: Text(_dayLabel(e.day)),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoPicker(
                    key: ValueKey(
                      dayIndex,
                    ), // Forces the time picker to rebuild when the selected day changes
                    scrollController: timeController,
                    itemExtent: 36.h,
                    onSelectedItemChanged: (i) => timeIndex = i,
                    children: [
                      for (final s in slots) Center(child: Text(_timeLabel(s))),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container(
            height: 360.h,
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.sheetTitle.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.close,
                          size: 22.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: body),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 8.h,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      sizeStyle: CupertinoButtonSize.medium,
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14.r),
                      onPressed: (openingHours != null && days.isEmpty)
                          ? null
                          : () => Navigator.of(context).pop(
                              openingHours == null
                                  ? pickedDateTime
                                  : days[dayIndex].slots[timeIndex],
                            ),
                      child: Text(
                        'Done',
                        style: AppTextStyle.buttonSmall.copyWith(
                          color: AppColors.textOnDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
