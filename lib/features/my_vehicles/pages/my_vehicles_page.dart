import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyVehiclesPage extends StatelessWidget {
  final List<Vehicle> vehicles = [
    Vehicle(
        plate: 'TN23DQ4546',
        model: 'Toyota',
        imagePath:
            'https://images.dealer.com/autodata/us/large_stockphoto/2025/USD50MBS961A0.jpg?impolicy=downsize_bkpt&imdensity=1&w=520',
        status: "OK"),
    Vehicle(
        plate: 'TN23DQ4546',
        model: 'Toyota',
        imagePath:
            'https://images.dealer.com/autodata/us/large_stockphoto/2025/USD50MBS961A0.jpg?impolicy=downsize_bkpt&imdensity=1&w=520',
        status: "OK"),
    Vehicle(
        plate: 'TN23DQ4546',
        model: 'Toyota',
        imagePath:
            'https://images.dealer.com/autodata/us/large_stockphoto/2025/USD50MBS961A0.jpg?impolicy=downsize_bkpt&imdensity=1&w=520',
        status: "OK"),
    Vehicle(
        plate: 'TN23DQ4546',
        model: 'Toyota',
        imagePath:
            'https://images.dealer.com/autodata/us/large_stockphoto/2025/USD50MBS961A0.jpg?impolicy=downsize_bkpt&imdensity=1&w=520',
        status: "OK"),
  ];

  MyVehiclesPage({super.key});

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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 60),
                    const Text(
                      "Mis Vehiculos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    return VehicleCard(vehicle: vehicle);
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

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     offset: const Offset(4, 4),
          //     blurRadius: 32,
          //     color: Colors.black.withOpacity(0.1),
          //   )
          // ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text(
                            vehicle.model,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(20))),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20)),
                        child: Image.network(
                          vehicle.imagePath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Vehicle {
  final String plate;
  final String model;
  final String imagePath;
  final String status;

  Vehicle({
    required this.plate,
    required this.model,
    required this.imagePath,
    required this.status, // "Activo" o "Inactivo"
  });
}
