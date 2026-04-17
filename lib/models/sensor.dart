import 'package:cloud_firestore/cloud_firestore.dart';

class Sensor {
  Timestamp? date;
  double? temperature;
  double? humidity;

  Sensor({
    required this.date,
    required this.temperature,
    required this.humidity,
  });

  Sensor.fromMap(Map<String, dynamic> map)
      : date = map['data'],
        temperature = map['temperatura'],
        humidity = map['umidade'];

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['temperature'] = temperature;
    data['humidity'] = humidity;
    return data;
  }
}