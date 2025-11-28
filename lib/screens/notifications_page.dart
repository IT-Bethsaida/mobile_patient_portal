import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'title': 'Jadwal Kontrol Berhasil Dikonfirmasi',
      'message':
          'Jadwal kontrol Anda dengan Dr. Sarah Johnson pada 25 Nov 2024 pukul 14:00 telah dikonfirmasi.',
      'time': '2 jam yang lalu',
      'type': 'appointment',
      'isRead': false,
    },
    {
      'title': 'Hasil Laboratorium Siap Dilihat',
      'message':
          'Hasil pemeriksaan darah lengkap Anda sudah tersedia. Silakan lihat di menu Medical Record.',
      'time': '1 hari yang lalu',
      'type': 'lab',
      'isRead': false,
    },
    {
      'title': 'Pengingat Minum Obat',
      'message':
          'Jangan lupa minum Amoxicillin 500mg sesuai jadwal yang direkomendasikan.',
      'time': '3 hari yang lalu',
      'type': 'medication',
      'isRead': true,
    },
    {
      'title': 'Promo Spesial Hari Ini',
      'message':
          'Dapatkan diskon 30% untuk pemeriksaan kesehatan menyeluruh. Promo berlaku hingga 31 Desember.',
      'time': '5 hari yang lalu',
      'type': 'promo',
      'isRead': true,
    },
    {
      'title': 'Update Aplikasi Tersedia',
      'message':
          'Versi terbaru aplikasi sudah tersedia. Update sekarang untuk fitur terbaru.',
      'time': '1 minggu yang lalu',
      'type': 'system',
      'isRead': true,
    },
  ];

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
          'Notifikasi',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Mark all as read
            },
            child: Text(
              'Tandai Semua Dibaca',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState(isDarkMode)
          : ListView.builder(
              padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index], isDarkMode);
              },
            ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              size: 64,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Tidak ada notifikasi',
            style: AppTypography.titleLarge.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Notifikasi baru akan muncul di sini',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    Map<String, dynamic> notification,
    bool isDarkMode,
  ) {
    final isRead = notification['isRead'] as bool;
    final type = notification['type'] as String;

    IconData getIcon() {
      switch (type) {
        case 'appointment':
          return Icons.calendar_today;
        case 'lab':
          return Icons.science;
        case 'medication':
          return Icons.medication;
        case 'promo':
          return Icons.local_offer;
        case 'system':
          return Icons.info;
        default:
          return Icons.notifications;
      }
    }

    Color getIconColor() {
      switch (type) {
        case 'appointment':
          return AppColors.primary;
        case 'lab':
          return Colors.blue;
        case 'medication':
          return Colors.green;
        case 'promo':
          return Colors.orange;
        case 'system':
          return Colors.purple;
        default:
          return AppColors.primary;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: !isRead
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: getIconColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(getIcon(), color: getIconColor(), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'] as String,
                          style: AppTypography.bodyMedium.copyWith(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary,
                            fontWeight: isRead
                                ? FontWeight.w500
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['message'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: isDarkMode
                          ? AppColors.grey200
                          : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification['time'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
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
