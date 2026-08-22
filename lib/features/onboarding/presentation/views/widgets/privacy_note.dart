
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyNote extends StatelessWidget {
  const PrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3FB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFFC3C6D4).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline, size: 14.sp, color: const Color(0xFF424752)),
          SizedBox(width: 6.w),
          Text(
            'Your location is only used while you use the app',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF424752)),
          ),
        ],
      ),
    );
  }
}


