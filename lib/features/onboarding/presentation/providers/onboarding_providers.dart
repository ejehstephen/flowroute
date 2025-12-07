import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Define Onboarding feature specific providers here
final onboardingIndexProvider = StateProvider<int>((ref) => 0);
