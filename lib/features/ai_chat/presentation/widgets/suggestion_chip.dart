import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestionChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SuggestionChipWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        onPressed: onTap,
        backgroundColor: const Color(0xFF2D2D3A),
        label: Text(
          label,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
