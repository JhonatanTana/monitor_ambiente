import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sensor.dart';

class SensorService {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  final String _table = 'sensores';


  Future<List<Sensor>> getMeasures() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _storage.collection(_table).get();

      return snapshot.docs
          .map((doc) => Sensor.fromMap(doc.data()))
          .toList();
    } catch (e) {
      debugPrint("Erro ao buscar medidas: $e");
      return [];
    }
  }

}