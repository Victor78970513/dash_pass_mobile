import 'package:dash_pass/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final UserModel user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola, ${user.name} 👋',
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
                const Spacer(),
                Column(
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
                      "Bs. ${user.saldo}",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Último Pase Realizado
            Card(
              color: const Color(0xff4A90E2),
              child: ListTile(
                leading: const Icon(Icons.directions_car, color: Colors.white),
                title: Text(
                  'Último Pase Realizado',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Peaje: Autopista 1',
                        style: GoogleFonts.poppins(color: Colors.white70)),
                    Text('Fecha: 01/11/2024 10:30 am',
                        style: GoogleFonts.poppins(color: Colors.white70)),
                    Text('Monto: \$3.00',
                        style: GoogleFonts.poppins(color: Colors.white70)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mapa de Peajes Cercanos
            Card(
              color: const Color(0xff4A90E2),
              child: ListTile(
                leading: const Icon(Icons.map, color: Colors.white),
                title: Text('Mapa de Peajes Cercanos',
                    style: GoogleFonts.poppins(color: Colors.white)),
                trailing: TextButton(
                  onPressed: () {
                    // Acción para ver el mapa completo
                  },
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
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _buildHistoryTile(
                      'Autopista 1', '01/11/2024', '\$3.00', true),
                  _buildHistoryTile(
                      'Peaje Norte', '31/10/2024', '\$2.50', true),
                  _buildHistoryTile(
                      'Autopista 2', '30/10/2024', '\$3.00', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
