import 'dart:math' as math;

enum CardBrand {
  visa('VISA', 16, 3),
  mastercard('Mastercard', 16, 3),
  amex('AMEX', 15, 4),
  discover('Discover', 16,3),
  unknown('', 16, 3);

  const CardBrand(this.label, this.maxLength, this.cvvLength);

  final String label;
  final int maxLength; // card number digits
  final int cvvLength;

  /// Detects the brand from the leading digits typed so far (IIN ranges).
  static CardBrand detect(String digits) {
    if (digits.isEmpty) return unknown;
    if (digits.startsWith('4')) return visa;
    if (digits.startsWith('34') || digits.startsWith('37')) return amex;
    if (digits.startsWith('65') || digits.startsWith('6011')) return discover;

    if (digits.length >= 2) {
      final two = int.parse(digits.substring(0, 2));
      if (two >= 51 && two <= 55) return mastercard;
    }
    if (digits.length >= 3) {
      final three = int.parse(digits.substring(0, 3));
      if (three >= 644 && three <= 649) return discover;
    }
    if (digits.length >= 4) {
      final four = int.parse(digits.substring(0, 4));
      if (four >= 2221 && four <= 2720) return mastercard;
    }
    return unknown;
  }

  /// Groups digits for display: Amex is 4-6-5, everything else 4-4-4-4.
  String format(String digits) {
    final groups = this == amex ? [4, 6, 5] : [4, 4, 4, 4];
    final buffer = StringBuffer();
    var start = 0; //It determines the starting position of the part of the card number that we will read
    for (final size in groups) {
      if (start >= digits.length) break;
      final end = math.min(start + size, digits.length);
      if (start > 0) buffer.write(' ');
      buffer.write(digits.substring(start, end));
      start = end;
    }
    return buffer.toString();
  }
}