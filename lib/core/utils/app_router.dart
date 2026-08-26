import 'package:go_router/go_router.dart';
import 'package:parking/open_street_maps_toturial.dart';
import 'package:parking/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:parking/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const konBording = 'onboarding_view';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OpenStreetMapsTutorial(),
      ),
      GoRoute(
        path: konBording,
        builder: (context, state) => const OnboardingViews(),
      ),
    ],
  );
}
