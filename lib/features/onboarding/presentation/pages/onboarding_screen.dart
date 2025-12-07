import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    const OnboardingContent(
      title: 'Check Traffic Instantly',
      description: 'Get real-time traffic updates before you even leave.',
      gradientColors: [
        Color(0xFF0F2027),
        Color(0xFF203A43),
        Color(0xFF2C5364),
      ], // Dark Blue-Green
      icon: Icons.traffic_rounded,
    ),
    const OnboardingContent(
      title: 'Ask Community or AI',
      description:
          'Get real-time traffic solutions from fellow drivers or our smart AI assistant.',
      gradientColors: [Color(0xFF232526), Color(0xFF414345)], // Dark Grey
      icon: Icons.people_alt_rounded,
    ),
    const OnboardingContent(
      title: 'Get the Best Routes, Always',
      description:
          'Smart routing that adapts to live traffic conditions to save you time.',
      gradientColors: [Color(0xFF1A2980), Color(0xFF26D0CE)], // Blue to Cyan
      icon: Icons.map_rounded,
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToNextPage() {
    if (_currentPage < _contents.length - 1) {
      _pageController.nextPage(duration: 300.ms, curve: Curves.easeInOut);
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: 500.ms,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _contents[_currentPage].gradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.outfit(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _contents.length,
                  itemBuilder: (context, index) {
                    final content = _contents[index];
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              content.icon,
                              size: 80,
                              color: Colors.white,
                            ),
                          ).animate().scale(
                            duration: 400.ms,
                            curve: Curves.easeOutBack,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            content.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 16),
                          Text(
                            content.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ).animate().fadeIn(delay: 200.ms),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _contents.length,
                  (index) => AnimatedContainer(
                    duration: 300.ms,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.blue
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2962FF), // Bright Blue
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 8,
                      shadowColor: Colors.black26,
                    ),
                    child: Text(
                      _currentPage == _contents.length - 1
                          ? 'Get Started'
                          : 'Continue',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
