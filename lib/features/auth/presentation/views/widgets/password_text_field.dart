import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, this.onChanged, this.controller});
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }

        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter';
        }

        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return 'Password must contain at least one lowercase letter';
        }

        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return 'Password must contain at least one number';
        }

        return null;
      },
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscurePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: '••••••••',
        hintStyle: TextStyle(fontSize: 15.sp, color: Colors.black38),
        prefixIcon: Icon(
          Icons.lock_outline,
          size: 18.sp,
          color: AppColors.textTertiary,
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20.sp,
            color: AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}
