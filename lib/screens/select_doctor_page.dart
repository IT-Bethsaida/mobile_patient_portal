import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/doctor_detail_page.dart';

class SelectDoctorPage extends StatefulWidget {
  final String hospital;
  final String specialty;

  const SelectDoctorPage({
    super.key,
    required this.hospital,
    required this.specialty,
  });

  @override
  State<SelectDoctorPage> createState() => _SelectDoctorPageState();
}

class _SelectDoctorPageState extends State<SelectDoctorPage> {
  String _searchQuery = '';

  // Mock data - In real app, this would come from API
  final Map<String, Map<String, List<Map<String, dynamic>>>>
  doctorsByHospitalAndSpecialty = {
    'Bethsaida Hospital Gading Serpong': {
      'Cardiologist': [
        {
          'name': 'Dr. Sarah Johnson',
          'experience': '15 years',
          'rating': 4.8,
          'reviews': 245,
          'education': 'MD - Cardiology, Harvard Medical School',
        },
        {
          'name': 'Dr. Robert Lee',
          'experience': '12 years',
          'rating': 4.7,
          'reviews': 189,
          'education': 'MD - Cardiology, Stanford University',
        },
      ],
      'Pediatrician': [
        {
          'name': 'Dr. Michael Chen',
          'experience': '10 years',
          'rating': 4.9,
          'reviews': 312,
          'education': 'MD - Pediatrics, Johns Hopkins University',
        },
        {
          'name': 'Dr. Emily Davis',
          'experience': '8 years',
          'rating': 4.8,
          'reviews': 267,
          'education': 'MD - Pediatrics, Yale School of Medicine',
        },
      ],
      'Dermatologist': [
        {
          'name': 'Dr. Amanda Williams',
          'experience': '14 years',
          'rating': 4.7,
          'reviews': 189,
          'education': 'MD - Dermatology, Columbia University',
        },
        {
          'name': 'Dr. James Brown',
          'experience': '11 years',
          'rating': 4.6,
          'reviews': 156,
          'education': 'MD - Dermatology, UCLA',
        },
      ],
      'Orthopedic': [
        {
          'name': 'Dr. David Wilson',
          'experience': '16 years',
          'rating': 4.9,
          'reviews': 298,
          'education': 'MD - Orthopedic Surgery, Mayo Clinic',
        },
      ],
      'General Practitioner': [
        {
          'name': 'Dr. John Smith',
          'experience': '20 years',
          'rating': 4.8,
          'reviews': 432,
          'education': 'MD - Family Medicine, University of Michigan',
        },
        {
          'name': 'Dr. Mary Johnson',
          'experience': '13 years',
          'rating': 4.7,
          'reviews': 301,
          'education': 'MD - Family Medicine, Duke University',
        },
      ],
      'Dentist': [
        {
          'name': 'Dr. Richard White',
          'experience': '18 years',
          'rating': 4.8,
          'reviews': 389,
          'education': 'DDS - University of Pennsylvania',
        },
      ],
      'Ophthalmologist': [
        {
          'name': 'Dr. Charles Robinson',
          'experience': '14 years',
          'rating': 4.7,
          'reviews': 234,
          'education': 'MD - Ophthalmology, Wills Eye Hospital',
        },
        {
          'name': 'Dr. Nancy Clark',
          'experience': '9 years',
          'rating': 4.6,
          'reviews': 178,
          'education': 'MD - Ophthalmology, Bascom Palmer Eye Institute',
        },
      ],
    },
    'Bethsaida Hospital Serang': {
      'Neurologist': [
        {
          'name': 'Dr. Thomas Martinez',
          'experience': '17 years',
          'rating': 4.9,
          'reviews': 356,
          'education': 'MD - Neurology, Cleveland Clinic',
        },
        {
          'name': 'Dr. Patricia Taylor',
          'experience': '12 years',
          'rating': 4.8,
          'reviews': 287,
          'education': 'MD - Neurology, UCSF',
        },
      ],
      'Pediatrician': [
        {
          'name': 'Dr. Lisa Anderson',
          'experience': '11 years',
          'rating': 4.8,
          'reviews': 298,
          'education': 'MD - Pediatrics, Boston Children\'s Hospital',
        },
        {
          'name': 'Dr. William Garcia',
          'experience': '9 years',
          'rating': 4.7,
          'reviews': 223,
          'education': 'MD - Pediatrics, Children\'s Hospital of Philadelphia',
        },
      ],
      'Orthopedic': [
        {
          'name': 'Dr. David Wilson',
          'experience': '16 years',
          'rating': 4.9,
          'reviews': 298,
          'education': 'MD - Orthopedic Surgery, Mayo Clinic',
        },
        {
          'name': 'Dr. Lisa Anderson',
          'experience': '11 years',
          'rating': 4.8,
          'reviews': 298,
          'education': 'MD - Orthopedic Surgery, Hospital for Special Surgery',
        },
      ],
      'General Practitioner': [
        {
          'name': 'Dr. Jennifer Garcia',
          'experience': '14 years',
          'rating': 4.7,
          'reviews': 312,
          'education': 'MD - Family Medicine, Northwestern University',
        },
        {
          'name': 'Dr. Michael Brown',
          'experience': '10 years',
          'rating': 4.6,
          'reviews': 245,
          'education': 'MD - Family Medicine, Vanderbilt University',
        },
      ],
      'Dentist': [
        {
          'name': 'Dr. Richard White',
          'experience': '18 years',
          'rating': 4.8,
          'reviews': 389,
          'education': 'DDS - University of Pennsylvania',
        },
        {
          'name': 'Dr. Nancy Clark',
          'experience': '9 years',
          'rating': 4.6,
          'reviews': 178,
          'education': 'DDS - Harvard School of Dental Medicine',
        },
      ],
    },
  };

  List<Map<String, dynamic>> get filteredDoctors {
    final doctors =
        doctorsByHospitalAndSpecialty[widget.hospital]?[widget.specialty] ?? [];

    if (_searchQuery.isEmpty) return doctors;

    return doctors
        .where(
          (doctor) => doctor['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Doctor',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.specialty,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Hospital Info Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.local_hospital, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.hospital,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search doctor by name',
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: isDarkMode ? AppColors.grey800 : AppColors.grey100,
              ),
            ),
          ),

          // Doctor List
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.grey400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No doctors found',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.screenPaddingHorizontal,
                    ),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return _buildDoctorCard(doctor, isDarkMode);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        border: Border.all(
          color: isDarkMode ? AppColors.grey700 : AppColors.grey300,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailPage(
                doctor: doctor,
                hospital: widget.hospital,
                specialty: widget.specialty,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Icon(Icons.person, size: 36, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: AppTypography.titleMedium.copyWith(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor['experience'],
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${doctor['rating']} (${doctor['reviews']} reviews)',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
