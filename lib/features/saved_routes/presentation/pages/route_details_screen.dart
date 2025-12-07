import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/alternative_route_card.dart';

class RouteDetailsScreen extends StatelessWidget {
  const RouteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(
                6.5244,
                3.3792,
              ), // Example coordinates (Yaba, Lagos from design)
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flowroute',
              ),
              // Placeholder Polyline for "Your Route"
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      const LatLng(6.5244, 3.3792),
                      const LatLng(6.5300, 3.3850),
                      const LatLng(6.5400, 3.3900),
                      const LatLng(6.5500, 3.4000),
                    ],
                    color: const Color(0xFF00E676), // Green
                    strokeWidth: 5,
                  ),
                  Polyline(
                    points: [
                      const LatLng(6.5500, 3.4000),
                      const LatLng(6.5600, 3.4100),
                    ],
                    color: const Color(0xFFFFC107), // Amber
                    strokeWidth: 5,
                  ),
                ],
              ),
              // Markers
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(6.5244, 3.3792),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: const LatLng(6.5600, 3.4100),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Top Bar (Back Button & Title)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  Text(
                    'Your Route',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(color: Colors.black, blurRadius: 10),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
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
                      const SizedBox(height: 24),

                      // Route Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E24),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yaba, Lagos',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '10:45 AM Arrival',
                              style: GoogleFonts.outfit(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '45 min (15.3 miles)',
                              style: GoogleFonts.outfit(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // AI Suggestion Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF1A237E,
                          ).withOpacity(0.5), // Dark Blue
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF2962FF).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2962FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'AI Suggestion: Take the Yaba bypass to save 12 mins',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Alternative Routes Title
                      Text(
                        'Alternative Routes',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Alternative Routes List
                      SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            AlternativeRouteCard(
                              name: 'Ikorodu Road',
                              timeDifference: '+6 min',
                              description: 'Fewer turns',
                            ),
                            AlternativeRouteCard(
                              name: 'Third Mainland Bridge',
                              timeDifference: '+15 min',
                              description: 'Includes tolls',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Start Navigation Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Start Navigation
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2962FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Start Navigation',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24), // Bottom padding
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
}
