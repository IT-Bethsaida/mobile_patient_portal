import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_theme.dart';

/// Shimmer loading placeholder for hospital card
class HospitalCardShimmer extends StatefulWidget {
  const HospitalCardShimmer({super.key});

  @override
  State<HospitalCardShimmer> createState() => _HospitalCardShimmerState();
}

class _HospitalCardShimmerState extends State<HospitalCardShimmer>
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
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode ? AppColors.grey800 : AppColors.white,
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
              // Image shimmer
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: _buildShimmerBox(
                  width: double.infinity,
                  height: 180,
                  isDarkMode: isDarkMode,
                ),
              ),

              // Content shimmer
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    // Contact info box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.grey700
                            : AppColors.grey100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildShimmerBox(
                                width: 36,
                                height: 36,
                                isDarkMode: isDarkMode,
                                borderRadius: 8,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildShimmerBox(
                                      width: 60,
                                      height: 12,
                                      isDarkMode: isDarkMode,
                                    ),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(
                                      width: 120,
                                      height: 14,
                                      isDarkMode: isDarkMode,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildShimmerBox(
                                width: 36,
                                height: 36,
                                isDarkMode: isDarkMode,
                                borderRadius: 8,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildShimmerBox(
                                      width: 60,
                                      height: 12,
                                      isDarkMode: isDarkMode,
                                    ),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(
                                      width: double.infinity,
                                      height: 14,
                                      isDarkMode: isDarkMode,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Buttons
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
            ],
          ),
        );
      },
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

/// Shimmer loading list for multiple hospital cards
class HospitalListShimmer extends StatelessWidget {
  final int itemCount;

  const HospitalListShimmer({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const HospitalCardShimmer();
      },
    );
  }
}
