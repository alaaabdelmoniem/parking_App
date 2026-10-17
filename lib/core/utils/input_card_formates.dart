// Input formatters
import 'package:flutter/services.dart';
import 'package:parking/core/utils/enums/card_brand_enum.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final brand = CardBrand.detect(digits);
    if (digits.length > brand.maxLength) {
      digits = digits.substring(0, brand.maxLength);
    }
    final text = brand.format(digits);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    // Typing "5" as the first digit means month 05.
    if (digits.isNotEmpty && int.parse(digits[0]) > 1) digits = '0$digits';
    if (digits.length > 4) digits = digits.substring(0, 4);

    if (digits.length >= 2) {
      final month = int.parse(digits.substring(0, 2));
      if (month < 1 || month > 12) return oldValue; // reject 00 / 13+
    }

    final text = digits.length > 2
        ? '${digits.substring(0, 2)}/${digits.substring(2)}'
        : digits;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}