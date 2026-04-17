import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monitor_ambiente/models/weather_model.dart';

class WeatherService {
  static const String _apiKey = '';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=pt_br'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar dados do clima: ${response.statusCode}');
    }
  }
}
