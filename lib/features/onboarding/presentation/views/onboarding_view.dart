import 'package:flutter/material.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/custom_page_view.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/onboarding_1.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/onboarding_2.dart';
import 'package:parking/features/onboarding/presentation/views/widgets/onboarding_3.dart';

class OnboardingViews extends StatelessWidget {
  const OnboardingViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CustomPageView());
  }
}
