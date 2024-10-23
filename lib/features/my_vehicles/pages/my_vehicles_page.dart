import 'package:flutter/material.dart';

class MyVehiclesPage extends StatelessWidget {
  final List<Vehicle> vehicles = [
    Vehicle('TN23DQ4546', 'Toyota', 'assets/images/toyota_tacoma.jpg'),
    Vehicle('TN33GH7896', 'Suzuki', 'assets/images/toyota_tacoma.jpg'),
    Vehicle('TN83DF4568', 'Renault', 'assets/images/toyota_tacoma.jpg'),
    Vehicle('TN65DG6765', 'Hyundai', 'assets/images/toyota_tacoma.jpg'),
  ];

  MyVehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: const Color(0xff0B6D6D),
          height: size.height * 0.3,
          width: double.infinity,
        ),
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
            ],
          ),
        ),
      ],
    ));
  }
}

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  vehicle.imagePath,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.plate,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vehicle.model,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff62B6B7),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Ver Detalles",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
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

  Vehicle(this.plate, this.model, this.imagePath);
}
