import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/hospital_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalInformationPage extends StatelessWidget {
  const HospitalInformationPage({super.key});

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

    final List<Map<String, dynamic>> hospitals = [
      {
        'name': 'Bethsaida Hospital Gading Serpong',
        'description':
            'Adalah salah satu unit bisnis dari Paramount Enterprise International dan merupakan Hospital Umum pertama di wilayah Gading Serpong yang diresmikan pada tanggal 12 Desember 2012. Bethsaida Hospital didirikan untuk memenuhi kebutuhan layanan kesehatan bagi masyarakat di seluruh Indonesia, khususnya wilayah provinsi Banten, Jakarta Barat dan Jakarta Selatan yang berbatasan dengan wilayah Tangerang dan sekitarnya. Bethsaida Hospital juga berupaya agar pengobatan pasien dapat dilayani dengan tuntas (One Stop Services).',
        'image': 'assets/images/bethsaida_hospital_gading_serpong.jpg',
        'phone': '021-29309999',
        'address':
            'Jalan Boulevard Raya Gading Serpong Kav. 29 Gading Serpong, Curug Sangereng, Kelapa Dua, Tangerang Regency, Banten 15810',
      },
      {
        'name': 'Bethsaida Hospital Serang',
        'description':
            'Bethsaida Hospital serang adalah salah satu unit bisnis dari PT Paramount Enterprise International yang telah diresmikan pada tanggal 8 Agustus 2024. Bethsaida Hospital didirikan untuk memenuhi kebutuhan layanan kesehatan bagi masyarakat di wilayah Serang, Cilegon dan sekitarnya. Hal ini tentunya kami persiapkan dengan pemenuhan SDM medis-paramedis serta peralatan canggih untuk menunjang terapi pengobatan yang lebih cepat dan lebih tepat. Bethsaida Hospital Serang juga berupaya agar pengobatan pasien dapat dilayani dengan tuntas dan paripurna (One Stop Services).',
        'image': 'assets/images/bethsaida_hospital_serang.jpg',
        'phone': '0254-5020-999',
        'address':
            'Jl. Lingkar Selatan Cilegon, Desa No.KM. 1, RW.08, Harjatani, Kec. Kramatwatu, Kabupaten Serang, Banten 42161',
      },
    ];

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
          'Hospital Information',
          style: AppTypography.headlineSmall.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HospitalDetailPage(hospital: hospital),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode ? AppColors.grey800 : AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital Image with Gradient Overlay
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          color: AppColors.grey200,
                          child: Image.asset(
                            hospital['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primary.withValues(alpha: 0.1),
                                      AppColors.primary.withValues(alpha: 0.2),
                                    ],
                                  ),
                                ),
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
                        ),
                      ),
                      // Gradient overlay for better text readability
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Hospital name overlay
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Text(
                          hospital['name'],
                          style: AppTypography.titleLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Hospital Info
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description
                        Text(
                          hospital['description'],
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Contact Info Cards
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.grey700
                                : AppColors.grey100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDarkMode
                                  ? AppColors.grey600
                                  : AppColors.grey200,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Phone
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      size: 20,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone',
                                          style: AppTypography.labelSmall
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                        Text(
                                          hospital['phone'],
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.textPrimary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Address
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      size: 20,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address',
                                          style: AppTypography.labelSmall
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                        Text(
                                          hospital['address'],
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.textPrimary,
                                                height: 1.4,
                                              ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          children: [
                            // Call Button
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _makePhoneCall(context, hospital['phone']),
                                icon: const Icon(Icons.phone, size: 20),
                                label: Text(
                                  'Call Hospital',
                                  style: AppTypography.button.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Directions Button
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _openMaps(
                                  context,
                                  hospital['name'],
                                  hospital['address'],
                                ),
                                icon: const Icon(Icons.directions, size: 18),
                                label: Text(
                                  'Directions',
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: BorderSide(color: AppColors.primary),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
