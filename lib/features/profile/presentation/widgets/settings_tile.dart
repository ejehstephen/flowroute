import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color iconBackgroundColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.iconColor = const Color(0xFF2962FF),
    this.iconBackgroundColor = const Color(0xFF1A237E),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBackgroundColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing:
            trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 16,
            ),
      ),
    );
  }
}
