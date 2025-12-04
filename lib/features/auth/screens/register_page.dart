import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/features/auth/widgets/auth_background.dart';
import 'package:patient_portal/features/auth/widgets/auth_text_field.dart';
import 'package:patient_portal/features/auth/widgets/auth_date_field.dart';
import 'package:patient_portal/features/auth/providers/auth_provider.dart';
import 'package:patient_portal/features/auth/utils/validation_utils.dart';

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
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    // Check if user is already authenticated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

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
      // Trigger validation if autovalidate is enabled
      if (_autovalidateMode == AutovalidateMode.onUserInteraction) {
        _formKey.currentState?.validate();
      }
    }
  }

  Future<void> _handleRegister() async {
    // Validate form (including date field)
    if (!_formKey.currentState!.validate()) {
      // Enable real-time validation after first submit attempt
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    // Additional check for password match (not in validator to avoid duplicate checks)
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      dob: _selectedDate!,
      password: _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrasi berhasil! Mengarahkan ke halaman utama...'),
          backgroundColor: AppColors.success,
        ),
      );

      // Navigate to home page
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? 'Registrasi gagal. Silakan coba lagi.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: AuthBackground(
          isDarkMode: isDarkMode,
          child: SafeArea(
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildNameField(isDarkMode),
                            const SizedBox(height: 16),
                            _buildEmailField(isDarkMode),
                            const SizedBox(height: 16),
                            _buildPhoneField(isDarkMode),
                            const SizedBox(height: 16),
                            AuthDateField(
                              label: 'Tanggal Lahir',
                              selectedDate: _selectedDate,
                              onTap: _selectDate,
                              isDarkMode: isDarkMode,
                              autovalidateMode: _autovalidateMode,
                              validator: (value) {
                                if (value == null) {
                                  return 'Date of birth is required';
                                }
                                return ValidationUtils.validateDateOfBirth(
                                  value,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildPasswordField(isDarkMode),
                            const SizedBox(height: 16),
                            _buildConfirmPasswordField(isDarkMode),
                            const SizedBox(height: 24),
                            _buildRegisterButton(),
                            const SizedBox(height: 24),
                            _buildLoginLink(isDarkMode),
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
        ),
      ),
    );
  }

  Widget _buildNameField(bool isDarkMode) {
    return AuthTextField(
      label: 'Nama Lengkap',
      controller: _nameController,
      hintText: 'Masukkan nama lengkap Anda',
      prefixIcon: Icons.person_outline,
      isDarkMode: isDarkMode,
      validator: ValidationUtils.validateName,
      autovalidateMode: _autovalidateMode,
    );
  }

  Widget _buildEmailField(bool isDarkMode) {
    return AuthTextField(
      label: 'Email',
      controller: _emailController,
      hintText: 'Masukkan email Anda',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      isDarkMode: isDarkMode,
      validator: ValidationUtils.validateEmail,
      autovalidateMode: _autovalidateMode,
    );
  }

  Widget _buildPhoneField(bool isDarkMode) {
    return AuthTextField(
      label: 'Nomor Telepon',
      controller: _phoneController,
      hintText: 'Contoh: 08123456789',
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      isDarkMode: isDarkMode,
      validator: ValidationUtils.validatePhoneNumber,
      autovalidateMode: _autovalidateMode,
    );
  }

  Widget _buildPasswordField(bool isDarkMode) {
    return AuthTextField(
      label: 'Password',
      controller: _passwordController,
      hintText: 'Min 8 karakter, huruf besar, kecil & angka',
      prefixIcon: Icons.lock_outline,
      isPassword: true,
      isPasswordVisible: _isPasswordVisible,
      isDarkMode: isDarkMode,
      onTogglePassword: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
      validator: ValidationUtils.validatePassword,
      autovalidateMode: _autovalidateMode,
    );
  }

  Widget _buildConfirmPasswordField(bool isDarkMode) {
    return AuthTextField(
      label: 'Konfirmasi Password',
      controller: _confirmPasswordController,
      hintText: 'Masukkan ulang password Anda',
      prefixIcon: Icons.lock_outline,
      isPassword: true,
      isPasswordVisible: _isConfirmPasswordVisible,
      isDarkMode: isDarkMode,
      onTogglePassword: () {
        setState(() {
          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
        });
      },
      validator: (value) => ValidationUtils.validateConfirmPassword(
        value,
        _passwordController.text,
      ),
      autovalidateMode: _autovalidateMode,
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          minimumSize: const Size(double.infinity, 56),
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
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text('Daftar', style: AppTypography.button),
      ),
    );
  }

  Widget _buildLoginLink(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sudah punya akun? ",
          style: AppTypography.bodySmall.copyWith(
            color: isDarkMode ? AppColors.grey300 : AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
    );
  }
}
