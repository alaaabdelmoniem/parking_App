import 'package:go_router/go_router.dart';
import 'package:parking/features/onboarding/presentation/views/onboarding_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kChatView = '/ChatView';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const OnboardingViews()),
    ],
  );
}
