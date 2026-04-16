import 'package:flutter/material.dart';

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
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
