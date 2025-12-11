import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final allServices = [
      {
        'icon': LucideIcons.building2,
        'label': l10n.hospitalsInformation,
        'labelKey': 'hospitalsInformation',
      },
      {
        'icon': LucideIcons.stethoscope,
        'label': l10n.doctors,
        'labelKey': 'doctors',
      },
      {
        'icon': LucideIcons.sparkles,
        'label': l10n.premiumServices,
        'labelKey': 'premiumServices',
      },
      {
        'icon': LucideIcons.flaskConical,
        'label': l10n.laboratory,
        'labelKey': 'laboratory',
      },
      {
        'icon': LucideIcons.scan,
        'label': l10n.radiology,
        'labelKey': 'radiology',
      },
      {
        'icon': LucideIcons.clipboardList,
        'label': l10n.selfTest,
        'labelKey': 'selfTest',
      },
      {
        'icon': LucideIcons.creditCard,
        'label': l10n.selfPayment,
        'labelKey': 'selfPayment',
        'disabled': true,
      },
      {
        'icon': LucideIcons.clipboardCheck,
        'label': l10n.quiz,
        'labelKey': 'quiz',
        'disabled': true,
      },
      {
        'icon': LucideIcons.logIn,
        'label': l10n.selfCheckin,
        'labelKey': 'selfCheckin',
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
                      color: isDisabled ? AppColors.grey300 : AppColors.primary,
                      boxShadow: isDisabled
                          ? null
                          : [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                    ),
                    child: Stack(
                      children: [
                        // Subtle radial gradient overlay for depth
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: RadialGradient(
                                center: Alignment.topLeft,
                                radius: 1.5,
                                colors: [
                                  Colors.white.withValues(alpha: 0.15),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Icon centered
                        Center(
                          child: Icon(
                            service['icon'] as IconData,
                            color: isDisabled
                                ? AppColors.grey600
                                : AppColors.white,
                            size: 36,
                          ),
                        ),
                      ],
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
