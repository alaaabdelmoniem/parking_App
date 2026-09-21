import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, this.onChanged, this.controller});
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        var emailRegex = RegExp(
          r"^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
        );
        if (!emailRegex.hasMatch(value ?? '')) {
          return 'Invalid Email';
        }
        return null;
      },
      controller:controller ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
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
