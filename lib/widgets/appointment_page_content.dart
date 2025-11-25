import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/screens/book_appointment_page.dart';

class AppointmentPageContent extends StatefulWidget {
  const AppointmentPageContent({super.key});

  @override
  State<AppointmentPageContent> createState() => _AppointmentPageContentState();
}

class _AppointmentPageContentState extends State<AppointmentPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      'doctorName': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'date': '2024-12-01',
      'time': '10:00 AM',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'status': 'confirmed',
    },
    {
      'doctorName': 'Dr. Michael Chen',
      'specialty': 'Pediatrician',
      'date': '2024-12-05',
      'time': '02:30 PM',
      'hospital': 'Bethsaida Hospital Serang',
      'status': 'pending',
    },
  ];

  final List<Map<String, dynamic>> pastAppointments = [
    {
      'doctorName': 'Dr. Amanda Williams',
      'specialty': 'Dermatologist',
      'date': '2024-11-15',
      'time': '09:00 AM',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'status': 'completed',
    },
    {
      'doctorName': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'date': '2024-10-20',
      'time': '11:00 AM',
      'hospital': 'Bethsaida Hospital Gading Serpong',
      'status': 'completed',
    },
    {
      'doctorName': 'Dr. Michael Chen',
      'specialty': 'Pediatrician',
      'date': '2024-09-10',
      'time': '03:00 PM',
      'hospital': 'Bethsaida Hospital Serang',
      'status': 'cancelled',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'completed':
        return AppColors.info;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.grey400;
    }
  }

  String _getStatusText(String status) {
    return status[0].toUpperCase() + status.substring(1);
  }

  Widget _buildAppointmentCard(
    Map<String, dynamic> appointment,
    bool isDarkMode,
  ) {
    final statusColor = _getStatusColor(appointment['status']);
    final isUpcoming =
        appointment['status'] == 'confirmed' ||
        appointment['status'] == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? AppColors.grey700 : AppColors.grey300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment['doctorName'],
                              style: AppTypography.titleMedium.copyWith(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              appointment['specialty'],
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(appointment['status']),
                    style: AppTypography.labelSmall.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.grey700.withValues(alpha: 0.3)
                    : AppColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        appointment['date'],
                        style: AppTypography.bodySmall.copyWith(
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        appointment['time'],
                        style: AppTypography.bodySmall.copyWith(
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.local_hospital,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          appointment['hospital'],
                          style: AppTypography.bodySmall.copyWith(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isUpcoming) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Reschedule logic
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        backgroundColor: AppColors.white,
                        side: BorderSide(
                          color: isDarkMode ? AppColors.grey600 : AppColors.grey300,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Reschedule',
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Cancel logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cancel_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Cancel',
                            style: AppTypography.labelMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

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
        title: Text(
          'My Appointments',
          style: AppTypography.headlineMedium.copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter logic
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withValues(alpha: 0.7),
          labelStyle: AppTypography.titleMedium,
          unselectedLabelStyle: AppTypography.titleMedium,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Upcoming Appointments Tab
          upcomingAppointments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 64,
                        color: AppColors.grey400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Upcoming Appointments',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Book an appointment to get started',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: EdgeInsets.only(
                    left: AppTheme.screenPaddingHorizontal,
                    right: AppTheme.screenPaddingHorizontal,
                    top: 16,
                    bottom:
                        MediaQuery.of(context).padding.bottom +
                        kBottomNavigationBarHeight +
                        16,
                  ),
                  children: upcomingAppointments
                      .map(
                        (appointment) =>
                            _buildAppointmentCard(appointment, isDarkMode),
                      )
                      .toList(),
                ),

          // Past Appointments Tab
          pastAppointments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 64, color: AppColors.grey400),
                      const SizedBox(height: 16),
                      Text(
                        'No Past Appointments',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your appointment history will appear here',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: EdgeInsets.only(
                    left: AppTheme.screenPaddingHorizontal,
                    right: AppTheme.screenPaddingHorizontal,
                    top: 16,
                    bottom:
                        MediaQuery.of(context).padding.bottom +
                        kBottomNavigationBarHeight +
                        16,
                  ),
                  children: pastAppointments
                      .map(
                        (appointment) =>
                            _buildAppointmentCard(appointment, isDarkMode),
                      )
                      .toList(),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to book appointment page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookAppointmentPage(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.add),
        label: const Text('Book Appointment'),
      ),
    );
  }

  void _showBookAppointmentDialog(BuildContext context, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? AppColors.grey800 : AppColors.white,
        title: Text(
          'Book New Appointment',
          style: AppTypography.titleLarge.copyWith(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This feature will allow you to:',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              Icons.search,
              'Search for doctors by specialty',
              isDarkMode,
            ),
            _buildFeatureItem(
              Icons.calendar_today,
              'Select available time slots',
              isDarkMode,
            ),
            _buildFeatureItem(
              Icons.local_hospital,
              'Choose hospital location',
              isDarkMode,
            ),
            _buildFeatureItem(
              Icons.check_circle,
              'Confirm your appointment',
              isDarkMode,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: AppColors.primary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to booking flow
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
