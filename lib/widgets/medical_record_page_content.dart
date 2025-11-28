import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';

class MedicalRecordPageContent extends StatelessWidget {
  const MedicalRecordPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(
          'Medical Record',
          style: AppTypography.headlineSmall.copyWith(color: AppColors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [AppColors.grey900, AppColors.grey800]
                : [AppColors.grey100, AppColors.white],
          ),
        ),
        child: Column(
          children: [
            // Medical Records List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/radiology-results'),
                    child: _buildMedicalRecordCard(
                      'Hasil Radiologi',
                      'Lihat hasil pemeriksaan radiologi seperti X-ray, CT scan, dan MRI',
                      Icons.biotech,
                      isDarkMode,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/lab-results'),
                    child: _buildMedicalRecordCard(
                      'Hasil Laboratorium',
                      'Akses hasil pemeriksaan darah, urine, dan tes laboratorium lainnya',
                      Icons.science,
                      isDarkMode,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/medications'),
                    child: _buildMedicalRecordCard(
                      'Obat Anda',
                      'Daftar resep obat dan informasi penggunaan yang direkomendasikan',
                      Icons.medication,
                      isDarkMode,
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

  Widget _buildMedicalRecordCard(
    String title,
    String description,
    IconData icon,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.grey400, size: 24),
        ],
      ),
    );
  }
}
