import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final allServices = [
      {
        'icon': Icons.local_hospital,
        'label': l10n.hospitalsInformation,
        'labelKey': 'hospitalsInformation',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.person,
        'label': l10n.doctors,
        'labelKey': 'doctors',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.star,
        'label': l10n.premiumServices,
        'labelKey': 'premiumServices',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.science,
        'label': l10n.laboratory,
        'labelKey': 'laboratory',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.medical_services,
        'label': l10n.radiology,
        'labelKey': 'radiology',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.assignment,
        'label': l10n.selfTest,
        'labelKey': 'selfTest',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.payment,
        'label': l10n.selfPayment,
        'labelKey': 'selfPayment',
        'color': AppColors.grey400,
        'disabled': true,
      },
      {
        'icon': Icons.help,
        'label': l10n.quiz,
        'labelKey': 'quiz',
        'color': AppColors.grey400,
        'disabled': true,
      },
      {
        'icon': Icons.login,
        'label': l10n.selfCheckin,
        'labelKey': 'selfCheckin',
        'color': AppColors.grey400,
        'disabled': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.seeAll,
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.screenPaddingHorizontal,
          vertical: 16,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: allServices.length,
          itemBuilder: (context, index) {
            final service = allServices[index];
            final isDisabled = service['disabled'] as bool? ?? false;

            return GestureDetector(
              onTap: isDisabled
                  ? null
                  : () {
                      final labelKey = service['labelKey'] as String?;
                      if (labelKey == 'hospitalsInformation') {
                        Navigator.pushNamed(context, '/hospital-information');
                      } else if (labelKey == 'doctors') {
                        Navigator.pushNamed(context, '/select-doctor');
                      } else if (labelKey == 'laboratory') {
                        // Navigate to laboratory page
                      } else if (labelKey == 'radiology') {
                        // Navigate to radiology page
                      } else if (labelKey == 'selfTest') {
                        // Navigate to self test page
                      }
                      // Add more navigations as needed
                    },
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: isDisabled
                          ? null
                          : LinearGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: 0.1),
                                AppColors.primary.withValues(alpha: 0.2),
                              ],
                            ),
                      color: isDisabled
                          ? AppColors.grey200.withValues(alpha: 0.5)
                          : null,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      service['icon'] as IconData,
                      color: service['color'] as Color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      service['label'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelSmall.copyWith(
                        color: isDisabled
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (isDisabled)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        l10n.comingSoon,
                        textAlign: TextAlign.center,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.grey400,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
