import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/hospital_detail_page.dart';

class HospitalInformationPageContent extends StatelessWidget {
  const HospitalInformationPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<Map<String, dynamic>> hospitals = [
      {
        'name': 'Bethsaida Hospital Gading Serpong',
        'description':
            'Adalah salah satu unit bisnis dari Paramount Enterprise International dan merupakan Hospital Umum pertama di wilayah Gading Serpong yang diresmikan pada tanggal 12 Desember 2012. Bethsaida Hospital didirikan untuk memenuhi kebutuhan layanan kesehatan bagi masyarakat di seluruh Indonesia, khususnya wilayah provinsi Banten, Jakarta Barat dan Jakarta Selatan yang berbatasan dengan wilayah Tangerang dan sekitarnya. Bethsaida Hospital juga berupaya agar pengobatan pasien dapat dilayani dengan tuntas (One Stop Services).',
        'image': 'assets/images/bethsaida_hospital_gading_serpong.jpg',
        'phone': '021-29309999',
        'address':
            'Jalan Boulevard Raya Gading Serpong Kav. 29 Gading Serpong, Curug Sangereng, Kelapa Dua, Tangerang Regency, Banten 15810',
      },
      {
        'name': 'Bethsaida Hospital Serang',
        'description':
            'ethsaida Hospital serang adalah salah satu unit bisnis dari PT Paramount Enterprise International yang telah diresmikan pada tanggal 8 Agustus 2024. Bethsaida Hospital didirikan untuk memenuhi kebutuhan layanan kesehatan bagi masyarakat di wilayah Serang, Cilegon dan sekitarnya. Hal ini tentunya kami persiapkan dengan pemenuhan SDM medis-paramedis serta peralatan canggih untuk menunjang terapi pengobatan yang lebih cepat dan lebih tepat. Bethsaida Hospital Serang juga berupaya agar pengobatan pasien dapat dilayani dengan tuntas dan paripurna (One Stop Services).',
        'image': 'assets/images/bethsaida_hospital_serang.jpg',
        'phone': '0254-5020-999',
        'address':
            'Jl. Lingkar Selatan KM. 1,8, Ds Harjatani, Kec. Kramatwatu, Serang – Banten 42161',
      },
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Lokasi Rumah Sakit Kami',
          style: AppTypography.titleLarge.copyWith(color: AppColors.white),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          left: AppTheme.screenPaddingHorizontal,
          right: AppTheme.screenPaddingHorizontal,
          top: AppTheme.screenPaddingHorizontal,
          bottom:
              MediaQuery.of(context).padding.bottom +
              kBottomNavigationBarHeight +
              AppTheme.screenPaddingHorizontal,
        ),
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HospitalDetailPage(hospital: hospital),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey300.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      height: 160,
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
                                size: 48,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Hospital Info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hospital['name'],
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hospital['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              icon: Icons.phone,
                              label: 'Telepon',
                              onTap: () {
                                // TODO: Implement phone call
                              },
                            ),
                            _buildActionButton(
                              icon: Icons.directions,
                              label: 'Arah',
                              onTap: () {
                                // TODO: Implement directions
                              },
                            ),
                            _buildActionButton(
                              icon: Icons.more_horiz,
                              label: 'Detail',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HospitalDetailPage(hospital: hospital),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
