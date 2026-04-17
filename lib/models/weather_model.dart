class WeatherModel {
  final String cityName;
  final double temperature;
  final int humidity;
  final double rain;
  final String description;
  final String icon;
  final DateTime date;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.rain,
    required this.description,
    required this.icon,
    required this.date,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      rain: json['rain'] != null ? (json['rain']['1h'] ?? json['rain']['3h'] ?? 0.0).toDouble() : 0.0,
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
