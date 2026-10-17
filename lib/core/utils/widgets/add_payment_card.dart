import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/models/card_details_model.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';
import 'package:parking/core/utils/enums/card_brand_enum.dart';
import 'package:parking/core/utils/input_card_formates.dart';
import 'package:parking/core/utils/widgets/input_box_payment.dart';

class AddPaymentCardSheet extends StatefulWidget {
  const AddPaymentCardSheet({super.key, required this.onSubmit});

  final ValueChanged<CardDetailsModel> onSubmit;

  @override
  State<AddPaymentCardSheet> createState() => _AddPaymentCardSheetState();
}

class _AddPaymentCardSheetState extends State<AddPaymentCardSheet> {
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  String get _digits => _numberController.text.replaceAll(RegExp(r'\D'), '');
  CardBrand get _brand => CardBrand.detect(_digits);

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  bool get _expiryValid {
    final text = _expiryController.text;
    if (text.length != 5) return false;
    final month = int.parse(text.substring(0, 2));
    final year = 2000 + int.parse(text.substring(3));
    // A card is valid through the last day of its expiry month.
    return DateTime(year, month + 1, 1).isAfter(DateTime.now());
  }

  bool get _isValid {
    final numberOk = _digits.length == _brand.maxLength;
    final cvvOk = _cvvController.text.length == _brand.cvvLength;
    return numberOk && _expiryValid && cvvOk;
  }

  void _onNumberChanged(String _) {
    final max = _brand.cvvLength;
    if (_cvvController.text.length > max) {
      _cvvController.text = _cvvController.text.substring(0, max);
    }
    setState(() {});
  }

  void _submit() {
    widget.onSubmit(
      CardDetailsModel(
        number: _digits,
        expiry: _expiryController.text,
        cvv: _cvvController.text,
        brand: _brand,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final brand = _brand;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'Add Card',
                style: AppTextStyle.sheetTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Enter your card details.',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20.h),

              // Card number + brand label
              const _FieldLabel('Card number'),
              SizedBox(height: 8.h),
              InputBoxPayment(
                controller: _numberController,
                hint: '0000 0000 0000 0000',
                formatters: [CardNumberFormatter()],
                onChanged: _onNumberChanged,
                suffix: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: brand == CardBrand.unknown
                      ? const SizedBox.shrink(key: ValueKey('none'))
                      : Padding(
                          key: ValueKey(brand),
                          padding: EdgeInsets.only(right: 18.w),
                          child: Text(
                            brand.label,
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontStyle: brand == CardBrand.visa
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16.h),

              // Expiry + CVV
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel('Expiry date'),
                        SizedBox(height: 8.h),
                        InputBoxPayment(
                          controller: _expiryController,
                          hint: 'MM/YY',
                          formatters: [ExpiryFormatter()],
                          onChanged: (_) => setState(() {}),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel('CVV'),
                        SizedBox(height: 8.h),
                        InputBoxPayment(
                          controller: _cvvController,
                          hint: '000',
                          formatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(brand.cvvLength),
                          ],
                          onChanged: (_) => setState(() {}),
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _isValid ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnDark,
                    disabledBackgroundColor: AppColors.border,
                    disabledForegroundColor: AppColors.textTertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Add Card',
                    style: AppTextStyle.buttonSmall.copyWith(fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
