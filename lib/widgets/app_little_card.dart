import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants/app_colors.dart';
import 'app_shimmer.dart';

class AppLittleCard extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final IconData icon;
  final List<Color> colors;
  final double maxValue;
  final bool isLoading;

  const AppLittleCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.colors,
    this.maxValue = 100,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading ? AppLittleCardShimmer() :
    Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        color: AppColors.onBackground,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Row(
                spacing: 8,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colors.first.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: colors.first,
                    ),
                  ),

                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: maxValue,
                  initialValue: value,
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                      progressBarColors: colors,
                      trackColor: Colors.grey.withValues(alpha: 0.1),
                      shadowMaxOpacity: 0,
                    ),
                    customWidths: CustomSliderWidths(
                      trackWidth: 12,
                      progressBarWidth: 12,
                      handlerSize: 3,
                    ),
                    size: 120,
                  ),
                  innerWidget: (value) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          unit,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppLittleCardShimmer extends StatelessWidget {
  const AppLittleCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        color: AppColors.onBackground,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Row(
                spacing: 8,
                children: [
                  AppShimmer.circular(size: 28),
                  AppShimmer(
                    width: 80,
                    height: 14,
                  ),
                ],
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppShimmer.circular(size: 110),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.onBackground,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppShimmer(width: 40, height: 36),
                        const SizedBox(width: 4),
                        AppShimmer(width: 20, height: 20),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
