import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flowroute/features/auth/presentation/providers/auth_providers.dart';
import '../providers/profile_providers.dart';
import '../providers/user_settings_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile & Settings',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            profileAsync.when(
              data: (profile) => ProfileHeader(
                name: profile?.username ?? 'User',
                email: user?.email ?? 'No Email',
                avatarUrl: profile?.avatarUrl ?? 'https://i.pravatar.cc/300',
                onEdit: _onEditProfile,
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => const Text(
                'Error loading profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),

            // Account Section
            _buildSectionHeader('ACCOUNT'),
            const SizedBox(height: 16),
            SettingsTile(
              icon: Icons.person,
              title: 'Edit Profile',
              onTap: () {
                // TODO: Create Edit Profile screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit Profile - Coming soon')),
                );
              },
            ),
            SettingsTile(
              icon: Icons.location_on,
              title: 'Saved Locations',
              onTap: () => context.push('/saved-routes'),
            ),
            SettingsTile(
              icon: Icons.security,
              title: 'Account Security',
              onTap: () => context.push('/security'),
            ),
            const SizedBox(height: 32),

            // Settings Section
            _buildSectionHeader('SETTINGS'),
            const SizedBox(height: 16),
            SettingsTile(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () => context.push('/notifications'),
            ),
            profileAsync.when(
              data: (profile) => SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Mode',
                trailing: Switch(
                  value: profile?.privateModeEnabled ?? false,
                  onChanged: (value) async {
                    if (user != null) {
                      await ref
                          .read(profileRepositoryProvider)
                          .updatePrivacyMode(user.id, value);
                      // Refresh profile
                      ref.invalidate(profileProvider);
                    }
                  },
                  activeColor: const Color(0xFF2962FF),
                ),
              ),
              loading: () => SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Mode',
                trailing: const CircularProgressIndicator(),
              ),
              error: (_, __) => SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Mode',
                trailing: Switch(
                  value: false,
                  onChanged: null,
                  activeColor: const Color(0xFF2962FF),
                ),
              ),
            ),
            ref
                .watch(userSettingsProvider)
                .when(
                  data: (settings) => SettingsTile(
                    icon: Icons.dark_mode,
                    title: 'Appearance',
                    trailing: Switch(
                      value: settings?.darkModeEnabled ?? false,
                      onChanged: (value) {
                        if (settings != null) {
                          ref
                              .read(userSettingsProvider.notifier)
                              .updateSettings(
                                settings.copyWith(darkModeEnabled: value),
                              );
                        }
                      },
                      activeColor: const Color(0xFF2962FF),
                    ),
                  ),
                  loading: () => SettingsTile(
                    icon: Icons.dark_mode,
                    title: 'Appearance',
                    trailing: const CircularProgressIndicator(),
                  ),
                  error: (_, __) => SettingsTile(
                    icon: Icons.dark_mode,
                    title: 'Appearance',
                    trailing: Switch(
                      value: false,
                      onChanged: null,
                      activeColor: const Color(0xFF2962FF),
                    ),
                  ),
                ),
            const SizedBox(height: 40),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () async {
                  await ref.read(authRepositoryProvider).signOut();
                  if (context.mounted) {
                    context.go('/auth');
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF5252), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Log Out',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFFF5252),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'FlowRoute AI v1.2.0',
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

void _onEditProfile() {
  // TODO: Implement edit profile navigation
}
