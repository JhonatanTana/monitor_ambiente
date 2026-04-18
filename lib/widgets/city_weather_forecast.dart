import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/models/weather_model.dart';
import 'package:monitor_ambiente/services/weather_service.dart';
import 'package:monitor_ambiente/widgets/app_alert_dialog.dart';

import 'app_shimmer.dart';
import 'city_weather_forecast_icons.dart';

class CityWeatherForecast extends StatefulWidget {
  const CityWeatherForecast({super.key});

  @override
  State<CityWeatherForecast> createState() => _CityWeatherForecastState();
}

class _CityWeatherForecastState extends State<CityWeatherForecast> {
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherModel> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    try {
      _weatherFuture = _weatherService.fetchWeather("Varginha");
    } catch (e) {
      AppAlertDialog.show(
        title: "Erro",
        content: "Houve um erro ao recupera os dados de clima da cidade. \n Erro: $e",
        isError: true
      );
    }
  }

  String _getWeatherIcon(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@4x.png";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: FutureBuilder<WeatherModel>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CityWeatherForecastShimmer();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Erro ao carregar clima",
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: Text("Sem dados"));
            }

            final weather = snapshot.data!;
            final formattedDate = DateFormat("EEEE, dd/MM/yyyy", 'pt_BR').format(weather.date);
            final capitalizedDate = formattedDate[0].toUpperCase() + formattedDate.substring(1);

            return Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Image.network(
                        _getWeatherIcon(weather.icon),
                        width: 64,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          "assets/images/Cloudy.png",
                          width: 64,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            weather.cityName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText),
                          ),
                          Text(
                            capitalizedDate,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryText),
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
                        text: "${weather.temperature.toStringAsFixed(0)}°C",
                      ),
                      CityWeatherForecastIcons(
                        icon: Icons.water_drop,
                        iconColor: Colors.lightBlue,
                        text: "${weather.humidity}%",
                      ),
                      CityWeatherForecastIcons(
                        icon: Icons.cloud,
                        iconColor: Colors.blueGrey.shade500,
                        text: "${weather.rain.toStringAsFixed(1)}mm",
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CityWeatherForecastShimmer extends StatelessWidget {
  const CityWeatherForecastShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  AppShimmer(
                    width: 64,
                    height: 64,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      AppShimmer(
                        width: 100,
                        height: 16,
                      ),
                      AppShimmer(
                        width: 120,
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [

                  CityWeatherForecastIconsShimmer(),
                  CityWeatherForecastIconsShimmer(),
                  CityWeatherForecastIconsShimmer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

