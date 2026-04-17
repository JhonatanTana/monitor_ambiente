import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/sensor_service.dart';
import 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  final SensorService _sensorService;

  SensorCubit(this._sensorService) : super(SensorInitial());

  Future<void> fetchMeasures() async {
    emit(SensorLoading());
    try {
      final sensors = await _sensorService.getMeasures();
      emit(SensorSuccess(sensors));
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }
}
