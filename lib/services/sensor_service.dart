import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monitor_ambiente/widgets/app_alert_dialog.dart';

import '../models/sensor.dart';

class SensorService {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  final String _table = 'sensores';


  Future<List<Sensor>> getMeasures() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _storage.collection(_table).orderBy("data", descending: true).get();

      return snapshot.docs
          .map((doc) => Sensor.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppAlertDialog.show(
        title: "Erro",
        content: "Erro ao buscar medidas. \n Erro: $e"
      );
      return [];
    }
  }

}