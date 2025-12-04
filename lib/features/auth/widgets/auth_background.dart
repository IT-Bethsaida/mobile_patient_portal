import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final bool isDarkMode;
  final Widget child;

  const AuthBackground({
    super.key,
    required this.isDarkMode,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildCircle(600, -50, 280, 0.15),
          _buildCircle(20, 350, 220, 0.6, isWhite: true),
          _buildCircle(-100, 280, 300, 0.2),
          _buildCircle(null, -60, 180, 0.3, bottom: -40),
          _buildCircle(550, -40, 200, 0.1),
          _buildCircle(120, 330, 160, 0.1),
          child,
        ],
      ),
    );
  }

  Widget _buildCircle(
    double? top,
    double? right,
    double size,
    double opacity, {
    double? bottom,
    bool isWhite = false,
  }) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isWhite
              ? AppColors.white.withValues(alpha: opacity)
              : (isDarkMode
                    ? AppColors.primaryDark.withValues(alpha: opacity)
                    : AppColors.primary.withValues(alpha: opacity)),
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ),
    );
  }
}
