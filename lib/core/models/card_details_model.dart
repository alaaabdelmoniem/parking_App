import 'package:parking/core/utils/enums/card_brand_enum.dart';

class CardDetailsModel {
  const CardDetailsModel({
    required this.number,
    required this.expiry,
    required this.cvv,
    required this.brand,
  });

  final String number; // digits only
  final String expiry; // MM/YY
  final String cvv;
  final CardBrand brand;
}