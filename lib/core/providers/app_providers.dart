import 'package:flutter_riverpod/flutter_riverpod.dart';

// Example of a global provider
final appStartupProvider = FutureProvider<void>((ref) async {
  // Initialize services, load data, etc.
  await Future.delayed(const Duration(seconds: 1));
});

// Add other global providers here
