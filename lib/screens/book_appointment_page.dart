import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/select_doctor_page.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  String? _selectedHospital;
  String? _selectedSpecialty;

  // Mock data - In real app, this would come from API
  final Map<String, List<String>> hospitalSpecialties = {
    'Bethsaida Hospital Gading Serpong': [
      'Cardiologist',
      'Pediatrician',
      'Dermatologist',
      'Orthopedic',
      'General Practitioner',
      'Dentist',
      'Ophthalmologist',
    ],
    'Bethsaida Hospital Serang': [
      'Neurologist',
      'Pediatrician',
      'Orthopedic',
      'General Practitioner',
      'Dentist',
    ],
  };

  List<String> get availableSpecialties {
    if (_selectedHospital == null) return [];
    return hospitalSpecialties[_selectedHospital] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(
          'Book Appointment',
          style: AppTypography.headlineMedium.copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Select hospital and specialty to find available doctors',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Hospital Selection
            Text(
              'Select Hospital',
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...hospitalSpecialties.keys.map((hospital) {
              final isSelected = _selectedHospital == hospital;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.grey800 : AppColors.white,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.grey300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedHospital = hospital;
                      _selectedSpecialty = null; // Reset specialty
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.local_hospital,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            hospital,
                            style: AppTypography.titleMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Specialty Selection
            Text(
              'Select Specialty',
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            if (_selectedHospital == null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Please select a hospital first',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              GestureDetector(
                onTap: () => _showSpecialtyBottomSheet(context, isDarkMode),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedSpecialty != null
                          ? AppColors.primary
                          : AppColors.grey400,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedSpecialty ?? 'Select a specialty',
                        style: AppTypography.bodyMedium.copyWith(
                          color: _selectedSpecialty == null
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          fontWeight: _selectedSpecialty != null
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: AppColors.primary),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    (_selectedHospital != null && _selectedSpecialty != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectDoctorPage(
                              hospital: _selectedHospital!,
                              specialty: _selectedSpecialty!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: AppColors.grey400,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Find Doctors',
                      style: AppTypography.button.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSpecialtyBottomSheet(BuildContext context, bool isDarkMode) {
    String localSearchQuery = '';

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: isDarkMode ? AppColors.grey800 : AppColors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          List<String> filteredSpecialties = availableSpecialties
              .where(
                (specialty) => specialty.toLowerCase().contains(
                  localSearchQuery.toLowerCase(),
                ),
              )
              .toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Specialty',
                          style: AppTypography.titleLarge.copyWith(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Search Field
                    TextField(
                      onChanged: (value) {
                        setModalState(() {
                          localSearchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search specialty',
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? AppColors.grey700
                            : AppColors.grey100,
                      ),
                    ),
                  ],
                ),
              ),
              // Specialty List
              SizedBox(
                height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredSpecialties.length,
                  itemBuilder: (context, index) {
                    final specialty = filteredSpecialties[index];
                    final isSelected = _selectedSpecialty == specialty;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : (isDarkMode
                                    ? AppColors.grey700
                                    : AppColors.grey300),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSpecialty = specialty;
                          });
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                specialty,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check, color: AppColors.primary),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
