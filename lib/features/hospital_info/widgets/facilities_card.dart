import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

/// Card widget displaying hospital facilities
class FacilitiesCard extends StatelessWidget {
  final List<Map<String, dynamic>> facilities;
  final bool isDarkMode;

  const FacilitiesCard({
    super.key,
    required this.facilities,
    required this.isDarkMode,
  });

  // Default facilities if not provided
  static List<Map<String, dynamic>> get defaultFacilities => [
    {'icon': Icons.emergency, 'label': 'UGD 24\nJam'},
    {'icon': Icons.science, 'label': 'Laboratorium'},
    {'icon': Icons.medication, 'label': 'Farmasi'},
    {'icon': Icons.medical_services, 'label': 'Radiologi'},
  ];

  @override
  Widget build(BuildContext context) {
    final displayFacilities = facilities.isEmpty
        ? defaultFacilities
        : facilities;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.screenPaddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fasilitas Unggulan',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: displayFacilities.map((facility) {
                return SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          facility['icon'],
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          facility['label'],
                          textAlign: TextAlign.center,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
