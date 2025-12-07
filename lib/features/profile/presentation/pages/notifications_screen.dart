import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_settings_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(userSettingsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: settingsAsync.when(
        data: (settings) {
          if (settings == null) {
            return const Center(
              child: Text(
                'Please log in',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('GENERAL ALERTS'),
                const SizedBox(height: 16),
                _buildNotificationTile(
                  icon: Icons.traffic_rounded,
                  title: 'Traffic Alerts',
                  value: settings.trafficAlertsEnabled,
                  onChanged: (val) {
                    ref
                        .read(userSettingsProvider.notifier)
                        .updateSettings(
                          settings.copyWith(trafficAlertsEnabled: val),
                        );
                  },
                  iconColor: Colors.blueAccent,
                ),
                const SizedBox(height: 12),
                _buildNotificationTile(
                  icon: Icons.smart_toy_rounded,
                  title: 'AI Suggestions',
                  value: settings.aiSuggestionsEnabled,
                  onChanged: (val) {
                    ref
                        .read(userSettingsProvider.notifier)
                        .updateSettings(
                          settings.copyWith(aiSuggestionsEnabled: val),
                        );
                  },
                  iconColor: Colors.blueAccent,
                ),
                const SizedBox(height: 32),
                _buildSectionHeader('COMMUNITY'),
                const SizedBox(height: 16),
                _buildNotificationTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Community Replies',
                  value: settings.communityRepliesEnabled,
                  onChanged: (val) {
                    ref
                        .read(userSettingsProvider.notifier)
                        .updateSettings(
                          settings.copyWith(communityRepliesEnabled: val),
                        );
                  },
                  iconColor: Colors.blueAccent,
                ),
                const SizedBox(height: 32),
                _buildSectionHeader('OTHER'),
                const SizedBox(height: 16),
                _buildNotificationTile(
                  icon: Icons.campaign_rounded,
                  title: 'Promotions',
                  value: settings.promotionsEnabled,
                  onChanged: (val) {
                    ref
                        .read(userSettingsProvider.notifier)
                        .updateSettings(
                          settings.copyWith(promotionsEnabled: val),
                        );
                  },
                  iconColor: Colors.purpleAccent,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: Colors.white54,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color iconColor = Colors.blue,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2029),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF2962FF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
