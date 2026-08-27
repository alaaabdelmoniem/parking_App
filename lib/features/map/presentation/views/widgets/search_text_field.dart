import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onScanTap;
  final VoidCallback? onMicTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const LocationSearchBar({
    super.key,
    this.hintText = "Downtown San Francisco",
    this.onScanTap,
    this.onMicTap,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,

        style: TextStyle(fontSize: 15.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15.sp, color: Colors.black54),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),

          prefixIcon: IconButton(
            onPressed: onScanTap,
            icon: Icon(
              Icons.qr_code_scanner,
              color: const Color(0xFF1A73E8),
              size: 22.sp,
            ),
          ),

          suffixIcon: IconButton(
            onPressed: onMicTap,
            icon: Icon(
              Icons.mic_none_outlined,
              color: Colors.black54,
              size: 22.sp,
            ),
          ),
        ),
      ),
    );
  }
}
