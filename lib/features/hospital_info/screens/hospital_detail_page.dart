import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/features/hospital_info/models/hospital_model.dart';
import 'package:patient_portal/features/hospital_info/services/hospital_service.dart';
import 'package:patient_portal/features/hospital_info/widgets/hospital_hero_image.dart';
import 'package:patient_portal/features/hospital_info/widgets/hospital_info_card.dart';
import 'package:patient_portal/features/hospital_info/widgets/operational_hours_card.dart';
import 'package:patient_portal/features/hospital_info/widgets/facilities_card.dart';
import 'package:patient_portal/features/hospital_info/widgets/gallery_card.dart';
import 'package:patient_portal/features/hospital_info/widgets/hospital_detail_shimmer.dart';
import 'package:patient_portal/core/network/api_response.dart';
import 'package:patient_portal/shared/widgets/state_widgets.dart';

class HospitalDetailPage extends StatefulWidget {
  final String hospitalId;

  const HospitalDetailPage({super.key, required this.hospitalId});

  @override
  State<HospitalDetailPage> createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  late ScrollController _scrollController;
  late Future<ApiResponse<HospitalModel>> _hospitalFuture;
  bool _isAppBarVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadHospitalDetail();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadHospitalDetail() {
    setState(() {
      _hospitalFuture = HospitalService.getHospitalById(widget.hospitalId);
    });
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

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
      body: FutureBuilder<ApiResponse<HospitalModel>>(
        future: _hospitalFuture,
        builder: (context, snapshot) {
          // Loading state with shimmer
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HospitalDetailShimmer();
          }

          // Error state
          if (snapshot.hasError || !snapshot.hasData) {
            return ErrorState(
              title: 'Failed to load hospital',
              message: snapshot.error?.toString() ?? 'Unknown error',
              onRetry: _loadHospitalDetail,
            );
          }

          final response = snapshot.data!;

          // API Error state
          if (!response.success || response.data == null) {
            return ApiErrorState(
              message: response.message ?? 'Failed to load hospital details',
              onRetry: _loadHospitalDetail,
            );
          }

          final hospital = response.data!;

          return _buildContent(context, hospital, isDarkMode);
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HospitalModel hospital,
    bool isDarkMode,
  ) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image
          HospitalHeroImage(imageUrl: hospital.image),

          // Hospital Info Card
          HospitalInfoCard(hospital: hospital, isDarkMode: isDarkMode),

          const SizedBox(height: 16),

          // Operational Hours Card
          if (hospital.operatingHours != null &&
              hospital.operatingHours!.isNotEmpty)
            OperationalHoursCard(
              operatingHours: hospital.operatingHours!,
              isDarkMode: isDarkMode,
            ),

          const SizedBox(height: 16),

          // Facilities Card
          FacilitiesCard(facilities: const [], isDarkMode: isDarkMode),

          const SizedBox(height: 16),

          // Gallery Card
          GalleryCard(galleryImages: const [], isDarkMode: isDarkMode),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
