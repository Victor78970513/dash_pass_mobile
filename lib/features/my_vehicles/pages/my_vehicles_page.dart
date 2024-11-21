import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/features/my_vehicles/widgets/vehiculo_card.dart';
import 'package:dash_pass/models/vehiculo_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyVehiclesPage extends StatelessWidget {
  const MyVehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mis Vehiculos",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      FontAwesomeIcons.car,
                      color: Colors.black,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_box_rounded,
                          color: Colors.black,
                          size: 40,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("vehiculos")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Muestra un indicador de carga mientras se esperan los datos
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      // Muestra un mensaje de error si la consulta falla
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.hasData) {
                      // Convierte los datos obtenidos a una lista de VehiculoModel
                      final vehicles = snapshot.data!.docs.map((doc) {
                        return VehiculoModel.fromJson(
                            doc.data() as Map<String, dynamic>);
                      }).toList();

                      // Construye la lista de vehículos
                      return ListView.builder(
                        itemCount: vehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = vehicles[index];
                          return VehiculoCard(vehiculo: vehicle);
                        },
                      );
                    } else {
                      // Si no hay datos, muestra un mensaje
                      return Center(child: Text('No vehicles available.'));
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
