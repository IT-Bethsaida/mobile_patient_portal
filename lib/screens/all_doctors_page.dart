import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/doctor_detail_page.dart';

class AllDoctorsPage extends StatefulWidget {
  AllDoctorsPage({super.key});

  @override
  State<AllDoctorsPage> createState() => _AllDoctorsPageState();
}

class _AllDoctorsPageState extends State<AllDoctorsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> selectedSpecialties = [];
  List<String> selectedHospitals = [];
  bool? filterAvailable;

  // Data semua dokter
  final List<Map<String, dynamic>> allDoctors = const [
    {
      'name': 'Dr. Sarah Johnson, Sp.JP',
      'specialty': 'Spesialis Jantung',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.8,
      'reviews': 245,
      'experience': '15 tahun',
      'education': 'Dokter Umum, Universitas Indonesia',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Michael Chen, Sp.A',
      'specialty': 'Spesialis Anak',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.9,
      'reviews': 312,
      'experience': '10 tahun',
      'education': 'Dokter Anak, Universitas Gadjah Mada',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Amanda Williams, Sp.KK',
      'specialty': 'Spesialis Kulit & Kelamin',
      'hospital': 'Bethsaida Hospital Serang',
      'rating': 4.7,
      'reviews': 189,
      'experience': '14 tahun',
      'education': 'Dokter Kulit, Universitas Airlangga',
      'isAvailable': false,
    },
    {
      'name': 'Dr. Robert Lee, Sp.JP',
      'specialty': 'Spesialis Jantung',
      'hospital': 'Bethsaida Hospital Serang',
      'rating': 4.7,
      'reviews': 189,
      'experience': '12 tahun',
      'education': 'Dokter Jantung, Universitas Padjadjaran',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Emily Davis, Sp.A',
      'specialty': 'Spesialis Anak',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.8,
      'reviews': 267,
      'experience': '8 tahun',
      'education': 'Dokter Anak, Universitas Hasanuddin',
      'isAvailable': true,
    },
    {
      'name': 'Dr. David Wilson, Sp.OT',
      'specialty': 'Spesialis Orthopedi',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.9,
      'reviews': 298,
      'experience': '16 tahun',
      'education': 'Dokter Orthopedi, Universitas Diponegoro',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Thomas Martinez, Sp.S',
      'specialty': 'Spesialis Saraf',
      'hospital': 'Bethsaida Hospital Serang',
      'rating': 4.9,
      'reviews': 356,
      'experience': '17 tahun',
      'education': 'Dokter Saraf, Universitas Brawijaya',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Richard White, Sp.KG',
      'specialty': 'Spesialis Gigi',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.8,
      'reviews': 389,
      'experience': '18 tahun',
      'education': 'Dokter Gigi, Universitas Trisakti',
      'isAvailable': false,
    },
    {
      'name': 'Dr. Charles Robinson, Sp.M',
      'specialty': 'Spesialis Mata',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.7,
      'reviews': 234,
      'experience': '14 tahun',
      'education': 'Dokter Mata, Universitas Mataram',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Jennifer Garcia, Sp.PD',
      'specialty': 'Spesialis Penyakit Dalam',
      'hospital': 'Bethsaida Hospital Serang',
      'rating': 4.7,
      'reviews': 312,
      'experience': '14 tahun',
      'education': 'Dokter Penyakit Dalam, Universitas Sriwijaya',
      'isAvailable': true,
    },
  ];

  Set<String> get uniqueSpecialties =>
      allDoctors.map((d) => d['specialty'] as String).toSet();

  Set<String> get uniqueHospitals =>
      allDoctors.map((d) => d['hospital'] as String).toSet();

  List<Map<String, dynamic>> get filteredDoctors {
    var doctors = allDoctors;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      doctors = doctors.where((doctor) {
        final name = doctor['name'].toString().toLowerCase();
        final specialty = doctor['specialty'].toString().toLowerCase();
        final hospital = doctor['hospital'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();

        return name.contains(query) ||
            specialty.contains(query) ||
            hospital.contains(query);
      }).toList();
    }

    // Apply category filters
    if (selectedSpecialties.isNotEmpty) {
      doctors = doctors
          .where((doctor) => selectedSpecialties.contains(doctor['specialty']))
          .toList();
    }
    if (selectedHospitals.isNotEmpty) {
      doctors = doctors
          .where((doctor) => selectedHospitals.contains(doctor['hospital']))
          .toList();
    }
    if (filterAvailable != null) {
      doctors = doctors
          .where((doctor) => doctor['isAvailable'] == filterAvailable)
          .toList();
    }

    return doctors;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(
        uniqueSpecialties: uniqueSpecialties,
        uniqueHospitals: uniqueHospitals,
        selectedSpecialties: selectedSpecialties,
        selectedHospitals: selectedHospitals,
        filterAvailable: filterAvailable,
        onFiltersChanged: (specialties, hospitals, available) {
          setState(() {
            selectedSpecialties = specialties;
            selectedHospitals = hospitals;
            filterAvailable = available;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

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
          'Semua Dokter',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: _showFilterBottomSheet,
          backgroundColor: AppColors.primary,
          label: Text(
            'Filter',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.filter_list, size: 18, color: AppColors.white),
          extendedPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          // Search Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Search Field
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText:
                          'Cari nama dokter, spesialisasi, atau rumah sakit...',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.grey500,
                      ),
                      prefixIcon: Icon(Icons.search, color: AppColors.primary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: AppColors.grey500),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
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
                          'Dokter tidak ditemukan',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Coba gunakan kata kunci lain',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(
                      AppTheme.screenPaddingHorizontal,
                    ),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      return _buildDoctorCard(
                        context,
                        filteredDoctors[index],
                        isDarkMode,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context,
    Map<String, dynamic> doctor,
    bool isDarkMode,
  ) {
    final isAvailable = doctor['isAvailable'] as bool? ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to doctor detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailPage(
                doctor: doctor,
                hospital: doctor['hospital'] as String? ?? 'Unknown Hospital',
                specialty:
                    doctor['specialty'] as String? ?? 'General Practitioner',
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Doctor Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  if (isAvailable)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode
                                ? AppColors.grey800
                                : AppColors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'] as String? ?? '',
                      style: AppTypography.titleMedium.copyWith(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'] as String? ?? '',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            doctor['hospital'] as String? ?? '',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Rating
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${doctor['rating']}',
                                style: AppTypography.labelSmall.copyWith(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' (${doctor['reviews']})',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Experience
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.work_outline,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                doctor['experience'] as String? ?? '',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(Icons.chevron_right, color: AppColors.grey400),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterBottomSheet extends StatefulWidget {
  final Set<String> uniqueSpecialties;
  final Set<String> uniqueHospitals;
  final List<String> selectedSpecialties;
  final List<String> selectedHospitals;
  final bool? filterAvailable;
  final Function(List<String>, List<String>, bool?) onFiltersChanged;

  const _FilterBottomSheet({
    required this.uniqueSpecialties,
    required this.uniqueHospitals,
    required this.selectedSpecialties,
    required this.selectedHospitals,
    required this.filterAvailable,
    required this.onFiltersChanged,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late List<String> _selectedSpecialties;
  late List<String> _selectedHospitals;
  late bool? _filterAvailable;

  @override
  void initState() {
    super.initState();
    _selectedSpecialties = List.from(widget.selectedSpecialties);
    _selectedHospitals = List.from(widget.selectedHospitals);
    _filterAvailable = widget.filterAvailable;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  'Filter Dokter',
                  style: AppTypography.titleLarge.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedSpecialties.clear();
                      _selectedHospitals.clear();
                      _filterAvailable = null;
                    });
                  },
                  child: Text(
                    'Reset',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: AppColors.grey600),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Specialties
            Text(
              'Spesialisasi',
              style: AppTypography.titleMedium.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.uniqueSpecialties.map((specialty) {
                final isSelected = _selectedSpecialties.contains(specialty);
                return FilterChip(
                  label: Text(specialty),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedSpecialties.add(specialty);
                      } else {
                        _selectedSpecialties.remove(specialty);
                      }
                    });
                  },
                  backgroundColor: isDarkMode
                      ? AppColors.grey800
                      : AppColors.grey100,
                  selectedColor: AppColors.primary.withValues(alpha: 0.1),
                  checkmarkColor: AppColors.primary,
                  labelStyle: AppTypography.bodySmall.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : (isDarkMode
                              ? AppColors.white
                              : AppColors.textPrimary),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Hospitals
            Text(
              'Rumah Sakit',
              style: AppTypography.titleMedium.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.uniqueHospitals.map((hospital) {
                final isSelected = _selectedHospitals.contains(hospital);
                return FilterChip(
                  label: Text(hospital),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedHospitals.add(hospital);
                      } else {
                        _selectedHospitals.remove(hospital);
                      }
                    });
                  },
                  backgroundColor: isDarkMode
                      ? AppColors.grey800
                      : AppColors.grey100,
                  selectedColor: AppColors.primary.withValues(alpha: 0.1),
                  checkmarkColor: AppColors.primary,
                  labelStyle: AppTypography.bodySmall.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : (isDarkMode
                              ? AppColors.white
                              : AppColors.textPrimary),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Availability
            Text(
              'Ketersediaan',
              style: AppTypography.titleMedium.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: Text(
                'Hanya dokter yang tersedia',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                ),
              ),
              value: _filterAvailable ?? false,
              onChanged: (value) {
                setState(() {
                  _filterAvailable = value ? true : null;
                });
              },
              activeColor: AppColors.primary,
            ),
            const SizedBox(height: 20),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onFiltersChanged(
                    _selectedSpecialties,
                    _selectedHospitals,
                    _filterAvailable,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Terapkan Filter',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
