import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedRouteCard extends StatelessWidget {
  final String name;
  final String distance;
  final String trafficStatus;
  final Color trafficColor;
  final String duration;
  final VoidCallback onStart;

  const SavedRouteCard({
    super.key,
    required this.name,
    required this.distance,
    required this.trafficStatus,
    required this.trafficColor,
    required this.duration,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Name + Distance
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: trafficColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      distance,
                      style: GoogleFonts.outfit(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Traffic Status
          Text(
            trafficStatus,
            style: GoogleFonts.outfit(
              color: trafficColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),

          // Duration + Start Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                duration,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2962FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Start',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
