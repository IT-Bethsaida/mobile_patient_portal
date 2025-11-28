import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';

class PromoDetailPage extends StatelessWidget {
  final Map<String, dynamic> promo;

  const PromoDetailPage({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(
          promo['title'] as String? ?? 'Promo Detail',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promo Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          promo['title'] as String? ?? '',
                          style: AppTypography.headlineSmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          promo['discount'] as String? ?? '',
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    promo['description'] as String? ?? '',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${l10n.validUntil} ${promo['validUntil'] as String? ?? ''}',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Terms and Conditions
            Text(
              'Syarat & Ketentuan',
              style: AppTypography.titleLarge.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTermItem(
                    '• Berlaku untuk semua layanan kesehatan di Bethsaida Hospital',
                    isDarkMode,
                  ),
                  _buildTermItem(
                    '• Tidak dapat digabungkan dengan promo lainnya',
                    isDarkMode,
                  ),
                  _buildTermItem(
                    '• Wajib menunjukkan kartu identitas saat berobat',
                    isDarkMode,
                  ),
                  _buildTermItem(
                    '• Promo berlaku selama persediaan masih ada',
                    isDarkMode,
                  ),
                  _buildTermItem(
                    '• Hanya berlaku untuk pasien baru',
                    isDarkMode,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // How to Use
            Text(
              'Cara Menggunakan',
              style: AppTypography.titleLarge.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepItem(
                    1,
                    'Datang ke rumah sakit dengan membawa KTP',
                    isDarkMode,
                  ),
                  _buildStepItem(
                    2,
                    'Informasikan ingin menggunakan promo ini ke petugas',
                    isDarkMode,
                  ),
                  _buildStepItem(
                    3,
                    'Tunjukkan kode promo atau sebutkan nama promo',
                    isDarkMode,
                  ),
                  _buildStepItem(
                    4,
                    'Petugas akan memproses diskon secara otomatis',
                    isDarkMode,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Info
            Text(
              'Informasi Kontak',
              style: AppTypography.titleLarge.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
                ),
              ),
              child: Column(
                children: [
                  _buildContactItem(
                    Icons.phone,
                    'Call Center',
                    '+62 21 1234 5678',
                    isDarkMode,
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(
                    Icons.email,
                    'Email',
                    'promo@bethsaida-hospital.com',
                    isDarkMode,
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(
                    Icons.location_on,
                    'Lokasi',
                    'Jl. Raya Serpong No. 123',
                    isDarkMode,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem(String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTypography.bodyMedium.copyWith(
          color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildStepItem(int step, String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String label,
    String value,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
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
                label,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: AppTypography.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
