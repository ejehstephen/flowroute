import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatarUrl;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2C2C35), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF2C2C35),
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2962FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14),
        ),
      ],
    );
  }
}
