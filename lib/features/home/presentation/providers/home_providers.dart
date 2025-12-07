import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Define Home feature specific providers here
final homeStateProvider = StateProvider<int>((ref) => 0);
