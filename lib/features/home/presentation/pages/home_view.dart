import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/core/shared_preferences/preferences.dart';
import 'package:dash_pass/models/pase_detalle_model.dart';
import 'package:dash_pass/models/pase_model.dart';
import 'package:dash_pass/models/toll_model.dart';
import 'package:dash_pass/models/user_model.dart';
import 'package:dash_pass/models/vehiculo_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final UserModel user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final uid = Preferences().userUUID;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("usuarios")
                    .where("id_usuario", isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final usuario =
                        UserModel.fromMap(snapshot.data!.docs.first.data());
                    return Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hola, ${usuario.name}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Bienvenido!',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Saldo Disponible',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Bs. ${usuario.saldo}",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(height: 16),

            // Último Pase Realizado
            Text(
              'Ultima Actividad',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("pases")
                    .orderBy("fecha_creacion", descending: true)
                    .where("id_usuario", isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error al cargar datos"));
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final pase =
                        PasesModel.fromJson(snapshot.data!.docs.first.data());
                    return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('peajes')
                            .doc(pase.idPeaje)
                            .get(),
                        builder: (context, peajeSnapshot) {
                          if (peajeSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (peajeSnapshot.hasError) {
                            return const Center(
                                child: Text("Error al cargar el peaje"));
                          }
                          if (peajeSnapshot.hasData &&
                              peajeSnapshot.data!.exists) {
                            final peaje =
                                TollModel.fromMap(peajeSnapshot.data!.data()!);
                            return Card(
                              color: const Color(0xff4A90E2),
                              child: ListTile(
                                leading: const Icon(Icons.directions_car,
                                    color: Colors.white),
                                title: Text(
                                  'Último Pase Realizado',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Peaje: ${peaje.name}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white70)),
                                    Text('Fecha: ${peaje.createdAt}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white70)),
                                    Text('Monto: Bs. ${pase.monto}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white70)),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const Center(
                              child: Text("No se encontró el peaje"));
                        });
                  }
                  return const Center(child: Text("No hay pases disponibles"));
                }),
            const SizedBox(height: 16),

            // Mapa de Peajes Cercanos
            Card(
              color: const Color(0xff4A90E2),
              child: ListTile(
                leading: const Icon(Icons.map, color: Colors.white),
                title: Text('Mapa de Peajes',
                    style: GoogleFonts.poppins(color: Colors.white)),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Ver mapa completo',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Accesos Rápidos
            Text(
              'Accesos Rápidos',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAccessIcon(
                    context, Icons.account_balance_wallet, 'Recargas'),
                _buildQuickAccessIcon(
                    context, Icons.directions_car, 'Vehículos'),
                _buildQuickAccessIcon(context, Icons.receipt, 'Pases'),
                _buildQuickAccessIcon(context, Icons.person, 'Perfil'),
              ],
            ),
            const SizedBox(height: 16),

            // Historial Resumido
            Text(
              'Historial Resumido',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: const Color(0xff4A90E2),
              // child: ListView(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     _buildHistoryTile(
              //         'Autopista 1', '01/11/2024', '\$3.00', true),
              //     _buildHistoryTile(
              //         'Peaje Norte', '31/10/2024', '\$2.50', true),
              //     _buildHistoryTile(
              //         'Autopista 2', '30/10/2024', '\$3.00', false),
              //   ],
              // ),
              child: Expanded(
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
                        fechaCreacion:
                            (data['fecha_creacion'] as Timestamp).toDate(),
                        usuario: usuario,
                        vehiculo: vehiculo,
                        peaje: peaje,
                      );
                    }).toList();

                    // Esperar a que todos los futuros se completen
                    return FutureBuilder<List<PaseDetalle>>(
                      future: Future.wait(paseDetalles),
                      builder: (context, paseSnapshot) {
                        if (paseSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                        }

                        if (paseSnapshot.hasError) {
                          return Center(
                            child: Text(
                                "Error al procesar datos: ${paseSnapshot.error}"),
                          );
                        }
                        final pases = paseSnapshot.data!;
                        final maxPases = pases.take(3).toList();
                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(maxPases.length, (index) {
                              final paseDetalle = maxPases[index];
                              return _buildHistoryTile(
                                  paseDetalle.peaje.name,
                                  "${paseDetalle.fechaCreacion.day}/${paseDetalle.fechaCreacion.month}/${paseDetalle.fechaCreacion.year}",
                                  '\$3.00',
                                  false);
                            }),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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

  // Widget de icono de acceso rápido
  Widget _buildQuickAccessIcon(
      BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30, color: const Color(0xff4A90E2)),
          onPressed: () {
            // Acción para cada acceso rápido
          },
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildHistoryTile(
      String peaje, String fecha, String monto, bool show) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.history,
              color: Colors.white,
              size: 30,
            ),
            title: Text(peaje,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
            subtitle: Text(
              fecha,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
            ),
            trailing: Text(monto,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
