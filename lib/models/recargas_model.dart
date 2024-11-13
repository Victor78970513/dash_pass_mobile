import 'package:cloud_firestore/cloud_firestore.dart';

class RecargasModel {
  final String idRecarga;
  final String idUsuario;
  final int monto;
  final String tipoPago;
  final DateTime createdAt;

  RecargasModel({
    required this.idRecarga,
    required this.idUsuario,
    required this.monto,
    required this.tipoPago,
    required this.createdAt,
  });

  factory RecargasModel.fromJson(Map<String, dynamic> map) {
    return RecargasModel(
      idRecarga: map["id_recarga"],
      idUsuario: map["id_usuario"],
      monto: map["monto"],
      tipoPago: map["tipo_pago"],
      createdAt: (map["created_at"] as Timestamp).toDate(),
    );
  }
}
