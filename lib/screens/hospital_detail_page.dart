import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class HospitalDetailPage extends StatelessWidget {
  final Map<String, dynamic> hospital;

  const HospitalDetailPage({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<Map<String, String>> operationalHours = [
      {'name': 'Unit Gawat Darurat (UGD)', 'hours': '24 Jam'},
      {'name': 'Jam Buka Poli', 'hours': '08:00 - 21:00'},
      {'name': 'Jam Besuk Pasien', 'hours': '17:00 - 19:00'},
    ];

    final List<Map<String, dynamic>> facilities = [
      {'icon': Icons.emergency, 'label': 'UGD 24\nJam'},
      {'icon': Icons.science, 'label': 'Laboratorium'},
      {'icon': Icons.medication, 'label': 'Farmasi'},
      {'icon': Icons.medical_services, 'label': 'Radiologi'},
    ];

    final List<String> galleryImages = [
      'images/hospital_gallery_1.png',
      'images/hospital_gallery_2.png',
      'images/hospital_gallery_3.png',
      'images/hospital_gallery_4.png',
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Rumah Sakit',
          style: AppTypography.titleLarge.copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              height: 220,
              width: double.infinity,
              color: AppColors.grey200,
              child: Image.asset(
                hospital['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    child: Center(
                      child: Icon(
                        Icons.local_hospital,
                        color: AppColors.primary,
                        size: 64,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Hospital Info Section
            Padding(
              padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital Name
                  Text(
                    hospital['name'],
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    title: 'Alamat',
                    content: hospital['address'],
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    title: 'Nomor Telepon',
                    content: hospital['phone'],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement phone call
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDark,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Panggil Sekarang',
                            style: AppTypography.button.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Implement maps
                          },
                          icon: Icon(
                            Icons.map_outlined,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            'Lihat Peta',
                            style: AppTypography.button.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Operational Hours Section
                  Text(
                    'Jam Operasional',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...operationalHours.map(
                    (hour) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hour['name']!,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            hour['hours']!,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Facilities Section
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
                    children: facilities.map((facility) {
                      return Column(
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
                          Text(
                            facility['label'],
                            textAlign: TextAlign.center,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textPrimary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Gallery Section
                  Text(
                    'Galeri Foto',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.2,
                        ),
                    itemCount: galleryImages.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: AppColors.grey200,
                          child: Image.asset(
                            galleryImages[index],
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
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
