import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';

class AuthDateField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final bool isDarkMode;
  final String? Function(DateTime?)? validator;
  final AutovalidateMode? autovalidateMode;

  const AuthDateField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
    required this.isDarkMode,
    this.validator,
    this.autovalidateMode,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
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
        FormField<DateTime>(
          key: ValueKey(selectedDate), // Force rebuild when date changes
          initialValue: selectedDate,
          autovalidateMode: autovalidateMode,
          validator: validator,
          builder: (FormFieldState<DateTime> field) {
            final hasError = field.hasError;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.grey800 : AppColors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: hasError
                            ? Colors.red
                            : (isDarkMode
                                  ? AppColors.grey600
                                  : AppColors.grey300),
                        width: hasError ? 2 : 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: hasError
                              ? Colors.red
                              : (isDarkMode
                                    ? AppColors.grey400
                                    : AppColors.grey600),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            selectedDate != null
                                ? _formatDate(selectedDate!)
                                : 'Pilih tanggal lahir',
                            style: TextStyle(
                              color: selectedDate != null
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
                if (hasError && field.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
