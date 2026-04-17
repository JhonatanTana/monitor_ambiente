import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../models/sensor.dart';
import 'app_shimmer.dart';

class AppBigCard extends StatelessWidget {
  final List<Sensor> sensors;
  final bool isLoading;
  final String title;

  const AppBigCard({
    super.key,
    this.sensors = const [],
    this.isLoading = false,
    this.title = "Histórico (Últimas 24h)",
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const AppBigCardShimmer();

    return Card(
      color: AppColors.onBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: sensors.isEmpty
                  ? Center(
                      child: Text(
                        "Sem dados para exibir",
                        style: TextStyle(color: AppColors.secondaryText),
                      ),
                    )
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 10,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.grey.withValues(alpha: 0.1),
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: _calculateBottomInterval(),
                              getTitlesWidget: bottomTitleWidgets,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 10,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        minX: 0,
                        maxX: (sensors.length - 1).toDouble(),
                        minY: 0,
                        maxY: 100,
                        lineBarsData: [
                          _lineChartBarData(
                            spots: _getTemperatureSpots(),
                            color: Colors.orange,
                          ),
                          _lineChartBarData(
                            spots: _getHumiditySpots(),
                            color: Colors.blue,
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (touchedSpot) => AppColors.onBackground,
                            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                              return touchedBarSpots.map((barSpot) {
                                final flSpot = barSpot;
                                final sensor = sensors.reversed.toList()[flSpot.x.toInt()];
                                final unit = barSpot.barIndex == 0 ? "°C" : "%";
                                return LineTooltipItem(
                                  "${flSpot.y.toStringAsFixed(1)}$unit",
                                  TextStyle(
                                    color: barSpot.bar.color ?? barSpot.bar.gradient?.colors.first ?? Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(color: Colors.orange, label: "Temperatura"),
                const SizedBox(width: 16),
                _LegendItem(color: Colors.blue, label: "Umidade"),
              ],
            )
          ],
        ),
      ),
    );
  }

  double _calculateBottomInterval() {
    if (sensors.length <= 5) return 1;
    return (sensors.length / 5).floorToDouble();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.grey,
    );
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(value.toInt().toString(), style: style),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.grey,
    );
    
    final index = value.toInt();
    if (index >= 0 && index < sensors.length) {
      // Revertemos para que o gráfico mostre da esquerda (antigo) para a direita (novo)
      final reversedSensors = sensors.reversed.toList();
      final sensor = reversedSensors[index];
      if (sensor.date != null) {
        final time = DateFormat('HH:mm').format(sensor.date!.toDate());
        return SideTitleWidget(
          meta: meta,
          space: 8,
          child: Text(time, style: style),
        );
      }
    }
    return Container();
  }

  List<FlSpot> _getTemperatureSpots() {
    final reversed = sensors.reversed.toList();
    return List.generate(reversed.length, (index) {
      return FlSpot(index.toDouble(), reversed[index].temperature ?? 0);
    });
  }

  List<FlSpot> _getHumiditySpots() {
    final reversed = sensors.reversed.toList();
    return List.generate(reversed.length, (index) {
      return FlSpot(index.toDouble(), reversed[index].humidity ?? 0);
    });
  }

  LineChartBarData _lineChartBarData({required List<FlSpot> spots, required Color color}) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.withValues(alpha: 0.1),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

class AppBigCardShimmer extends StatelessWidget {
  const AppBigCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.onBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmer(width: 150, height: 20),
            const SizedBox(height: 24),
            AppShimmer(width: double.infinity, height: 180),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppShimmer(width: 60, height: 14),
                const SizedBox(width: 16),
                AppShimmer(width: 60, height: 14),
              ],
            )
          ],
        ),
      ),
    );
  }
}
