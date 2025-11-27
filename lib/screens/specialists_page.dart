import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/search_doctor_page.dart';

class SpecialistsPage extends StatelessWidget {
  const SpecialistsPage({super.key});

  final List<Map<String, dynamic>> specialties = const [
    {'name': 'Jantung', 'icon': Icons.favorite, 'color': Colors.red},
    {'name': 'Anak', 'icon': Icons.child_care, 'color': Colors.blue},
    {'name': 'Mata', 'icon': Icons.visibility, 'color': Colors.purple},
    {'name': 'Kulit', 'icon': Icons.spa, 'color': Colors.pink},
    {'name': 'Saraf', 'icon': Icons.psychology, 'color': Colors.orange},
    {'name': 'Kandungan', 'icon': Icons.pregnant_woman, 'color': Colors.green},
    {'name': 'Gigi', 'icon': Icons.medical_services, 'color': Colors.teal},
    {'name': 'THT', 'icon': Icons.hearing, 'color': Colors.indigo},
    {'name': 'Orthopedi', 'icon': Icons.accessible, 'color': Colors.brown},
    {'name': 'Paru', 'icon': Icons.air, 'color': Colors.cyan},
    {'name': 'Ginjal', 'icon': Icons.water_drop, 'color': Colors.lightBlue},
  ];

  final List<Map<String, dynamic>> additionalSpecialties = const [
    {'name': 'Jiwa', 'icon': Icons.psychology_alt, 'color': Colors.deepPurple},
    {'name': 'Bedah', 'icon': Icons.healing, 'color': Colors.redAccent},
    {'name': 'Radiologi', 'icon': Icons.biotech, 'color': Colors.blueGrey},
    {'name': 'Patologi', 'icon': Icons.science, 'color': Colors.amber},
    {'name': 'Forensik', 'icon': Icons.gavel, 'color': Colors.grey},
    {
      'name': 'Rehabilitasi',
      'icon': Icons.accessibility_new,
      'color': Colors.tealAccent,
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Spesialis',
          style: AppTypography.titleLarge.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppTheme.screenPaddingHorizontal,
            AppTheme.screenPaddingHorizontal,
            AppTheme.screenPaddingHorizontal,
            AppTheme.screenPaddingHorizontal +
                MediaQuery.of(context).padding.bottom,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: specialties.length + 1, // 11 specialties + 1 "Lainnya"
            itemBuilder: (context, index) {
              if (index < specialties.length) {
                final specialty = specialties[index];
                return _buildSpecialtyCard(specialty, isDarkMode, context);
              } else {
                // "Lainnya" card
                return _buildOthersCard(isDarkMode, context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtyCard(
    Map<String, dynamic> specialty,
    bool isDarkMode,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        // Navigate to search doctor page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchDoctorPage()),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: specialty['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  specialty['icon'],
                  color: specialty['color'],
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),

              // Specialty Name
              Text(
                specialty['name'],
                style: AppTypography.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOthersCard(bool isDarkMode, BuildContext context) {
    return InkWell(
      onTap: () => _showAdditionalSpecialtiesBottomSheet(context, isDarkMode),
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.grey400.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.more_horiz,
                  color: AppColors.grey600,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),

              // "Lainnya" Text
              Text(
                'Lainnya',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdditionalSpecialtiesBottomSheet(
    BuildContext context,
    bool isDarkMode,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'Spesialis Lainnya',
                    style: AppTypography.titleLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: AppColors.grey600),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Additional Specialties Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: additionalSpecialties.length,
                itemBuilder: (context, index) {
                  final specialty = additionalSpecialties[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close bottom sheet
                      // Navigate to search doctor page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchDoctorPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.grey800
                            : AppColors.grey100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: specialty['color'].withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                specialty['icon'],
                                color: specialty['color'],
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              specialty['name'],
                              style: AppTypography.bodyMedium.copyWith(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
