// import 'dart:async';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:parking/core/routers/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  static const _appName = 'ParkNow'; //
  static const _tagline = 'Find, book & park in seconds';

  late final AnimationController _controller;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();

    _navTimer = Timer(const Duration(milliseconds: 3000), _navigate);
  }

  void _navigate() {
    if (!mounted) return;

    final router = GoRouter.of(context);
    final firstOpen = CacheHelper.getValue(key: CacheKeys.firstOpen);

    if (firstOpen == null) {
      CacheHelper.setValue(key: CacheKeys.firstOpen, value: 1);
      router.pushReplacement(AppRouter.konBording);
      return;
    }

    final uid = CacheHelper.getValue(key: CacheKeys.uId);
    log('uid:$uid');
    router.pushReplacement(
      uid == null ? AppRouter.kLoginView : AppRouter.kMainScreen,
    );
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _letterAnimation(int index) {
    final start = (index * 0.07).clamp(0.0, 0.6);
    final end = (start + 0.35).clamp(0.0, 0.95);
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.easeOutBack),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 0.85, curve: Curves.easeOutCubic),
    );
    final taglineAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.75, 1, curve: Curves.easeOut),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              Color.alphaBlend(
                Colors.black.withValues(alpha: 0.28),
                AppColors.primary,
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < _appName.length; i++)
                      _AnimatedLetter(
                        letter: _appName[i],
                        animation: _letterAnimation(i),
                      ),
                  ],
                ),
                SizedBox(height: 10.h),

                AnimatedBuilder(
                  animation: lineAnim,
                  builder: (_, _) => Container(
                    width: 120.w * lineAnim.value,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),

                // Tagline
                FadeTransition(
                  opacity: taglineAnim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(taglineAnim),
                    child: Text(
                      _tagline,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedLetter extends StatelessWidget {
  const _AnimatedLetter({required this.letter, required this.animation});

  final String letter;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        final t = animation.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 28.h),
            child: Transform.scale(scale: 0.7 + 0.3 * t, child: child),
          ),
        );
      },
      child: Text(
        letter == ' ' ? '\u00A0' : letter,
        style: AppTextStyle.sheetTitle.copyWith(
          color: Colors.white,
          fontSize: 44.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
