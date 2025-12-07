import 'package:flowroute/core/router/app_router.dart';
import 'package:flowroute/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flowroute/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('SplashScreen navigates to OnboardingScreen after 3 seconds', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: appRouter));

    // Initial state: Splash Screen is present
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);

    // Wait for 3 seconds (plus a little buffer for animation)
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Final state: Onboarding Screen is present
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byType(SplashScreen), findsNothing);
  });
}
