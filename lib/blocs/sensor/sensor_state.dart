import 'package:equatable/equatable.dart';
import '../../models/sensor.dart';

enum SensorFilter { day, week, month, all }

abstract class SensorState extends Equatable {
  final SensorFilter filter;

  const SensorState({this.filter = SensorFilter.day});

  @override
  List<Object?> get props => [filter];
}

class SensorInitial extends SensorState {
  const SensorInitial({super.filter});
}

class SensorLoading extends SensorState {
  const SensorLoading({super.filter});
}

class SensorSuccess extends SensorState {
  final List<Sensor> sensors;

  const SensorSuccess(this.sensors, {super.filter});

  @override
  List<Object?> get props => [sensors, filter];
}

class SensorError extends SensorState {
  final String message;

  const SensorError(this.message, {super.filter});

  @override
  List<Object?> get props => [message, filter];
}
