import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class PremiumServicesPage extends StatelessWidget {
  const PremiumServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<Map<String, dynamic>> premiumServices = [
      {
        'name': 'Advanced Medical Rehabilitation',
        'locations': ['RS EMC Graha Kedoya'],
        'image': 'assets/images/promo_1.png',
      },
      {
        'name': 'Cardiovascular Center',
        'locations': [
          'RS EMC Alam Sutera',
          'RS EMC Pulomas',
          'RS EMC Graha Kedoya',
        ],
        'image': 'assets/images/promo_2.png',
      },
      {
        'name': 'Digestive & Bariatric Center',
        'locations': ['RS EMC Alam Sutera', 'RS EMC Graha Kedoya'],
        'image': 'assets/images/promo_3.png',
      },
      {
        'name': 'Digestive Center',
        'locations': [
          'RS EMC Cikarang',
          'RS EMC Pulomas',
          'RS EMC Graha Kedoya',
        ],
        'image': 'assets/images/bethsaida_hospital_serang.jpg',
      },
      {
        'name': 'Fertility & Laparoscopy Center',
        'locations': ['RS EMC Pulomas'],
        'image': 'assets/images/bethsaida_hospital_gading_serpong.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Premium Services',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: false,
        actions: const [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom:
                  AppTheme.screenPaddingHorizontal +
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchField(isDarkMode),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.screenPaddingHorizontal,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: premiumServices.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final service = premiumServices[index];
                      return _PremiumServiceCard(
                        title: service['name'] as String,
                        locations: (service['locations'] as List<dynamic>)
                            .cast<String>(),
                        imagePath: service['image'] as String?,
                        isDarkMode: isDarkMode,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari layanan unggulan...',
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.grey500,
            ),
            prefixIcon: Icon(Icons.search, color: AppColors.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumServiceCard extends StatelessWidget {
  const _PremiumServiceCard({
    required this.title,
    required this.locations,
    required this.isDarkMode,
    this.imagePath,
  });

  final String title;
  final List<String> locations;
  final String? imagePath;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final hasExtra = locations.length > 2;
    final visibleLocations = locations.take(2).toList();
    final extraCount = hasExtra ? locations.length - 2 : 0;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 78,
                height: 78,
                child: imagePath != null
                    ? Image.asset(
                        imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primaryLight,
                            child: Icon(
                              Icons.photo,
                              color: AppColors.primary.withValues(alpha: 0.4),
                            ),
                          );
                        },
                      )
                    : Container(color: AppColors.primaryLight),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  ...visibleLocations.map(
                    (location) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            size: 16,
                            color: AppColors.grey600,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              location,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (hasExtra)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+$extraCount',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
