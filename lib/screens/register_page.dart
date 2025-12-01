import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  DateTime? _selectedDate;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        final isDarkMode =
            MediaQuery.of(context).platformBrightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: isDarkMode ? AppColors.grey800 : AppColors.white,
              onSurface: isDarkMode ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal lahir Anda'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi password tidak cocok'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate registration process
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Registrasi berhasil! Silakan login dengan akun Anda.',
            ),
            backgroundColor: AppColors.success,
          ),
        );

        // Navigate back to login page
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [AppColors.primaryDark, AppColors.grey900]
                  : [AppColors.primaryLight, Colors.white],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 600,
                right: -50,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(140),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 350,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(110),
                  ),
                ),
              ),
              Positioned(
                top: -100,
                right: 280,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                right: -60,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ),
              Positioned(
                top: 550,
                right: -40,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 330,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.screenPaddingHorizontal,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // Back Button and Title
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Daftar Akun',
                              style: AppTypography.headlineMedium.copyWith(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Form Fields
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Name Field
                                _buildTextField(
                                  label: 'Nama Lengkap',
                                  controller: _nameController,
                                  hintText: 'Masukkan nama lengkap Anda',
                                  prefixIcon: Icons.person_outline,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Nama lengkap harus diisi';
                                    }
                                    if (value!.length < 2) {
                                      return 'Nama minimal 2 karakter';
                                    }
                                    return null;
                                  },
                                  isDarkMode: isDarkMode,
                                ),

                                const SizedBox(height: 16),

                                // Email Field
                                _buildTextField(
                                  label: 'Email',
                                  controller: _emailController,
                                  hintText: 'Masukkan email Anda',
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Email harus diisi';
                                    }
                                    if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    ).hasMatch(value!)) {
                                      return 'Format email tidak valid';
                                    }
                                    return null;
                                  },
                                  isDarkMode: isDarkMode,
                                ),

                                const SizedBox(height: 16),

                                // Phone Number Field
                                _buildTextField(
                                  label: 'Nomor Telepon',
                                  controller: _phoneController,
                                  hintText: 'Contoh: 08123456789',
                                  prefixIcon: Icons.phone_outlined,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Nomor telepon harus diisi';
                                    }
                                    if (value!.length < 10) {
                                      return 'Nomor telepon minimal 10 digit';
                                    }
                                    return null;
                                  },
                                  isDarkMode: isDarkMode,
                                ),

                                const SizedBox(height: 16),

                                // Date of Birth Field
                                _buildDateField(isDarkMode),

                                const SizedBox(height: 16),

                                // Password Field
                                _buildTextField(
                                  label: 'Password',
                                  controller: _passwordController,
                                  hintText: 'Masukkan password Anda',
                                  prefixIcon: Icons.lock_outline,
                                  isPassword: true,
                                  isPasswordVisible: _isPasswordVisible,
                                  onTogglePassword: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Password harus diisi';
                                    }
                                    if (value!.length < 6) {
                                      return 'Password minimal 6 karakter';
                                    }
                                    return null;
                                  },
                                  isDarkMode: isDarkMode,
                                ),

                                const SizedBox(height: 16),

                                // Confirm Password Field
                                _buildTextField(
                                  label: 'Konfirmasi Password',
                                  controller: _confirmPasswordController,
                                  hintText: 'Masukkan ulang password Anda',
                                  prefixIcon: Icons.lock_outline,
                                  isPassword: true,
                                  isPasswordVisible: _isConfirmPasswordVisible,
                                  onTogglePassword: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Konfirmasi password harus diisi';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Password tidak cocok';
                                    }
                                    return null;
                                  },
                                  isDarkMode: isDarkMode,
                                ),

                                const SizedBox(height: 24),

                                // Register Button
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
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
                                  child: ElevatedButton(
                                    onPressed: _isLoading
                                        ? null
                                        : _handleRegister,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 24,
                                      ),
                                      minimumSize: const Size(
                                        double.infinity,
                                        56,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    AppColors.white,
                                                  ),
                                            ),
                                          )
                                        : Text(
                                            'Daftar',
                                            style: AppTypography.button,
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Login Link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sudah punya akun? ",
                                      style: AppTypography.bodySmall.copyWith(
                                        color: isDarkMode
                                            ? AppColors.grey300
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        overlayColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        'Masuk',
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required bool isDarkMode,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.titleMedium.copyWith(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword && !isPasswordVisible,
          style: TextStyle(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          ),
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: isDarkMode ? AppColors.grey500 : AppColors.grey400,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: isDarkMode ? AppColors.grey400 : AppColors.grey600,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isDarkMode ? AppColors.grey400 : AppColors.grey600,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.grey600 : AppColors.grey300,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.grey600 : AppColors.grey300,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: isDarkMode ? AppColors.grey800 : AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal Lahir',
          style: AppTypography.titleMedium.copyWith(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.grey800 : AppColors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDarkMode ? AppColors.grey600 : AppColors.grey300,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: isDarkMode ? AppColors.grey400 : AppColors.grey600,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? _formatDate(_selectedDate!)
                        : 'Pilih tanggal lahir',
                    style: TextStyle(
                      color: _selectedDate != null
                          ? (isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary)
                          : (isDarkMode
                                ? AppColors.grey500
                                : AppColors.grey400),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
