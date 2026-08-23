import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset('assets/animations/FannDrop Labogini car.json'),
        ],
      ),
    );
  }
}
