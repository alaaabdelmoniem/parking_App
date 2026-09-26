import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/utils/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      final firstOpen = CacheHelper.getValue(key: CacheKeys.firstOpen);
      if (firstOpen == null) {
        CacheHelper.setValue(key: CacheKeys.firstOpen, value: 1);
        GoRouter.of(context).pushReplacement(AppRouter.konBording);
      } else {
        final uid = CacheHelper.getValue(key: CacheKeys.uId);
        if (uid == null) {
          log('uid:$uid ');
          GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        } else {
          log('uid:$uid ');

          GoRouter.of(context).pushReplacement(AppRouter.kMapView);
        }
      }
    });
    super.initState();
  }

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
