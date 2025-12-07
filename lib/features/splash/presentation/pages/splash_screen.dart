import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('SplashScreen: initState');
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint('SplashScreen: Timer finished. Mounted: $mounted');
      if (mounted) {
        try {
          debugPrint('SplashScreen: Attempting navigation to /onboarding');
          context.go('/onboarding');
          debugPrint('SplashScreen: Navigation call completed');
        } catch (e) {
          debugPrint('SplashScreen: Navigation error: $e');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C3E50), // Dark Blue-Grey
              Color(0xFF4CA1AF), // Muted Teal
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder (Replace with actual asset if available)
              const Icon(
                Icons.alt_route, // Example icon
                size: 80,
                color: Colors.white,
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              const SizedBox(height: 20),
              Text(
                'FlowRoute AI',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 10),
              Text(
                'Smart, Simple Traffic Intelligence',
                style: GoogleFonts.outfit(fontSize: 16, color: Colors.white70),
              ).animate().fadeIn(delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
