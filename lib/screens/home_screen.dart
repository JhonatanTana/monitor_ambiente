import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitor_ambiente/constants/date_formatter.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/services/sensor_service.dart';
import 'package:monitor_ambiente/widgets/app_big_card.dart';
import 'package:monitor_ambiente/widgets/app_little_card.dart';
import 'package:monitor_ambiente/widgets/city_weather_forecast.dart';

import '../blocs/sensor/sensor_cubit.dart';
import '../blocs/sensor/sensor_state.dart';
import '../routes/app_router.dart';
import '../widgets/app_segmented_button.dart';
import '../widgets/app_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SensorCubit(SensorService())..fetchMeasures(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        appBar: const AppTopBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const CityWeatherForecast(),
              BlocBuilder<SensorCubit, SensorState>(
                builder: (context, state) {
                  double temp = 0;
                  double humidity = 0;
                  DateTime lastCheck = DateTime.now();
                  bool isLoading = state is SensorLoading;

                  if (state is SensorSuccess && state.sensors.isNotEmpty) {
                    final lastSensor = state.sensors.first;
                    temp = lastSensor.temperature ?? 0;
                    humidity = lastSensor.humidity ?? 0;
                    lastCheck = lastSensor.date?.toDate() ?? DateTime.now();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppSegmentedButton<SensorFilter>(
                              selected: state.filter,
                              options: [
                                AppSegmentedButtonOption(value: SensorFilter.day, label: "Dia"),
                                AppSegmentedButtonOption(value: SensorFilter.week, label: "Semana"),
                                AppSegmentedButtonOption(value: SensorFilter.month, label: "Mês"),
                                AppSegmentedButtonOption(value: SensorFilter.all, label: "Tudo"),
                              ],
                              onSelectionChanged: (filter) {
                                context.read<SensorCubit>().fetchMeasures(filter: filter);
                              },
                            ),
                            Column(
                              spacing: 1,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Última atualização:",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  DateFormatter.formatToString(lastCheck, true),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
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
                            colors: const [Colors.orange, Colors.red],
                            value: temp,
                            maxValue: 50,
                            unit: "°C",
                            isLoading: isLoading,
                          ),
                          AppLittleCard(
                            title: "Umidade",
                            icon: Icons.water_drop,
                            colors: const [Colors.lightBlue, Colors.blue],
                            value: humidity,
                            unit: "%",
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                      AppBigCard(
                        sensors: state is SensorSuccess ? state.sensors : [],
                        isLoading: isLoading,
                        title: state.filter == SensorFilter.day
                            ? "Histórico (Últimas 24h)"
                            : state.filter == SensorFilter.week
                                ? "Histórico (Últimos 7 dias)"
                                : state.filter == SensorFilter.month
                                    ? "Histórico (Últimos 30 dias)"
                                    : "Histórico (Tudo)",
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


