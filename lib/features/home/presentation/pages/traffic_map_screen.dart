import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class TrafficMapScreen extends StatelessWidget {
  const TrafficMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Layer
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(35.4676, -97.5164), // Oklahoma City
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flowroute',
              ),
              // TODO: Add markers for traffic incidents if needed
            ],
          ),

          // Search Bar
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E24).withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                style: GoogleFonts.outfit(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search destination',
                  hintStyle: GoogleFonts.outfit(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          // Back Button (Optional, but good for navigation)
          // Positioned(
          //   top: 30,
          //   left: 16,
          //   child: CircleAvatar(
          //     backgroundColor: const Color(0xFF1E1E24),
          //     child: IconButton(
          //       icon: const Icon(Icons.arrow_back, color: Colors.white),
          //       onPressed: () => context.pop(),
          //     ),
          //   ),
          // ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.1,
            maxChildSize: 0.35,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E24).withOpacity(0.95),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle Bar
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        'Traffic in Downtown',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        'Heavy traffic on Main St due to an accident near the city center. Expect delays of up to 20 minutes.',
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Filter Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildChip('Traffic', true),
                            const SizedBox(width: 8),
                            _buildChip('Accidents', false),
                            const SizedBox(width: 8),
                            _buildChip('Road blocks', false),
                            const SizedBox(width: 8),
                            _buildChip('User reports', false),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2962FF),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Show Best Route to Destination',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF2962FF).withOpacity(0.2)
            : Colors.white10,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF2962FF) : Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: isSelected ? const Color(0xFF2962FF) : Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
