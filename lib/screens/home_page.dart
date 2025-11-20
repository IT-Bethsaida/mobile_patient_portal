import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarouselIndex = 0;
  int _selectedBottomNavIndex = 0;

  final List<String> carouselImages = [
    'assets/images/promo_1.png',
    'assets/images/promo_2.png',
    'assets/images/promo_3.png',
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.local_hospital,
      'label': 'Hospitals\nInformation',
      'color': AppColors.primary,
    },
    {
      'icon': Icons.history,
      'label': 'Outpatient\nHistory',
      'color': AppColors.primary,
    },
    {'icon': Icons.science, 'label': 'Laboratory', 'color': AppColors.primary},
    {
      'icon': Icons.medical_services,
      'label': 'Radiology',
      'color': AppColors.primary,
    },
    {
      'icon': Icons.assignment,
      'label': 'Self Test',
      'color': AppColors.primary,
    },
    {
      'icon': Icons.payment,
      'label': 'Self Payment',
      'color': AppColors.grey400,
      'disabled': true,
    },
    {
      'icon': Icons.help,
      'label': 'Quiz',
      'color': AppColors.grey400,
      'disabled': true,
    },
    {
      'icon': Icons.login,
      'label': 'Self Checkin',
      'color': AppColors.grey400,
      'disabled': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_only.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              'BETHSAIDA',
              style: AppTypography.headlineLarge.copyWith(
                color: AppColors.white,
                fontFamily: 'GillSansCondensedBold',
                fontSize: 30,
                height: 2.2,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
            // Carousel Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                                color: AppColors.primary.withValues(alpha: 0.1),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.screenPaddingHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jadwal Vaksinasi Terbaru',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lihat jadwal dan lokasi vaksinasi terdekat.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                      border: Border.all(color: AppColors.grey300, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            Icons.vaccines,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vaksinasi COVID-19',
                                style: AppTypography.titleMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Jadwal: 20 Nov 2024',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

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
                            // Navigate based on menu item
                            if (item['label'] == 'Hospitals\nInformation') {
                              Navigator.pushNamed(
                                context,
                                '/hospital-information',
                              );
                            }
                          },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isDisabled
                                ? AppColors.grey200.withValues(alpha: 0.5)
                                : AppColors.primary.withValues(alpha: 0.1),
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
                              'coming soon',
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

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey400,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Janji Temu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
