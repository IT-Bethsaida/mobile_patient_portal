import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';
import 'package:patient_portal/screens/promo_detail_page.dart';

class AllPromosPage extends StatelessWidget {
  const AllPromosPage({super.key});

  final List<Map<String, dynamic>> allPromos = const [
    {
      'title': 'Medical Check-up',
      'discount': '30% OFF',
      'description': 'Comprehensive health screening',
      'validUntil': '31 Dec 2024',
      'image': 'assets/images/promo_1.png',
    },
    {
      'title': 'Dental Care',
      'discount': '25% OFF',
      'description': 'Dental cleaning & whitening',
      'validUntil': '15 Dec 2024',
      'image': 'assets/images/promo_2.png',
    },
    {
      'title': 'Eye Examination',
      'discount': '20% OFF',
      'description': 'Complete eye check-up',
      'validUntil': '30 Nov 2024',
      'image': 'assets/images/promo_3.png',
    },
    {
      'title': 'Cardiology Consultation',
      'discount': '15% OFF',
      'description': 'Heart health consultation',
      'validUntil': '20 Dec 2024',
      'image': 'assets/images/promo_1.png',
    },
    {
      'title': 'Vaccination Package',
      'discount': '40% OFF',
      'description': 'Complete vaccination package',
      'validUntil': '10 Jan 2025',
      'image': 'assets/images/promo_2.png',
    },
    {
      'title': 'Laboratory Tests',
      'discount': '35% OFF',
      'description': 'Blood and urine tests',
      'validUntil': '05 Dec 2024',
      'image': 'assets/images/promo_3.png',
    },
  ];

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
          l10n.specialPromo,
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        itemCount: allPromos.length,
        itemBuilder: (context, index) {
          final promo = allPromos[index];
          return _buildPromoCard(context, promo, isDarkMode, l10n);
        },
      ),
    );
  }

  Widget _buildPromoCard(
    BuildContext context,
    Map<String, dynamic> promo,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.7)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PromoDetailPage(promo: promo),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      promo['title'] as String? ?? '',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      promo['discount'] as String? ?? '',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                promo['description'] as String? ?? '',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${l10n.validUntil} ${promo['validUntil'] as String? ?? ''}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
