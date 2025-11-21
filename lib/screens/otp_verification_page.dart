import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isVerifying = false;
  bool _isResending = false;
  int _resendTimer = 60;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get phone number from navigation arguments
    _phoneNumber = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      }
    });
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty) {
      // Only keep the last entered digit
      if (value.length > 1) {
        _otpControllers[index].text = value.substring(value.length - 1);
        _otpControllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: _otpControllers[index].text.length),
        );
      }

      // Move to next field
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, remove focus and verify
        _focusNodes[index].unfocus();
        _verifyOtp();
      }
    }
  }

  void _handleKeyEvent(String value, int index) {
    if (value.isEmpty && index > 0) {
      // Handle backspace - move to previous field
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOtp() {
    String otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan 6 digit kode OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    // Simulate OTP verification
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });

        // For demo purposes, accept any 6-digit code
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  void _resendOtp() {
    if (_resendTimer > 0) return;

    setState(() {
      _isResending = true;
      _resendTimer = 60;
    });

    // Simulate resending OTP
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
        _startResendTimer();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kode OTP telah dikirim ulang'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    });
  }

  String _formatPhoneNumber(String phone) {
    if (phone.startsWith('08')) {
      return '+62 ${phone.substring(1)}';
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Verifikasi OTP',
          style: AppTypography.headlineSmall.copyWith(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenPaddingHorizontal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sms_outlined,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  'Masukkan Kode OTP',
                  style: AppTypography.headlineMedium.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtitle
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTypography.bodyMedium.copyWith(
                      color: isDarkMode
                          ? AppColors.grey300
                          : AppColors.textSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Kode verifikasi 6 digit telah dikirim ke\n',
                      ),
                      TextSpan(
                        text: _formatPhoneNumber(_phoneNumber),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 45,
                      height: 58,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _otpControllers[index].text.isNotEmpty
                              ? AppColors.primary
                              : isDarkMode
                              ? AppColors.grey600
                              : AppColors.grey300,
                          width: _otpControllers[index].text.isNotEmpty ? 2 : 1,
                        ),
                        color: isDarkMode ? AppColors.grey800 : AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          autofocus: index == 0,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textPrimary,
                            letterSpacing: 0.5,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding: EdgeInsets.all(0),
                          ),
                          onChanged: (value) {
                            _handleOtpInput(value, index);
                            _handleKeyEvent(value, index);
                          },
                          onTap: () {
                            _otpControllers[index].selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                    offset: _otpControllers[index].text.length,
                                  ),
                                );
                          },
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 32),

                // Resend OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tidak menerima kode? ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: isDarkMode
                            ? AppColors.grey300
                            : AppColors.textSecondary,
                      ),
                    ),
                    if (_resendTimer > 0)
                      Text(
                        'Kirim ulang dalam ${_resendTimer}s',
                        style: AppTypography.bodyMedium.copyWith(
                          color: isDarkMode
                              ? AppColors.grey400
                              : AppColors.grey600,
                        ),
                      )
                    else
                      TextButton(
                        onPressed: _isResending ? null : _resendOtp,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: _isResending
                            ? SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              )
                            : Text(
                                'Kirim Ulang',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                  ],
                ),

                const SizedBox(height: 48),

                // Verify Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isVerifying
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white,
                              ),
                            ),
                          )
                        : Text('Verifikasi OTP', style: AppTypography.button),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
