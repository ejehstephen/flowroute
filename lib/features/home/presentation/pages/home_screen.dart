import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../../saved_routes/presentation/pages/saved_routes_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const SavedRoutesScreen();
      case 2:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Stack(
      children: [
        // Map Layer
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(35.4676, -97.5164), // Oklahoma City
            initialZoom: 13.0,
            onTap: (_, __) => context.push('/traffic-map'),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.flowroute',
            ),
          ],
        ),

        // Gradient Overlay
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF121212).withOpacity(0.9),
                  Colors.transparent,
                  Colors.transparent,
                  const Color(0xFF121212).withOpacity(0.9),
                ],
                stops: const [0.0, 0.2, 0.6, 1.0],
              ),
            ),
          ),
        ),

        // Content Layer
        SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, Alex',
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.5, end: 0),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2029),
                    borderRadius: BorderRadius.circular(16),
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
                      hintText: 'Where to?',
                      hintStyle: GoogleFonts.outfit(color: Colors.white38),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white38,
                      ),
                      suffixIcon: const Icon(
                        Icons.mic_rounded,
                        color: Colors.white38,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0),

              const Spacer(),

              // FABs (Ask Community & AI)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: 'fab_community',
                        onPressed: () => context.push('/community'),
                        backgroundColor: const Color(0xFF2D2D3A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        icon: const Icon(Icons.chat_bubble_outline_rounded),
                        label: Text(
                          'Ask Community',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: 'fab_ai',
                        onPressed: () => context.push('/ai-chat'),
                        backgroundColor: const Color(0xFF2962FF),
                        foregroundColor: Colors.white,
                        icon: const Icon(Icons.smart_toy_rounded),
                        label: Text(
                          'Ask FlowRoute AI',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.5, end: 0),

              const SizedBox(height: 26),
            ],
          ),
        ),
      ],
    );
  }
}
