import 'dart:collection';

import 'package:go_router/go_router.dart';
import 'package:parking/features/auth/presentation/views/login_view.dart';
import 'package:parking/features/auth/presentation/views/signup_view.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/map_view.dart';
import 'package:parking/features/map/presentation/views/see_all_view.dart';
import 'package:parking/features/map/presentation/views/spot_details_view.dart';
import 'package:parking/features/map/presentation/views/summary_booking_view.dart';
import 'package:parking/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:parking/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const konBording = '/onboarding_view';
  static const kLoginView = '/login_view';
  static const kSignupView = '/signup_view';
  static const kSeeAllView = '/SeeALlSpotsView';
  static const kSpotDetailsView = '/spotDetailsView';
  static const kMapView = '/Map_view';
  static const kSummaryBookingView = '/summary_booking_view';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: konBording,
        builder: (context, state) => const OnboardingViews(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kSummaryBookingView,
        builder: (context, state) => const SummaryBookingView(),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: kSeeAllView,
        builder: (context, state) => const SeeALlSpotsView(),
      ),
      GoRoute(path: kMapView, builder: (context, state) => const MapScreen()),
      GoRoute(
        path: kSpotDetailsView,
        builder: (context, state) {
          final spot = (state.extra) as SpotModel;
          return SpotDetailsView(spotModel: spot);
        },
      ),
    ],
  );
}
