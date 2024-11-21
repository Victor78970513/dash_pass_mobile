import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/features/pases/presentation/widgets/pase_detalle_card.dart';
import 'package:dash_pass/models/pase_detalle_model.dart';
import 'package:dash_pass/models/toll_model.dart';
import 'package:dash_pass/models/user_model.dart';
import 'package:dash_pass/models/vehiculo_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PasesPage extends StatelessWidget {
  const PasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = Preferences().userUUID;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mis Actividad",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                FontAwesomeIcons.road,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('pases')
                .where("id_usuario", isEqualTo: uid)
                .orderBy('fecha_creacion', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(
                      "Error al traer la data de pases: ${snapshot.error}"),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No hay datos disponibles."),
                );
              }

              final paseDetalles = snapshot.data!.docs.map((doc) async {
                final data = doc.data() as Map<String, dynamic>;
                final usuario = await fetchUsuario(data['id_usuario']);
                final vehiculo = await fetchVehiculo(data['id_vehiculo']);
                final peaje = await fetchPeaje(data['id_peaje']);

                return PaseDetalle(
                  idPase: data['id_pase'],
                  idPeaje: data['id_peaje'],
                  idUsuario: data['id_usuario'],
                  idVehiculo: data['id_vehiculo'],
                  monto: data['monto'].toDouble(),
                  pagoEstado: data['pago_estado'],
                  fechaCreacion: (data['fecha_creacion'] as Timestamp).toDate(),
                  usuario: usuario,
                  vehiculo: vehiculo,
                  peaje: peaje,
                );
              }).toList();

              // Esperar a que todos los futuros se completen
              return FutureBuilder<List<PaseDetalle>>(
                future: Future.wait(paseDetalles),
                builder: (context, paseSnapshot) {
                  if (paseSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (paseSnapshot.hasError) {
                    return Center(
                      child: Text(
                          "Error al procesar datos: ${paseSnapshot.error}"),
                    );
                  }
                  final pases = paseSnapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(pases.length, (index) {
                        final paseDetalle = pases[index];
                        return PaseDetalleCard(paseDetalle: paseDetalle);
                      }),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<UserModel> fetchUsuario(String userId) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .get();
    if (userDoc.exists) {
      return UserModel.fromMap(userDoc.data()!);
    }
    throw Exception('Usuario no encontrado');
  }

  Future<VehiculoModel> fetchVehiculo(String vehiculoId) async {
    final vehiculoDoc = await FirebaseFirestore.instance
        .collection('vehiculos')
        .doc(vehiculoId)
        .get();
    if (vehiculoDoc.exists) {
      return VehiculoModel.fromJson(vehiculoDoc.data()!);
    }
    throw Exception('Vehículo no encontrado');
  }

  Future<TollModel> fetchPeaje(String peajeId) async {
    final peajeDoc = await FirebaseFirestore.instance
        .collection('peajes')
        .doc(peajeId)
        .get();
    if (peajeDoc.exists) {
      return TollModel.fromMap(peajeDoc.data()!);
    }
    throw Exception('Peaje no encontrado');
  }
}
