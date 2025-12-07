import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';
import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileProvider = FutureProvider<ProfileModel?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  return ref.watch(profileRepositoryProvider).getProfile(user.id);
});
