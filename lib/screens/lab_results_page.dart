import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class LabResultsPage extends StatelessWidget {
  const LabResultsPage({super.key});

  final List<Map<String, dynamic>> labResults = const [
    {
      'date': '2024-11-20',
      'type': 'Tes Darah Lengkap',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'doctor': 'Dr. Sarah Johnson',
      'status': 'Normal',
      'parameters': [
        {
          'name': 'Hemoglobin',
          'value': '14.2 g/dL',
          'range': '12-16 g/dL',
          'status': 'Normal',
        },
        {
          'name': 'Leukosit',
          'value': '7.8 x10³/µL',
          'range': '4-11 x10³/µL',
          'status': 'Normal',
        },
        {
          'name': 'Trombosit',
          'value': '280 x10³/µL',
          'range': '150-400 x10³/µL',
          'status': 'Normal',
        },
      ],
    },
    {
      'date': '2024-10-10',
      'type': 'Tes Fungsi Ginjal',
      'hospital': 'Bethsaida Hospital Serang',
      'doctor': 'Dr. Michael Chen',
      'status': 'Perlu Perhatian',
      'parameters': [
        {
          'name': 'Creatinine',
          'value': '1.8 mg/dL',
          'range': '0.6-1.2 mg/dL',
          'status': 'Tinggi',
        },
        {
          'name': 'Urea',
          'value': '45 mg/dL',
          'range': '15-40 mg/dL',
          'status': 'Tinggi',
        },
        {
          'name': 'eGFR',
          'value': '45 mL/min',
          'range': '>60 mL/min',
          'status': 'Rendah',
        },
      ],
    },
    {
      'date': '2024-09-05',
      'type': 'Tes Fungsi Hati',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'doctor': 'Dr. Amanda Williams',
      'status': 'Normal',
      'parameters': [
        {
          'name': 'SGOT',
          'value': '25 U/L',
          'range': '10-40 U/L',
          'status': 'Normal',
        },
        {
          'name': 'SGPT',
          'value': '30 U/L',
          'range': '7-56 U/L',
          'status': 'Normal',
        },
        {
          'name': 'Bilirubin Total',
          'value': '0.8 mg/dL',
          'range': '0.3-1.2 mg/dL',
          'status': 'Normal',
        },
      ],
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
          'Hasil Laboratorium',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        itemCount: labResults.length,
        itemBuilder: (context, index) {
          return _buildLabCard(labResults[index], isDarkMode);
        },
      ),
    );
  }

  Widget _buildLabCard(Map<String, dynamic> result, bool isDarkMode) {
    final statusColor = result['status'] == 'Normal'
        ? AppColors.success
        : AppColors.warning;

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
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result['status'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: statusColor,
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
            'Parameter:',
            style: AppTypography.bodyMedium.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ..._buildParameterList(result['parameters'] as List, isDarkMode),
        ],
      ),
    );
  }

  List<Widget> _buildParameterList(List parameters, bool isDarkMode) {
    return parameters.map<Widget>((param) {
      final paramColor = param['status'] == 'Normal'
          ? AppColors.success
          : AppColors.error;
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                param['name'],
                style: AppTypography.bodySmall.copyWith(
                  color: isDarkMode ? AppColors.grey200 : AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                param['value'],
                style: AppTypography.bodySmall.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                param['range'],
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: paramColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                param['status'],
                style: AppTypography.bodySmall.copyWith(
                  color: paramColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
