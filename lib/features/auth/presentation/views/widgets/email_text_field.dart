
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, this.onChanged});
final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged:onChanged ,
      keyboardType: TextInputType.emailAddress,
      style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,

        hintText: 'you@example.com',
        hintStyle: TextStyle(fontSize: 15.sp, color: Colors.black38),
        prefixIcon: Icon(
          Icons.mail_outline,
          size: 18.sp,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }
}