import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/saved_route_card.dart';

class SavedRoutesScreen extends StatelessWidget {
  const SavedRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Saved Routes',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E24),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // TODO: Implement add saved route
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SavedRouteCard(
            name: 'Home to Work',
            distance: '12 miles',
            trafficStatus: 'Light Traffic',
            trafficColor: const Color(0xFF00E676), // Green
            duration: '25 min',
            onStart: () => context.push('/saved-routes/details'),
          ),
          SavedRouteCard(
            name: 'Gym',
            distance: '5 miles',
            trafficStatus: 'Medium Traffic',
            trafficColor: const Color(0xFFFFC107), // Amber
            duration: '18 min',
            onStart: () => context.push('/saved-routes/details'),
          ),
          SavedRouteCard(
            name: 'Airport',
            distance: '28 miles',
            trafficStatus: 'High Traffic',
            trafficColor: const Color(0xFFFF5252), // Red
            duration: '55 min',
            onStart: () => context.push('/saved-routes/details'),
          ),
        ],
      ),
    );
  }
}
