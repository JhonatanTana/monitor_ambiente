import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/widgets/app_big_card.dart';
import 'package:monitor_ambiente/widgets/app_little_card.dart';
import 'package:monitor_ambiente/widgets/city_weather_forecast.dart';

import '../widgets/app_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppTopBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [

            CityWeatherForecast(),

            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               AppLittleCard(),
               AppLittleCard(),
              ],
            ),

            AppBigCard(),
          ],
        ),
      ),

    );
  }
}
