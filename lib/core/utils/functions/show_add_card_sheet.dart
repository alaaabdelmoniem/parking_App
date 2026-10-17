import 'package:flutter/material.dart';
import 'package:parking/core/models/card_details_model.dart';
import 'package:parking/core/utils/widgets/add_payment_card.dart';

Future<void> showAddCardSheet(
  BuildContext context, {
  required ValueChanged<CardDetailsModel> onSubmit,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // lets the sheet rise above the keyboard
    backgroundColor: Colors.transparent,
    builder: (_) => AddPaymentCardSheet(onSubmit: onSubmit),
  );
}
