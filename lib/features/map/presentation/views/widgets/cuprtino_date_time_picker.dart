import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

Future<DateTime?> showCupertinoDateTimePicker(
  BuildContext context, {
  required String title,
  DateTime? initialDateTime,
}) {
  final now = DateTime.now();

  final safeInitialDateTime =
      (initialDateTime == null || initialDateTime.isBefore(now))
      ? now
      : initialDateTime;

  DateTime pickedDateTime = safeInitialDateTime;

  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) {
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

            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: safeInitialDateTime,
                minimumDate: now,
                use24hFormat: false,
                onDateTimeChanged: (value) {
                  pickedDateTime = value;
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  sizeStyle: CupertinoButtonSize.medium,
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14.r),
                  onPressed: () => Navigator.of(context).pop(pickedDateTime),
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
}
