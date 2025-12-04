import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/search_doctor_page.dart';

class SpecialistsPage extends StatelessWidget {
  const SpecialistsPage({super.key});

  final List<Map<String, dynamic>> specialties = const [
    {'name': 'Jantung', 'image': 'assets/images/specialist/heart.png'},
    {'name': 'Anak', 'image': 'assets/images/specialist/pediatrician.png'},
    {'name': 'Mata', 'image': 'assets/images/specialist/eye.png'},
    {'name': 'Kulit', 'image': 'assets/images/specialist/skin.png'},
    {'name': 'Saraf', 'image': 'assets/images/specialist/neuron.png'},
    {'name': 'Kandungan', 'image': 'assets/images/specialist/pregnant.png'},
    {'name': 'Gigi', 'image': 'assets/images/specialist/teeth.png'},
    {'name': 'THT', 'image': 'assets/images/specialist/tht.png'},
    {'name': 'Orthopedi', 'image': 'assets/images/specialist/orthopedic.png'},
    {'name': 'Paru', 'image': 'assets/images/specialist/lungs.png'},
    {'name': 'Ginjal', 'image': 'assets/images/specialist/kidneys.png'},
  ];

  final List<Map<String, dynamic>> additionalSpecialties = const [
    {'name': 'Jiwa', 'image': 'assets/images/specialist/mental-health.png'},
    {'name': 'Bedah', 'image': 'assets/images/specialist/digital.png'},
    {'name': 'Radiologi', 'image': 'assets/images/specialist/x-ray.png'},
    {'name': 'Patologi', 'image': 'assets/images/specialist/microscope.png'},
    {'name': 'Forensik', 'image': 'assets/images/specialist/digital.png'},
    {
      'name': 'Rehabilitasi',
      'image': 'assets/images/specialist/rehabilitation.png',
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
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchDoctorPage()),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      AppColors.grey800,
                      AppColors.grey800.withValues(alpha: 0.8),
                    ]
                  : [AppColors.white, AppColors.grey100],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDarkMode
                  ? AppColors.grey700.withValues(alpha: 0.3)
                  : AppColors.grey200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.9),
                blurRadius: 6,
                offset: const Offset(-2, -2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Image.asset(
                    specialty['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.medical_services,
                        color: AppColors.primary,
                        size: 40,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Specialty Name
                Text(
                  specialty['name'],
                  style: AppTypography.bodyMedium.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOthersCard(bool isDarkMode, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showAdditionalSpecialtiesBottomSheet(context, isDarkMode),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      AppColors.grey800,
                      AppColors.grey800.withValues(alpha: 0.8),
                    ]
                  : [AppColors.white, AppColors.grey100],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDarkMode
                  ? AppColors.grey700.withValues(alpha: 0.3)
                  : AppColors.grey200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey400.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.9),
                blurRadius: 6,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Image.asset(
                    'assets/images/menu-all.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.apps_rounded,
                        color: AppColors.grey600,
                        size: 40,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // "Lainnya" Text
                Text(
                  'Lainnya',
                  style: AppTypography.bodyMedium.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.grey900 : AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.medical_services_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Spesialis Lainnya',
                    style: AppTypography.titleLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.grey100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.close, color: AppColors.grey700, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),

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
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchDoctorPage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDarkMode
                                ? [
                                    AppColors.grey800,
                                    AppColors.grey800.withValues(alpha: 0.8),
                                  ]
                                : [AppColors.white, AppColors.grey100],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isDarkMode
                                ? AppColors.grey700.withValues(alpha: 0.3)
                                : AppColors.grey200,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 52,
                                height: 52,
                                child: Image.asset(
                                  specialty['image'],
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.medical_services,
                                      color: AppColors.primary,
                                      size: 36,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                specialty['name'],
                                style: AppTypography.bodyMedium.copyWith(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
