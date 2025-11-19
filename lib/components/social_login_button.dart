import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_typography.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final ImageProvider? imageIcon;
  final Color backgroundColor;
  final Color borderColor;
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
    required this.onPressed,
    this.isLoading = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
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
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else if (imageIcon != null)
                    Image(image: imageIcon!, width: 20, height: 20)
                  else if (icon != null)
                    Icon(icon, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: AppTypography.titleMedium.copyWith(
                      color: borderColor,
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
