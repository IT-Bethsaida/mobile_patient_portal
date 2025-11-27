import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/doctor_detail_page.dart';

class SearchDoctorPage extends StatefulWidget {
  const SearchDoctorPage({super.key});

  @override
  State<SearchDoctorPage> createState() => _SearchDoctorPageState();
}

class _SearchDoctorPageState extends State<SearchDoctorPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Data dokter rekomendasi
  final List<Map<String, dynamic>> recommendedDoctors = [
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
  ];

  // Data semua dokter
  final List<Map<String, dynamic>> allDoctors = [
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

  List<Map<String, dynamic>> get filteredDoctors {
    if (_searchQuery.isEmpty) return [];

    return allDoctors.where((doctor) {
      final name = doctor['name'].toString().toLowerCase();
      final specialty = doctor['specialty'].toString().toLowerCase();
      final hospital = doctor['hospital'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      return name.contains(query) ||
          specialty.contains(query) ||
          hospital.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          'Cari Dokter',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
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
            child: _searchQuery.isEmpty
                ? _buildRecommendedDoctors(isDarkMode)
                : _buildSearchResults(isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedDoctors(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          // Section Title
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text(
                'Rekomendasi Dokter',
                style: AppTypography.titleLarge.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Dokter pilihan dengan rating tertinggi',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Recommended Doctors List
          ...recommendedDoctors.map(
            (doctor) => _buildDoctorCard(doctor, isDarkMode),
          ),

          const SizedBox(height: 24),

          // Popular Specialties Section
          Text(
            'Spesialisasi Populer',
            style: AppTypography.titleLarge.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildSpecialtyChips(),
        ],
      ),
    );
  }

  Widget _buildSearchResults(bool isDarkMode) {
    if (filteredDoctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.grey400),
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
              style: AppTypography.bodySmall.copyWith(color: AppColors.grey500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        return _buildDoctorCard(filteredDoctors[index], isDarkMode);
      },
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor, bool isDarkMode) {
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

  Widget _buildSpecialtyChips() {
    final specialties = [
      {'name': 'Jantung', 'icon': Icons.favorite},
      {'name': 'Anak', 'icon': Icons.child_care},
      {'name': 'Kulit', 'icon': Icons.face},
      {'name': 'Orthopedi', 'icon': Icons.accessibility_new},
      {'name': 'Saraf', 'icon': Icons.psychology},
      {'name': 'Gigi', 'icon': Icons.sentiment_satisfied},
      {'name': 'Mata', 'icon': Icons.visibility},
      {'name': 'Penyakit Dalam', 'icon': Icons.medical_services},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: specialties.map((specialty) {
        return InkWell(
          onTap: () {
            setState(() {
              _searchController.text = specialty['name'] as String;
              _searchQuery = specialty['name'] as String;
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  specialty['icon'] as IconData,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  specialty['name'] as String,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
