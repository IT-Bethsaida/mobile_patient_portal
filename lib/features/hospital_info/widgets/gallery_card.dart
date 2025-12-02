import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

/// Card widget displaying hospital gallery images
class GalleryCard extends StatelessWidget {
  final List<String> galleryImages;
  final bool isDarkMode;

  const GalleryCard({
    super.key,
    required this.galleryImages,
    required this.isDarkMode,
  });

  // Default gallery images if not provided
  static List<String> get defaultGalleryImages => [
    'images/hospital_gallery_1.png',
    'images/hospital_gallery_2.png',
    'images/hospital_gallery_3.png',
    'images/hospital_gallery_4.png',
  ];

  @override
  Widget build(BuildContext context) {
    final displayImages = galleryImages.isEmpty
        ? defaultGalleryImages
        : galleryImages;

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
              'Galeri Foto',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: displayImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: AppColors.grey200,
                    child: Image.asset(
                      displayImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
