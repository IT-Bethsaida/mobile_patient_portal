import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:patient_portal/screens/doctor_detail_page.dart';
import 'package:patient_portal/screens/promo_detail_page.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  int _currentCarouselIndex = 0;

  final List<String> carouselImages = [
    'assets/images/promo_1.png',
    'assets/images/promo_2.png',
    'assets/images/promo_3.png',
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.8,
      'reviews': 245,
      'experience': '15 tahun',
      'education': 'Dokter Umum, Universitas Indonesia',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Pediatrician',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'rating': 4.9,
      'reviews': 312,
      'experience': '10 tahun',
      'education': 'Dokter Anak, Universitas Gadjah Mada',
      'isAvailable': true,
    },
    {
      'name': 'Dr. Amanda Williams',
      'specialty': 'Dermatologist',
      'hospital': 'Bethsaida Hospital Serang',
      'rating': 4.7,
      'reviews': 189,
      'experience': '14 tahun',
      'education': 'Dokter Kulit, Universitas Airlangga',
      'isAvailable': false,
    },
  ];

  final List<Map<String, dynamic>> promos = [
    {
      'title': 'Medical Check-up',
      'discount': '30% OFF',
      'description': 'Comprehensive health screening',
      'validUntil': '31 Dec 2024',
    },
    {
      'title': 'Dental Care',
      'discount': '25% OFF',
      'description': 'Dental cleaning & whitening',
      'validUntil': '15 Dec 2024',
    },
    {
      'title': 'Eye Examination',
      'discount': '20% OFF',
      'description': 'Complete eye check-up',
      'validUntil': '30 Nov 2024',
    },
  ];

  Future<void> _refreshData() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    // Reset carousel index or refresh data
    setState(() {
      _currentCarouselIndex = 0;
    });
  }

  List<Map<String, dynamic>> _getMenuItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
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
        'icon': Icons.apps,
        'label': l10n.seeAll,
        'labelKey': 'seeAll',
        'color': AppColors.primary,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final menuItems = _getMenuItems(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          // add bottom padding so content can't overflow behind the BottomNavigationBar
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight +
                12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurvedHeader(context, l10n),
              const SizedBox(height: 16),
              // Carousel Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                  ),
                  items: carouselImages.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isDarkMode
                                ? AppColors.grey800
                                : AppColors.grey100,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: AppColors.primary,
                                      size: 48,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

              // Carousel Indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    carouselImages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentCarouselIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentCarouselIndex == index
                            ? AppColors.primary
                            : AppColors.grey300,
                      ),
                    ),
                  ),
                ),
              ),

              // Featured Section
              const SizedBox(height: 10),

              // Action Buttons Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.screenPaddingHorizontal,
                ),
                child: Row(
                  children: [
                    // Search Doctor Button
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to doctor search page
                          Navigator.pushNamed(context, '/search-doctor');
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.grey300,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey400.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 20,
                                  color: AppColors.grey600,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  l10n.searchDoctor,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.grey600,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Emergency Button
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to emergency page
                            Navigator.pushNamed(context, '/emergency');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: AppColors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          icon: const Icon(Icons.local_hospital, size: 20),
                          label: Text(
                            l10n.emergency,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Menu Grid Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.screenPaddingHorizontal,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    // Make each grid tile a bit taller to accommodate 2-line labels
                    childAspectRatio: 0.75,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final isDisabled = item['disabled'] ?? false;

                    return GestureDetector(
                      onTap: isDisabled
                          ? null
                          : () {
                              // Navigate based on menu item labelKey
                              final labelKey = item['labelKey'] as String?;
                              if (labelKey == 'hospitalsInformation') {
                                Navigator.pushNamed(
                                  context,
                                  '/hospital-information',
                                );
                              } else if (labelKey == 'doctors') {
                                Navigator.pushNamed(context, '/specialists');
                              } else if (labelKey == 'premiumServices') {
                                Navigator.pushNamed(
                                  context,
                                  '/premium-services',
                                );
                              } else if (labelKey == 'seeAll') {
                                Navigator.pushNamed(context, '/all-services');
                              }
                            },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: isDisabled
                                  ? null
                                  : LinearGradient(
                                      colors: [
                                        AppColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                        AppColors.primary.withValues(
                                          alpha: 0.2,
                                        ),
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
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              item['icon'],
                              color: item['color'],
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Flexible(
                            child: Text(
                              item['label'],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSmall.copyWith(
                                color: isDisabled
                                    ? AppColors.textSecondary
                                    : AppColors.textPrimary,
                                fontSize: 11,
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
                                  fontSize: 9,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Our Doctors Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.screenPaddingHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.ourDoctors,
                          style: AppTypography.titleLarge.copyWith(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/all-doctors');
                          },
                          child: Text(
                            l10n.seeAll,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetailPage(
                                    doctor: doctor,
                                    hospital:
                                        doctor['hospital'] as String? ??
                                        'Unknown Hospital',
                                    specialty:
                                        doctor['specialty'] as String? ??
                                        'General Practitioner',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              margin: EdgeInsets.only(
                                right: index < doctors.length - 1 ? 16 : 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isDarkMode
                                    ? AppColors.grey800
                                    : AppColors.white,
                                border: Border.all(
                                  color: isDarkMode
                                      ? AppColors.grey700
                                      : AppColors.grey300,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: AppColors.primary
                                          .withValues(alpha: 0.1),
                                      child: Icon(
                                        Icons.person,
                                        size: 40,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      doctor['name'] as String? ?? 'Unknown',
                                      style: AppTypography.titleSmall.copyWith(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.textPrimary,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor['specialty'] as String? ?? '',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${doctor['rating'] ?? 0.0}',
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.textPrimary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          ' (${doctor['reviews'] ?? 0})',
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Promo Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.screenPaddingHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.specialPromo,
                          style: AppTypography.titleLarge.copyWith(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/all-promos');
                          },
                          child: Text(
                            l10n.seeAll,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: promos.length,
                        itemBuilder: (context, index) {
                          final promo = promos[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PromoDetailPage(promo: promo),
                                ),
                              );
                            },
                            child: Container(
                              width: 280,
                              margin: EdgeInsets.only(
                                right: index < promos.length - 1 ? 16 : 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withValues(alpha: 0.7),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            promo['title'] as String? ?? '',
                                            style: AppTypography.titleMedium
                                                .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            promo['discount'] as String? ?? '',
                                            style: AppTypography.bodySmall
                                                .copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      promo['description'] as String? ?? '',
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: AppColors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${l10n.validUntil} ${promo['validUntil'] as String? ?? ''}',
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                color: AppColors.white
                                                    .withValues(alpha: 0.8),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Ensure content is scrollable for pull-to-refresh
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurvedHeader(BuildContext context, AppLocalizations l10n) {
    final formattedDate = DateFormat(
      'EEE, d MMM',
      l10n.localeName,
    ).format(DateTime.now());

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryDark, AppColors.primary],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -90,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(130),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              right: 10,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(85),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppTheme.screenPaddingHorizontal,
                MediaQuery.of(context).padding.top + 12,
                AppTheme.screenPaddingHorizontal,
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo_only.png',
                            width: 42,
                            height: 42,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'BETHSAIDA',
                            style: AppTypography.headlineLarge.copyWith(
                              color: AppColors.white,
                              fontFamily: 'GillSansCondensedBold',
                              fontSize: 30,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: AppColors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/notifications');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    formattedDate,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.homeWelcomeTitle(l10n.shortAppName),
                    style: AppTypography.displaySmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.homeWelcomeSubtitle,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
