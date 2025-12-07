import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/community_providers.dart';

class FilterChipRow extends StatelessWidget {
  final CommunityFilter selectedFilter;
  final Function(CommunityFilter) onFilterSelected;

  const FilterChipRow({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterChip('All', CommunityFilter.all, const Color(0xFF2962FF)),
          _buildFilterChip(
            'Heavy',
            CommunityFilter.severe,
            const Color(0xFFCF6679),
          ),
          _buildFilterChip(
            'Medium',
            CommunityFilter.moderate,
            const Color(0xFFFFB74D),
          ),
          _buildFilterChip(
            'Light',
            CommunityFilter.light,
            const Color(0xFF81C784),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    CommunityFilter filter,
    Color activeColor,
  ) {
    final isSelected = selectedFilter == filter;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        onPressed: () => onFilterSelected(filter),
        backgroundColor: isSelected ? activeColor : const Color(0xFF2D2D3A),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (filter != CommunityFilter.all) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : activeColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
