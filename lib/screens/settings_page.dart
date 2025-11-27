import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/localization_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pengaturan',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ubah kata sandi
            _buildSettingsItem(
              title: 'Ubah kata sandi',
              isDarkMode: isDarkMode,
              onTap: () {
                _showChangePasswordDialog(context);
              },
            ),
            _buildDivider(isDarkMode),

            // Atur PIN
            _buildSettingsItem(
              title: 'Atur PIN',
              isDarkMode: isDarkMode,
              onTap: () {
                _showSetPINDialog(context);
              },
            ),
            _buildDivider(isDarkMode),

            // Biometric
            _buildBiometricToggle(isDarkMode),
            _buildDivider(isDarkMode),

            // Pilih bahasa
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.screenPaddingHorizontal,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih bahasa',
                    style: AppTypography.bodyLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Consumer<LocalizationProvider>(
                    builder: (context, localizationProvider, child) {
                      return Row(
                        children: [
                          // English option
                          InkWell(
                            onTap: () {
                              localizationProvider.setEnglish();
                            },
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'en',
                                  groupValue:
                                      localizationProvider.locale.languageCode,
                                  onChanged: (value) {
                                    if (value != null) {
                                      localizationProvider.setEnglish();
                                    }
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                Text(
                                  'English (EN)',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Indonesia option
                          InkWell(
                            onTap: () {
                              localizationProvider.setIndonesian();
                            },
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'id',
                                  groupValue:
                                      localizationProvider.locale.languageCode,
                                  onChanged: (value) {
                                    if (value != null) {
                                      localizationProvider.setIndonesian();
                                    }
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                Text(
                                  'Indonesia (ID)',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.screenPaddingHorizontal,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.bodyLarge.copyWith(
                color: isDarkMode ? AppColors.white : AppColors.textPrimary,
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricToggle(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.screenPaddingHorizontal,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Biometric',
            style: AppTypography.bodyLarge.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          Switch(
            value: _biometricEnabled,
            onChanged: (value) {
              setState(() {
                _biometricEnabled = value;
              });
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDarkMode) {
    return Divider(
      height: 1,
      color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.grey900 : AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ubah Password',
                    style: AppTypography.titleLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Current Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Lama',
                  hintText: 'Masukkan password lama',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                ),
              ),
              const SizedBox(height: 16),

              // New Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  hintText: 'Masukkan password baru',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                ),
              ),
              const SizedBox(height: 16),

              // Confirm New Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                  hintText: 'Masukkan ulang password baru',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement change password logic
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password berhasil diubah'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Ubah Password',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _showSetPINDialog(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.grey900 : AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Atur PIN',
                    style: AppTypography.titleLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // New PIN Field
              TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'PIN Baru',
                  hintText: 'Masukkan 6 digit PIN',
                  prefixIcon: const Icon(Icons.pin),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                ),
              ),
              const SizedBox(height: 16),

              // Confirm PIN Field
              TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi PIN',
                  hintText: 'Masukkan ulang PIN',
                  prefixIcon: const Icon(Icons.pin),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? AppColors.grey800 : AppColors.grey100,
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement set PIN logic
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('PIN berhasil diatur'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Simpan PIN',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
