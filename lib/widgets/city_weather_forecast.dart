import 'package:flutter/material.dart';

import 'city_weather_forecast_icons.dart';

class CityWeatherForecast extends StatefulWidget {
  const CityWeatherForecast({super.key});

  @override
  State<CityWeatherForecast> createState() => _CityWeatherForecastState();
}

class _CityWeatherForecastState extends State<CityWeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  Icon(Icons.thunderstorm, size: 64),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Varginha",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Quarta-feira, 16/04/2026",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CityWeatherForecastIcons(
                    icon: Icons.local_fire_department,
                    iconColor: Colors.orange,
                    text: "24°C",
                  ),
                  CityWeatherForecastIcons(
                    icon: Icons.water_drop,
                    iconColor: Colors.lightBlue,
                    text: "40%",
                  ),
                  CityWeatherForecastIcons(
                    icon: Icons.cloud,
                    iconColor: Colors.blueGrey.shade500,
                    text: "0.9mm",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
