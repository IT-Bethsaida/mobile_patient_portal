import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailPage extends StatefulWidget {
  final Map<String, dynamic> hospital;

  const HospitalDetailPage({super.key, required this.hospital});

  @override
  State<HospitalDetailPage> createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  late ScrollController _scrollController;
  bool _isAppBarVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Show appBar background when scrolled past 150px
    final shouldShowAppBar = _scrollController.offset > 150;
    if (shouldShowAppBar != _isAppBarVisible) {
      setState(() {
        _isAppBarVisible = shouldShowAppBar;
      });
    }
  }

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[()\-\s]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);

    try {
      await launchUrl(phoneUri);
    } catch (e) {
      // Handle error silently or show a message
    }
  }

  Future<void> _openMaps(
    BuildContext context,
    String name,
    String address,
  ) async {
    // Combine hospital name with address for more specific search results
    final searchQuery = '$name, $address';
    final encodedQuery = Uri.encodeComponent(searchQuery);
    final Uri mapsUri = Uri.parse('geo:0,0?q=$encodedQuery');

    try {
      await launchUrl(mapsUri);
    } catch (e) {
      // Fallback: try to open in browser if maps app fails
      try {
        final Uri fallbackUri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$encodedQuery',
        );
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } catch (fallbackError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to open maps. Please check your internet connection.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<Map<String, String>> operationalHours = [
      {'name': 'Unit Gawat Darurat (UGD)', 'hours': '24 Jam'},
      {'name': 'Jam Buka Poli', 'hours': '08:00 - 21:00'},
      {'name': 'Jam Besuk Pasien', 'hours': '17:00 - 19:00'},
    ];

    final List<Map<String, dynamic>> facilities = [
      {'icon': Icons.emergency, 'label': 'UGD 24\nJam'},
      {'icon': Icons.science, 'label': 'Laboratorium'},
      {'icon': Icons.medication, 'label': 'Farmasi'},
      {'icon': Icons.medical_services, 'label': 'Radiologi'},
    ];

    final List<String> galleryImages = [
      'images/hospital_gallery_1.png',
      'images/hospital_gallery_2.png',
      'images/hospital_gallery_3.png',
      'images/hospital_gallery_4.png',
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _isAppBarVisible
            ? (isDarkMode ? AppColors.grey800 : AppColors.primary)
            : Colors.transparent,
        foregroundColor: _isAppBarVisible
            ? (isDarkMode ? AppColors.white : AppColors.textPrimary)
            : AppColors.white,
        elevation: _isAppBarVisible ? 2 : 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Rumah Sakit',
          style: AppTypography.titleLarge.copyWith(
            color: _isAppBarVisible
                ? (isDarkMode ? AppColors.white : AppColors.white)
                : AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image with Gradient Overlay
            Container(
              height: 220,
              width: double.infinity,
              color: AppColors.grey200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.hospital['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        child: Center(
                          child: Icon(
                            Icons.local_hospital,
                            color: AppColors.primary,
                            size: 64,
                          ),
                        ),
                      );
                    },
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Hospital Info Section
            Container(
              margin: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hospital Name
                    Text(
                      widget.hospital['name'],
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Address
                    _buildInfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Alamat',
                      content: widget.hospital['address'],
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    _buildInfoRow(
                      icon: Icons.phone_outlined,
                      title: 'Nomor Telepon',
                      content: widget.hospital['phone'],
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.phone, size: 20),
                            onPressed: () => _makePhoneCall(
                              context,
                              widget.hospital['phone'],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            label: Text(
                              'Panggil Sekarang',
                              style: AppTypography.button.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _openMaps(
                              context,
                              widget.hospital['name'],
                              widget.hospital['address'],
                            ),
                            icon: Icon(
                              Icons.map_outlined,
                              color: AppColors.primary,
                            ),
                            label: Text(
                              'Lihat Peta',
                              style: AppTypography.button.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primary),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Operational Hours Section
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.screenPaddingHorizontal,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jam Operasional',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...operationalHours.map(
                      (hour) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hour['name']!,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              hour['hours']!,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Facilities Section
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.screenPaddingHorizontal,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fasilitas Unggulan',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: facilities.map((facility) {
                        return SizedBox(
                          height: 100, // Fixed height for consistent alignment
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  facility['icon'],
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Text(
                                  facility['label'],
                                  textAlign: TextAlign.center,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Gallery Section
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.screenPaddingHorizontal,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Galeri Foto',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        height: 1.0, // Tighter line height
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: galleryImages.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: AppColors.grey200,
                            child: Image.asset(
                              galleryImages[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: AppColors.primary,
                                      size: 32,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
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
                title,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
