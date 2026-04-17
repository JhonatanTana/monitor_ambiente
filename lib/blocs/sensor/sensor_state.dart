import 'package:equatable/equatable.dart';
import '../../models/sensor.dart';

abstract class SensorState extends Equatable {
  const SensorState();

  @override
  List<Object?> get props => [];
}

class SensorInitial extends SensorState {}

class SensorLoading extends SensorState {}

class SensorSuccess extends SensorState {
  final List<Sensor> sensors;

  const SensorSuccess(this.sensors);

  @override
  List<Object?> get props => [sensors];
}

class SensorError extends SensorState {
  final String message;

  const SensorError(this.message);

  @override
  List<Object?> get props => [message];
}
