import 'package:flutter/material.dart';

class OnboardingContent {
  final String title;
  final String description;
  final List<Color> gradientColors;
  final IconData icon;

  const OnboardingContent({
    required this.title,
    required this.description,
    required this.gradientColors,
    required this.icon,
  });
}
