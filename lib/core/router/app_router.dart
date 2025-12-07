import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';

import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/auth/presentation/pages/forgot_password_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/traffic_map_screen.dart';
import '../../features/saved_routes/presentation/pages/saved_routes_screen.dart';
import '../../features/saved_routes/presentation/pages/route_details_screen.dart';
import '../../features/profile/presentation/pages/notifications_screen.dart';
import '../../features/profile/presentation/pages/account_security_screen.dart';

import '../../features/community/presentation/pages/community_screen.dart';
import '../../features/community/presentation/pages/question_details_screen.dart';
import '../../features/community/presentation/pages/ask_question_screen.dart';
import '../../features/ai_chat/presentation/pages/ai_chat_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final supabase = Supabase.instance.client;
    final isLoggedIn = supabase.auth.currentUser != null;
    final isGoingToAuth =
        state.matchedLocation == '/auth' ||
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/signup' ||
        state.matchedLocation == '/forgot-password';
    final isGoingToOnboarding = state.matchedLocation == '/onboarding';
    final isGoingToSplash = state.matchedLocation == '/';

    // If logged in and trying to access auth screens, redirect to home
    if (isLoggedIn && isGoingToAuth) {
      return '/home';
    }

    // If not logged in and trying to access protected routes, redirect to auth
    if (!isLoggedIn &&
        !isGoingToAuth &&
        !isGoingToOnboarding &&
        !isGoingToSplash) {
      return '/auth';
    }

    // No redirect needed
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/community',
      builder: (context, state) => const CommunityScreen(),
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return QuestionDetailsScreen(postId: id);
          },
        ),
        GoRoute(
          path: 'ask',
          builder: (context, state) => const AskQuestionScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/ai-chat',
      builder: (context, state) => const AIChatScreen(),
    ),
    GoRoute(
      path: '/traffic-map',
      builder: (context, state) => const TrafficMapScreen(),
    ),
    GoRoute(
      path: '/saved-routes',
      builder: (context, state) => const SavedRoutesScreen(),
    ),
    GoRoute(
      path: '/saved-routes/details',
      builder: (context, state) => const RouteDetailsScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/security',
      builder: (context, state) => const AccountSecurityScreen(),
    ),
  ],
);
