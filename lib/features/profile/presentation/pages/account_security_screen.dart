import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class AccountSecurityScreen extends ConsumerStatefulWidget {
  const AccountSecurityScreen({super.key});

  @override
  ConsumerState<AccountSecurityScreen> createState() =>
      _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends ConsumerState<AccountSecurityScreen> {
  bool _twoFactorEnabled = true;

  void _showChangePasswordDialog() {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1E2029),
          title: Text(
            'Change Password',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => context.pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.outfit(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final newPassword = newPasswordController.text.trim();
                      final confirmPassword = confirmPasswordController.text
                          .trim();

                      if (newPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a new password'),
                          ),
                        );
                        return;
                      }

                      if (newPassword.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password must be at least 6 characters',
                            ),
                          ),
                        );
                        return;
                      }

                      if (newPassword != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                          ),
                        );
                        return;
                      }

                      setDialogState(() => isLoading = true);

                      try {
                        await ref
                            .read(authRepositoryProvider)
                            .updatePassword(newPassword);
                        if (context.mounted) {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password updated successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        if (context.mounted) {
                          setDialogState(() => isLoading = false);
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Update',
                      style: GoogleFonts.outfit(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2029),
        title: Text(
          'Delete Account',
          style: GoogleFonts.outfit(color: Colors.red),
        ),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
          style: GoogleFonts.outfit(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              context.pop(); // Close dialog

              try {
                await ref.read(authRepositoryProvider).deleteAccount();
                if (context.mounted) {
                  context.go('/auth');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Delete',
              style: GoogleFonts.outfit(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Account Security',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2029),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildSecurityTile(
                    icon: Icons.lock_rounded,
                    title: 'Change Password',
                    onTap: _showChangePasswordDialog,
                    iconColor: Colors.blueAccent,
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  _buildSwitchTile(
                    icon: Icons.security_rounded,
                    title: 'Two-Factor Authentication',
                    value: _twoFactorEnabled,
                    onChanged: (val) => setState(() => _twoFactorEnabled = val),
                    iconColor: Colors.blueAccent,
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  _buildSecurityTile(
                    icon: Icons.link_rounded,
                    title: 'Linked Accounts',
                    onTap: () {
                      // TODO: Navigate to Linked Accounts
                    },
                    iconColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _showDeleteAccountDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF2B1A1A,
                  ), // Dark Red background
                  foregroundColor: const Color(0xFFFF5252), // Red text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Delete Account',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Deleting your account is permanent and cannot be undone.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.blue,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
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
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white38,
        size: 16,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color iconColor = Colors.blue,
  }) {
    return SwitchListTile(
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
    );
  }
}
