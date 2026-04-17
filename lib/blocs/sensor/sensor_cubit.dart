import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/sensor.dart';
import '../../services/sensor_service.dart';
import 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  final SensorService _sensorService;

  SensorCubit(this._sensorService) : super(const SensorInitial());

  Future<void> fetchMeasures({SensorFilter filter = SensorFilter.day}) async {
    emit(SensorLoading(filter: filter));
    try {
      final allSensors = await _sensorService.getMeasures();
      final filteredSensors = _filterSensors(allSensors, filter);
      emit(SensorSuccess(filteredSensors, filter: filter));
    } catch (e) {
      emit(SensorError(e.toString(), filter: filter));
    }
  }

  List<Sensor> _filterSensors(List<Sensor> sensors, SensorFilter filter) {
    final now = DateTime.now();
    DateTime cutoff;

    switch (filter) {
      case SensorFilter.day:
        cutoff = now.subtract(const Duration(days: 1));
        break;
      case SensorFilter.week:
        cutoff = now.subtract(const Duration(days: 7));
        break;
      case SensorFilter.month:
        cutoff = now.subtract(const Duration(days: 30));
        break;
      case SensorFilter.all:
        return sensors;
    }

    return sensors.where((s) {
      if (s.date == null) return false;
      return s.date!.toDate().isAfter(cutoff);
    }).toList();
  }
}
