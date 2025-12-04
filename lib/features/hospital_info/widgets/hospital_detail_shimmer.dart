import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';

/// Shimmer loading placeholder for hospital detail page
class HospitalDetailShimmer extends StatefulWidget {
  const HospitalDetailShimmer({super.key});

  @override
  State<HospitalDetailShimmer> createState() => _HospitalDetailShimmerState();
}

class _HospitalDetailShimmerState extends State<HospitalDetailShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Shimmer
              _buildShimmerBox(
                width: double.infinity,
                height: 220,
                isDarkMode: isDarkMode,
                borderRadius: 0,
              ),

              // Hospital Info Card Shimmer
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.grey800 : AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hospital Name
                    _buildShimmerBox(
                      width: 250,
                      height: 24,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 12),

                    // Description lines
                    _buildShimmerBox(
                      width: double.infinity,
                      height: 14,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 8),
                    _buildShimmerBox(
                      width: double.infinity,
                      height: 14,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 8),
                    _buildShimmerBox(
                      width: 200,
                      height: 14,
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 20),

                    // Contact rows
                    _buildContactRowShimmer(isDarkMode),
                    const SizedBox(height: 16),
                    _buildContactRowShimmer(isDarkMode),
                    const SizedBox(height: 16),
                    _buildContactRowShimmer(isDarkMode),

                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildShimmerBox(
                            width: double.infinity,
                            height: 48,
                            isDarkMode: isDarkMode,
                            borderRadius: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildShimmerBox(
                            width: double.infinity,
                            height: 48,
                            isDarkMode: isDarkMode,
                            borderRadius: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Operational Hours Card Shimmer
              _buildCardShimmer(isDarkMode: isDarkMode, title: true, rows: 5),

              const SizedBox(height: 16),

              // Facilities Card Shimmer
              _buildCardShimmer(isDarkMode: isDarkMode, title: true, rows: 3),

              const SizedBox(height: 16),

              // Gallery Card Shimmer
              _buildCardShimmer(isDarkMode: isDarkMode, title: true, rows: 2),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactRowShimmer(bool isDarkMode) {
    return Row(
      children: [
        _buildShimmerBox(
          width: 40,
          height: 40,
          isDarkMode: isDarkMode,
          borderRadius: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerBox(width: 80, height: 12, isDarkMode: isDarkMode),
              const SizedBox(height: 6),
              _buildShimmerBox(
                width: double.infinity,
                height: 14,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardShimmer({
    required bool isDarkMode,
    required bool title,
    required int rows,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title) ...[
            _buildShimmerBox(width: 150, height: 18, isDarkMode: isDarkMode),
            const SizedBox(height: 16),
          ],
          ...List.generate(
            rows,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildShimmerBox(
                width: double.infinity,
                height: 14,
                isDarkMode: isDarkMode,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    required bool isDarkMode,
    double borderRadius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isDarkMode
              ? [AppColors.grey700, AppColors.grey600, AppColors.grey700]
              : [AppColors.grey200, AppColors.grey300, AppColors.grey200],
          stops: [
            _animation.value - 0.3,
            _animation.value,
            _animation.value + 0.3,
          ].map((value) => value.clamp(0.0, 1.0)).toList(),
        ),
      ),
    );
  }
}
