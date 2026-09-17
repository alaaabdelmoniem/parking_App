import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/presentation/views/widgets/field_picker.dart';
import 'package:parking/features/map/presentation/views/widgets/session_preview_card.dart';

class DateAndTimeSection extends StatefulWidget {
  const DateAndTimeSection({super.key});

  @override
  State<DateAndTimeSection> createState() => _DateAndTimeSectionState();
}

class _DateAndTimeSectionState extends State<DateAndTimeSection> {
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _startTime = picked);
    }
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      
      initialTime: _endTime ?? _startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _endTime = picked);
    }
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'mm/dd/yyyy';
    final month = _selectedDate!.month.toString().padLeft(2, '0');
    final day = _selectedDate!.day.toString().padLeft(2, '0');
    return '$month/$day/${_selectedDate!.year}';
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '--:-- --';
    return time.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PickerField(
          label: 'Date',
          value: _formattedDate,
          icon: Icons.calendar_today_outlined,
          isPlaceholder: _selectedDate == null,
          onTap: _pickDate,
        ),
        SizedBox(height: 18.h),
        PickerField(
          label: 'Start Time',
          value: _formatTime(_startTime),
          icon: Icons.access_time,
          isPlaceholder: _startTime == null,
          onTap: _pickStartTime,
        ),
        SizedBox(height: 18.h),
        PickerField(
          label: 'End Time',
          value: _formatTime(_endTime),
          icon: Icons.access_time,
          isPlaceholder: _endTime == null,
          onTap: _pickEndTime,
        ),
        SizedBox(height: 18.h),
        if (_startTime != null &&
            _selectedDate != null &&
            _endTime != null) ...[
          SessionPreviewCard(
            startTm: _startTime!,
            endTm: _endTime!,
            date: _selectedDate!,
            totalPrice: 180,
          ),
        ],
      ],
    );
  }
}
