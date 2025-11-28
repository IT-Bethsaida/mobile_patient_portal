import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class RadiologyResultsPage extends StatelessWidget {
  const RadiologyResultsPage({super.key});

  final List<Map<String, dynamic>> radiologyResults = const [
    {
      'date': '2024-11-25',
      'type': 'X-Ray Thorax',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'doctor': 'Dr. Sarah Johnson',
      'result': 'Normal',
      'description':
          'Pemeriksaan X-ray thorax menunjukkan hasil normal tanpa kelainan.',
    },
    {
      'date': '2024-10-15',
      'type': 'CT Scan Abdomen',
      'hospital': 'Bethsaida Hospital Serang',
      'doctor': 'Dr. Michael Chen',
      'result': 'Ada Kelainan',
      'description': 'CT scan menunjukkan adanya batu ginjal di ginjal kanan.',
    },
    {
      'date': '2024-09-08',
      'type': 'MRI Brain',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'doctor': 'Dr. Amanda Williams',
      'result': 'Normal',
      'description':
          'MRI otak menunjukkan hasil normal tanpa kelainan signifikan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(
          'Hasil Radiologi',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        itemCount: radiologyResults.length,
        itemBuilder: (context, index) {
          return _buildRadiologyCard(radiologyResults[index], isDarkMode);
        },
      ),
    );
  }

  Widget _buildRadiologyCard(Map<String, dynamic> result, bool isDarkMode) {
    final resultColor = result['result'] == 'Normal'
        ? AppColors.success
        : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                result['type'] as String,
                style: AppTypography.titleMedium.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: resultColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result['result'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: resultColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Tanggal: ${result['date']}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Dokter: ${result['doctor']}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Rumah Sakit: ${result['hospital']}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            result['description'] as String,
            style: AppTypography.bodyMedium.copyWith(
              color: isDarkMode ? AppColors.grey200 : AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
