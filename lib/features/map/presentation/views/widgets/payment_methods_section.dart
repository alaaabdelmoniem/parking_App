import 'package:flutter/material.dart';
import 'package:parking/features/map/presentation/views/widgets/payment_method_tile.dart';

class PaymentMethodsSection extends StatelessWidget {
  const PaymentMethodsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaymentMethodTile(
      icon: Icons.apple,
      title: 'Apple Pay',
      subtitle: 'Instant one-touch biometric checkout',
    );
  }
}
