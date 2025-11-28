import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final ImageProvider? imageIcon;
  final Color backgroundColor;
  final Color borderColor;
  final Color? textColor; // Optional text color override
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutline;

  const SocialLoginButton({
    super.key,
    required this.label,
    this.icon,
    this.imageIcon,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.textColor, // Optional text color parameter
    required this.onPressed,
    this.isLoading = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Determine text color based on theme and provided parameters
    Color getTextColor() {
      if (textColor != null) return textColor!;

      // For outline buttons, adapt to theme
      if (isOutline) {
        return isDarkMode ? AppColors.white : borderColor;
      }

      // For filled buttons, use contrasting color
      return backgroundColor == Colors.white ||
              backgroundColor.computeLuminance() > 0.5
          ? AppColors.textPrimary
          : AppColors.white;
    }

    // Determine loading indicator color
    Color getLoadingColor() {
      if (isOutline) {
        return isDarkMode ? AppColors.white : borderColor;
      }
      return backgroundColor == Colors.white ||
              backgroundColor.computeLuminance() > 0.5
          ? AppColors.primary
          : AppColors.white;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: isOutline
            ? []
            : [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: isOutline ? Colors.transparent : backgroundColor,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: isOutline
                  ? Border.all(color: borderColor, width: 1.5)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          getLoadingColor(),
                        ),
                      ),
                    )
                  else if (imageIcon != null)
                    Image(image: imageIcon!, width: 20, height: 20)
                  else if (icon != null)
                    Icon(icon, size: 20, color: getTextColor()),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: AppTypography.titleMedium.copyWith(
                      color: getTextColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
