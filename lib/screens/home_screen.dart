import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/services/sensor_service.dart';
import 'package:monitor_ambiente/widgets/app_big_card.dart';
import 'package:monitor_ambiente/widgets/app_little_card.dart';
import 'package:monitor_ambiente/widgets/city_weather_forecast.dart';

import '../models/sensor.dart';
import '../routes/app_router.dart';
import '../widgets/app_top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SensorService _service = SensorService();
  late List<Sensor> data;
  bool isLoading = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _service.getMeasures();

      setState(() {
        data = result;
        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppTopBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              CityWeatherForecast(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  spacing: 1,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Última atualização:",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "17/04/2026 16:22",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),

              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 AppLittleCard(
                   title: "Temperatura",
                   icon: Icons.local_fire_department,
                   colors: [Colors.orange, Colors.red],
                   value: 25,
                   maxValue: 50,
                   unit: "°C",
                 ),
                 AppLittleCard(
                   title: "Umidade",
                   icon: Icons.water_drop,
                   colors: [Colors.lightBlue, Colors.blue],
                   value: 40,
                   unit: "%",
                 ),
                ],
              ),

              AppBigCard(),
            ],
          ),
        ),

      ),
    );
  }
}
