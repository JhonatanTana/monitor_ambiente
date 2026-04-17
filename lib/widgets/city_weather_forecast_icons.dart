import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/widgets/app_shimmer.dart';

class CityWeatherForecastIcons extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const CityWeatherForecastIcons({super.key, required this.icon, required this.text, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

class CityWeatherForecastIconsShimmer extends StatelessWidget {
  const CityWeatherForecastIconsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        AppShimmer(width: 20, height: 20),
        AppShimmer(width: 40, height: 20),
      ],
    );
  }
}

