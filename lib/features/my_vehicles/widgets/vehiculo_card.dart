import 'package:dash_pass/models/vehiculo_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehiculoCard extends StatelessWidget {
  final VehiculoModel vehiculo;

  const VehiculoCard({Key? key, required this.vehiculo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del vehículo
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: vehiculo.image.isNotEmpty
                ? Image.network(
                    vehiculo.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título con la marca y modelo del vehículo
                Text('${vehiculo.marca} ${vehiculo.modelo}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                Text(vehiculo.tipoVehiculo,
                    style: GoogleFonts.poppins(color: Colors.grey[300])),
                const SizedBox(height: 12),
                // Información del vehículo
                _buildInfoRow(Icons.directions_car, 'Placa: ${vehiculo.placa}'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.credit_card, 'Chasis: ${vehiculo.chasis}'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.format_list_numbered,
                    'Registro: ${vehiculo.numeroRegisgtro}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.directions_car,
          size: 64,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
