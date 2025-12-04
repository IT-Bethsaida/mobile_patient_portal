import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/features/hospital_info/screens/hospital_detail_page.dart';
import 'package:patient_portal/features/hospital_info/services/hospital_service.dart';
import 'package:patient_portal/features/hospital_info/models/hospital_model.dart';
import 'package:patient_portal/features/hospital_info/widgets/hospital_card.dart';
import 'package:patient_portal/features/hospital_info/widgets/hospital_card_shimmer.dart';
import 'package:patient_portal/features/hospital_info/utils/url_launcher_utils.dart';
import 'package:patient_portal/core/network/api_response.dart';
import 'package:patient_portal/shared/widgets/state_widgets.dart';
import 'package:patient_portal/features/auth/providers/auth_provider.dart';

class HospitalInformationPage extends StatefulWidget {
  const HospitalInformationPage({super.key});

  @override
  State<HospitalInformationPage> createState() =>
      _HospitalInformationPageState();
}

class _HospitalInformationPageState extends State<HospitalInformationPage> {
  late Future<ApiResponse<List<HospitalModel>>> _hospitalsFuture;

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  void _loadHospitals() {
    setState(() {
      _hospitalsFuture = HospitalService.getHospitals();
    });
  }

  void _handleUnauthorized() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Session Expired'),
        content: const Text(
          'Your session has expired. Please login again to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await authProvider.logout();
              if (mounted) {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
            child: const Text('Login'),
          ),
        ],
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
      body: FutureBuilder<ApiResponse<List<HospitalModel>>>(
        future: _hospitalsFuture,
        builder: (context, snapshot) {
          // Loading state with shimmer
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HospitalListShimmer(itemCount: 3);
          }

          // Error state
          if (snapshot.hasError || !snapshot.hasData) {
            return ErrorState(
              title: 'Failed to load hospitals',
              message: snapshot.error?.toString() ?? 'Unknown error',
              onRetry: _loadHospitals,
            );
          }

          final response = snapshot.data!;

          // API Error state
          if (!response.success || response.data == null) {
            // Handle 401 Unauthorized - token expired
            if (response.statusCode == 401) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _handleUnauthorized();
              });
            }

            return ApiErrorState(
              message: response.message ?? 'Failed to load hospitals',
              onRetry: _loadHospitals,
            );
          }

          final hospitals = response.data!;

          // Empty state
          if (hospitals.isEmpty) {
            return const EmptyState(
              title: 'No hospitals available',
              message: 'There are no hospitals to display at the moment.',
              icon: Icons.local_hospital_outlined,
            );
          }

          // Success state - show list
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final hospital = hospitals[index];
              return HospitalCard(
                hospital: hospital,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HospitalDetailPage(hospitalId: hospital.id),
                    ),
                  );
                },
                onCall: (phone) =>
                    UrlLauncherUtils.makePhoneCall(context, phone),
                onDirections: (name, address) =>
                    UrlLauncherUtils.openMaps(context, name, address),
              );
            },
          );
        },
      ),
    );
  }
}
