import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowroute/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/user_settings_model.dart';
import '../../data/repositories/user_settings_repository.dart';

final userSettingsRepositoryProvider = Provider<UserSettingsRepository>((ref) {
  return UserSettingsRepository();
});

final userSettingsProvider =
    StateNotifierProvider<UserSettingsNotifier, AsyncValue<UserSettingsModel?>>(
      (ref) {
        return UserSettingsNotifier(ref);
      },
    );

class UserSettingsNotifier
    extends StateNotifier<AsyncValue<UserSettingsModel?>> {
  final Ref _ref;

  UserSettingsNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = _ref.watch(currentUserProvider);
    if (user == null) {
      state = const AsyncValue.data(null);
      return;
    }

    try {
      final repository = _ref.read(userSettingsRepositoryProvider);
      var settings = await repository.getSettings(user.id);

      // If settings don't exist yet, create default
      if (settings == null) {
        settings = UserSettingsModel(
          userId: user.id,
          trafficAlertsEnabled: true,
          communityRepliesEnabled: true,
          aiSuggestionsEnabled: true,
          promotionsEnabled: true,
          darkModeEnabled: false,
        );
        // We don't necessarily need to save it to DB yet, or we could.
        // Let's just use it in UI.
      }

      state = AsyncValue.data(settings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSettings(UserSettingsModel newSettings) async {
    state = AsyncValue.data(newSettings); // Optimistic update
    try {
      await _ref
          .read(userSettingsRepositoryProvider)
          .updateSettings(newSettings);
    } catch (e, st) {
      // Revert or show error? For now, we just log it and maybe reload
      state = AsyncValue.error(e, st);
      _loadSettings(); // Reload to get correct state
    }
  }
}
