import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class MedicationsPage extends StatelessWidget {
  const MedicationsPage({super.key});

  final List<Map<String, dynamic>> medications = const [
    {
      'name': 'Amoxicillin',
      'dosage': '500 mg',
      'frequency': '3x sehari',
      'duration': '7 hari',
      'instructions': 'Minum setelah makan',
      'doctor': 'Dr. Sarah Johnson',
      'prescribedDate': '2024-11-25',
      'status': 'Aktif',
    },
    {
      'name': 'Ibuprofen',
      'dosage': '400 mg',
      'frequency': '3x sehari',
      'duration': '5 hari',
      'instructions': 'Minum saat dibutuhkan untuk nyeri',
      'doctor': 'Dr. Michael Chen',
      'prescribedDate': '2024-11-20',
      'status': 'Aktif',
    },
    {
      'name': 'Omeprazole',
      'dosage': '20 mg',
      'frequency': '1x sehari',
      'duration': '30 hari',
      'instructions': 'Minum 30 menit sebelum makan',
      'doctor': 'Dr. Amanda Williams',
      'prescribedDate': '2024-10-15',
      'status': 'Selesai',
    },
    {
      'name': 'Vitamin D3',
      'dosage': '1000 IU',
      'frequency': '1x sehari',
      'duration': '90 hari',
      'instructions': 'Minum dengan makanan',
      'doctor': 'Dr. Robert Lee',
      'prescribedDate': '2024-09-10',
      'status': 'Aktif',
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
          'Obat Anda',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        itemCount: medications.length,
        itemBuilder: (context, index) {
          return _buildMedicationCard(medications[index], isDarkMode);
        },
      ),
    );
  }

  Widget _buildMedicationCard(
    Map<String, dynamic> medication,
    bool isDarkMode,
  ) {
    final statusColor = medication['status'] == 'Aktif'
        ? AppColors.success
        : AppColors.textSecondary;

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
              Expanded(
                child: Text(
                  medication['name'] as String,
                  style: AppTypography.titleMedium.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  medication['status'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.medication, size: 16, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                '${medication['dosage']} - ${medication['frequency']}',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.grey200 : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                'Durasi: ${medication['duration']}',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Instruksi: ${medication['instructions']}',
            style: AppTypography.bodySmall.copyWith(
              color: isDarkMode ? AppColors.grey200 : AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Diresepkan oleh: ${medication['doctor']}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tanggal resep: ${medication['prescribedDate']}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
