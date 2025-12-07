import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlternativeRouteCard extends StatelessWidget {
  final String name;
  final String timeDifference;
  final String description;
  final Color mapColor;

  const AlternativeRouteCard({
    super.key,
    required this.name,
    required this.timeDifference,
    required this.description,
    this.mapColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map Preview Placeholder
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C35),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://tile.openstreetmap.org/13/2063/3171.png',
                ), // Placeholder tile
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.map,
                color: Colors.white.withOpacity(0.2),
                size: 40,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      timeDifference,
                      style: GoogleFonts.outfit(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '· $description',
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
